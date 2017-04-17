FROM registry.access.redhat.com/rhel7/rhel:6.8
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Environment variables
ENV JAVA_HOME=/opt/jdk1.8.0_121
ENV PATH=$JAVA_HOME/bin:$PATH

# Copying files
COPY rhel-source.repo /etc/yum.repos.d/rhel-source.repo 

# Installing JDK
RUN cd /opt/ && \
	curl -OL ftp://fr2.rpmfind.net/linux/centos/7/os/x86_64/Packages/wget-1.14-13.el7.x86_64.rpm && \ 
	yum install -y wget-1.14-13.el7.x86_64.rpm && \
	yum clean all && \
	rm -rf wget-1.14-13.el7.x86_64.rpm && \ 
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz" && \
	tar -xzf jdk-8u121-linux-x64.tar.gz && \
  	rm -rf jdk-8u121-linux-x64.tar.gz 
  
