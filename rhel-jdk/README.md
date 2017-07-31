# Red Hat Enterprise Linux image with Oracle JDK and Red Hat Enterprise Linux image with OpenSSH Server and Oracle JDK

This image is based on the official version of Red Hat Enterprise Linux with Oracle JDK.


# Supported tags and respective `Dockerfile` links

-	[7.3 (7.3/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel-jdk/Dockerfile)
-	[7.3-SSH (7.3-SSH/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel-jdk/Dockerfile-SSH)
-	[6.8 (6.8/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel-jdk/Dockerfile68)
-	[6.8-SSH (6.8-SSH/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel-jdk/Dockerfile68-SSH)


## Usage

To run:

	docker run -it --name server racccosta/rhel-jdk:7.3
	docker run -d -p 22:22 --name server racccosta/rhel-jdk:7.3-SSH

	docker run -it --name server racccosta/rhel-jdk:6.8
	docker run -d -p 22:22 --name server racccosta/rhel-jdk:6.8-SSH

Client can access SSH as 'root' with password 'developer' on SSH tags.


## Source

The source is available on [GitHub](https://github.com/racc-costa/dockerfiles/tree/master/rhel-jdk).


## Issues

Please report any issues on [GitHub](https://github.com/racc-costa/dockerfiles/issues).
