FROM racccosta/rhel-jdk:7.3
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

LABEL name="racccosta/jboss-eap" \
 maintainer="Ricardo Costa <racc.costa@gmail.com>" \
 summary="JBoss Enterprise Application Platform 7.0" \
 description="JBoss Enterprise Application Platform 7.0"

# Installing JBoss
ENV JBOSS_VERSION 7.0
ENV JBOSS_HOME /opt/jboss-eap-$JBOSS_VERSION
ENV LAUNCH_JBOSS_IN_BACKGROUND true
COPY jboss-eap-7.0 $JBOSS_HOME
RUN $JBOSS_HOME/bin/add-user.sh -s admin admin123!

EXPOSE 4447 8080 8443 8787 9990 9993

CMD $JBOSS_HOME/bin/standalone.sh -bmanagement 0.0.0.0 -b 0.0.0.0
