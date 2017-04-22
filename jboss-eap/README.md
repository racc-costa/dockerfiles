# JBoss Enterprise Application Platform on Red Hat Enterprise Linux image with OpenSSH Server and Oracle JDK

This image contains the developer version of JBoss Enterprise Application Platform on Red Hat Enterprise Linux image  with OpenSSH Server and Oracle JDK.


# Supported tags and respective `Dockerfile` links

-	[7.0 (7.0/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/jboss-eap/Dockerfile)

## Usage

To run:

	docker run -d -p 8080:8080 -p 8443:8443 -p 9990:9990 --name eap7 racccosta/jboss-eap:7.0

or with all ports:

	docker run -d  -p 22:22 -p 8080:8080 -p 8443:8443  -p 8787:8787  -p 9990:9990 --name eap7  racccosta/jboss-eap:7.0

Client can access SSH as 'root' with password 'developer'.
Remote debug is enabled at port 8787.

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
