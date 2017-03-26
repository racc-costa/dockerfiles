FROM oraclelinux:7-slim
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Environment variables
ENV ORACLE_BASE=/u01/app/oracle \
	ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe \
	ORACLE_SID=XE \
	ORACLE_RPM="oracle-xe-11.2.0-1.0.x86_64.rpm.zip" \
	ORACLE_DIR="$HOME/install" \
	ORACLE_RSP="oracle.rsp" \
	START_FILE="startOracle.sh" \
	PWD_FILE="setPassword.sh"

ENV PATH=$ORACLE_HOME/bin:$PATH

# Copying files
COPY oracle_rpmaa oracle_rpmab oracle_rpmac oracle_rpmad $ORACLE_RSP $START_FILE $PWD_FILE $ORACLE_DIR/

# Installing SSH and Supervisor
RUN yum -y install openssh-server supervisor && yum clean all
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/run/sshd /var/log/supervisor

# Updating and installing Oracle
RUN yum -y install unzip libaio bc initscripts net-tools openssl openssh-server supervisor && \
	yum clean all && \
	mv /usr/bin/free /usr/bin/free.bak && \
	printf "#!/bin/sh\necho Swap - - 2048" > /usr/bin/free && \
	chmod +x /usr/bin/free && \
	cd $ORACLE_DIR && \
	cat oracle_rpm* > $ORACLE_RPM && \
	unzip $ORACLE_RPM && \
	rm $ORACLE_RPM &&    \
	rpm -i Disk1/*.rpm &&    \
	mv /usr/bin/free.bak /usr/bin/free && \
	mkdir $ORACLE_BASE/oradata && \
	chown -R oracle:dba $ORACLE_BASE && \
	mv $ORACLE_DIR/$ORACLE_RSP $ORACLE_BASE/ && \
	mv $ORACLE_DIR/$START_FILE $ORACLE_BASE/ && \
	mv $ORACLE_DIR/$PWD_FILE $ORACLE_BASE/ && \
	ln -s $ORACLE_BASE/$PWD_FILE / && \
	cd $HOME && \
	rm -rf $ORACLE_DIR && \
	chmod u+x $ORACLE_BASE/$START_FILE && \
	chmod u+x $ORACLE_BASE/$PWD_FILE

# Persistence folder
VOLUME ["$ORACLE_BASE/oradata"]

EXPOSE 22 1521 8080
CMD ["/usr/bin/supervisord"]
