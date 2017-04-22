# Red Hat Enterprise Linux image with OpenSSH Server and Oracle JDK

This image contains the official version of Red Hat Enterprise Linux OpenSSH Server and Oracle JDK.


# Supported tags and respective `Dockerfile` links

-	[7.3 (7.3/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel-jdk/Dockerfile)
-	[6.8 (6.8/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel-jdk/Dockerfile68)

## Usage

To run:

	docker run -d -p 22:22 --name redhat racccosta/rhel-jdk:7.3

	docker run -d -p 22:22 --name redhat racccosta/rhel-jdk:6.8

Client can access SSH as 'root' with password 'developer'.

## Source

The source is available on [GitHub](https://github.com/racc-costa/dockerfiles/tree/master/rhel-jdk).


## Issues

Please report any issues on [GitHub](https://github.com/racc-costa/dockerfiles/issues).
