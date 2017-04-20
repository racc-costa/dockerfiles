FROM racccosta/rhel-jdk:6.8
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Copying files
COPY supervisord.conf /etc/supervisord.conf

# Installing JBoss
ENV JBOSS_VERSION 7.0
ENV JBOSS_HOME /opt/jboss-eap-$JBOSS_VERSION
ENV LAUNCH_JBOSS_IN_BACKGROUND true
COPY jboss-eap-7.0 $JBOSS_HOME
RUN $JBOSS_HOME/bin/add-user.sh -s admin admin123!

USER root
WORKDIR /root

EXPOSE 22 4447 8080 8443 8787 9990 9993

CMD ["/usr/bin/supervisord"]
