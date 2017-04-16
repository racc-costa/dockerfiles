#!/bin/bash

function moveFiles {
   if [ ! -d $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID ]; then
      su -p oracle -c "mkdir -p $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/"
   fi;

   su -p oracle -c "mv $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/"
   su -p oracle -c "mv $ORACLE_HOME/dbs/orapw$ORACLE_SID $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/"
   su -p oracle -c "mv $ORACLE_HOME/network/admin/tnsnames.ora $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/"
   su -p oracle -c "mv $ORACLE_HOME/network/admin/listener.ora $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/"
   mv /etc/sysconfig/oracle-xe $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/

   symLinkFiles;
}

function symLinkFiles {

   if [ ! -L $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora ]; then
      ln -s $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/spfile$ORACLE_SID.ora $ORACLE_HOME/dbs/spfile$ORACLE_SID.ora
   fi;

   if [ ! -L $ORACLE_HOME/dbs/orapw$ORACLE_SID ]; then
      ln -s $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/orapw$ORACLE_SID $ORACLE_HOME/dbs/orapw$ORACLE_SID
   fi;

   if [ ! -L $ORACLE_HOME/network/admin/tnsnames.ora ]; then
      ln -sf $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/tnsnames.ora $ORACLE_HOME/network/admin/tnsnames.ora
   fi;

   if [ ! -L $ORACLE_HOME/network/admin/listener.ora ]; then
      ln -sf $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/listener.ora $ORACLE_HOME/network/admin/listener.ora
   fi;

   if [ ! -L /etc/sysconfig/oracle-xe ]; then
      ln -s $ORACLE_BASE/oradata/dbconfig/$ORACLE_SID/oracle-xe /etc/sysconfig/oracle-xe
   fi;
}

function _term() {
   echo "Stopping container."
   echo "SIGTERM received, shutting down database!"
  /etc/init.d/oracle-xe stop
}

function _kill() {
   echo "SIGKILL received, shutting down database!"
   /etc/init.d/oracle-xe stop
}

function createDB {
   /etc/init.d/oracle-xe configure responseFile=$ORACLE_BASE/$ORACLE_RSP

   echo "LISTENER = \
  (DESCRIPTION_LIST = \
    (DESCRIPTION = \
      (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC_FOR_XE)) \
      (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521)) \
    ) \
  ) \
\
" > $ORACLE_HOME/network/admin/listener.ora

   echo "DEDICATED_THROUGH_BROKER_LISTENER=ON"  >> $ORACLE_HOME/network/admin/listener.ora && \
   echo "DIAG_ADR_ENABLED = off"  >> $ORACLE_HOME/network/admin/listener.ora;

   su -p oracle -c "sqlplus / as sysdba <<EOF
      EXEC DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);

      ALTER DATABASE ADD LOGFILE GROUP 4 ('$ORACLE_BASE/oradata/$ORACLE_SID/redo04.log') SIZE 50m;
      ALTER DATABASE ADD LOGFILE GROUP 5 ('$ORACLE_BASE/oradata/$ORACLE_SID/redo05.log') SIZE 50m;
      ALTER DATABASE ADD LOGFILE GROUP 6 ('$ORACLE_BASE/oradata/$ORACLE_SID/redo06.log') SIZE 50m;
      ALTER SYSTEM SWITCH LOGFILE;
      ALTER SYSTEM SWITCH LOGFILE;
      ALTER SYSTEM DISABLE RESTRICTED SESSION;
      ALTER SYSTEM CHECKPOINT;
      ALTER DATABASE DROP LOGFILE GROUP 1;
      ALTER DATABASE DROP LOGFILE GROUP 2;

      ALTER SYSTEM SET db_recovery_file_dest='';
      exit;
EOF"

  moveFiles;
}

function createUser() {
  su -p oracle -c "sqlplus / as sysdba << EOF
        CREATE USER "$ORACLE_USR" IDENTIFIED BY "$ORACLE_PWD";
        GRANT CREATE SESSION TO "$ORACLE_USR";
        GRANT ALL PRIVILEGES TO "$ORACLE_USR";
        exit;
  EOF"
  echo "User created: $ORACLE_USR"
}

# MAIN ------------------------------------------------------------------------

echo -e "\n\nStarting Oracle - $(date)"
echo -e "----------------------------------------------\n"
if [ `df -k /dev/shm | tail -n 1 | awk '{print $2}'` -lt 1048576 ]; then
   echo "Error: The container doesn't have enough memory allocated."
   echo "A database XE container needs at least 1 GB of shared memory (/dev/shm)."
   echo "You currently only have $((`df -k /dev/shm | tail -n 1 | awk '{print $2}'`/1024)) MB allocated to the container."
   exit 1;
fi;

trap _term SIGTERM

trap _kill SIGKILL

if [ -d $ORACLE_BASE/oradata/$ORACLE_SID ]; then
   symLinkFiles;
   if [ ! -d $ORACLE_BASE/admin/$ORACLE_SID/adump ]; then
      su -p oracle -c "mkdir -p $ORACLE_BASE/admin/$ORACLE_SID/adump"
   fi;
fi;

/etc/init.d/oracle-xe start | grep -qc "Oracle Database 11g Express Edition is not configured"
if [ "$?" == "0" ]; then
   createDB;
fi;

if [ ! -L $ORACLE_USR ] && [ ! -L $ORACLE_PWD ]; then
  createUser;
fi;

echo -e "\n\nOracle is ready to use! - $(date)"
echo -e "----------------------------------------------\n"

tail -f $ORACLE_BASE/diag/rdbms/*/*/trace/alert*.log &
childPID=$!
wait $childPID
