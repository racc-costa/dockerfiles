FROM registry.access.redhat.com/rhel6.8:6.8
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Environment variables
ENV JAVA_HOME=/opt/jdk1.8.0_121
ENV PATH=$JAVA_HOME/bin:$PATH

# Copying files
COPY rhel-source.repo /etc/yum.repos.d/rhel-source.repo 

# Installing JDK
RUN cd /opt/ && \
  curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -O http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz  && \
  tar -xzf jdk-8u121-linux-x64.tar.gz  && \
  rm -rf jdk-8u121-linux-x64.tar.gz
