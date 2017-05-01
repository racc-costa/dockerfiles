# JBoss Enterprise Application Platform on Red Hat Enterprise Linux image.

This image contains the developer version of JBoss Enterprise Application Platform on Red Hat Enterprise Linux image  with OpenSSH Server and Oracle JDK.


# Supported tags and respective `Dockerfile` links

-	[7.0 (7.0/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/jboss-eap/Dockerfile)
-	[7.0-SSH (7.0-SSH/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/jboss-eap/Dockerfile-SSH)


## Usage

To run:

	docker run -d -p 8080:8080 -p 8443:8443 -p 9990:9990 --name eap7 racccosta/jboss-eap:7.0
	docker run -d -p 8080:8080 -p 8443:8443 -p 9990:9990 --name eap7 racccosta/jboss-eap:7.0 /opt/jboss-eap-7.0/bin/standalone.sh --debug -bmanagement 0.0.0.0 -b 0.0.0.0

	docker run -d -p 22:22 -p 8080:8080 -p 8443:8443 -p 9990:9990 --name eap7 racccosta/jboss-eap:7.0-SSH
	docker run -d -p 22:22 -p 8080:8080 -p 8443:8443 -p 9990:9990 --name eap7 racccosta/jboss-eap:7.0-SSH /usr/bin/supervisord -c /etc/supervisord-debug.conf


Client can access SSH as 'root' with password 'developer'.


## How to test

http://localhost:9990

login: admin
password: admin123!


## JBoss EAP documentation

JBoss Enterprise Application Platform documentation is avaliable on [JBoss Enterprise Application Platform documentation](https://access.redhat.com/documentation/pt/red-hat-jboss-enterprise-application-platform/).


## Source

The source is available on [GitHub](https://github.com/racc-costa/dockerfiles/tree/master/jboss-eap).
Before you can build the image, download JBoss EAP 7.0 from http://www.jboss.org/products/eap/download/ in this directory.


## Issues

Please report any issues on [GitHub](https://github.com/racc-costa/dockerfiles/issues).
