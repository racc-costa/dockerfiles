FROM registry.access.redhat.com/rhel7/rhel:7.3-79
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

RUN cd /opt/ && \
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz" && \
  tar xzf jdk-8u121-linux-x64.tar.gz && \
  export JAVA_HOME=/opt/jdk1.8.0_121 && \
  export PATH=$PATH:/opt/jdk1.8.0_121/bin
