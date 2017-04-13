FROM registry.access.redhat.com/rhel7/rhel:7.3-79
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

RUN curl -OL ftp://fr2.rpmfind.net/linux/centos/7.3.1611/os/x86_64/Packages/tar-1.26-31.el7.x86_64.rpm && \
	curl -OL ftp://fr2.rpmfind.net/linux/centos/7.3.1611/os/x86_64/Packages/wget-1.14-13.el7.x86_64.rpm && \ 
	yum install -y tar-1.26-31.el7.x86_64.rpm && \
	yum install -y wget-1.14-13.el7.x86_64.rpm && \
  yum clean all && \
	rm -rf tar-1.26-31.el7.x86_64.rpm && \
	rm -rf wget-1.14-13.el7.x86_64.rpm && \ 
	cd /opt/ && \
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz" && \
	tar -xzf jdk-8u121-linux-x64.tar.gz && \
  rm -rf jdk-8u121-linux-x64.tar.gz && \ 
	export JAVA_HOME=/opt/jdk1.8.0_121 && \
	export PATH=$PATH:/opt/jdk1.8.0_121/bin
  
