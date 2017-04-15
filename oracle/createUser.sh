#!/bin/bash

ORACLE_USR=$1
ORACLE_PWD=$2

su -p oracle -c "sqlplus / as sysdba << EOF
      CREATE USER "$ORACLE_USR" IDENTIFIED BY "$ORACLE_PWD";
      exit;
EOF"
