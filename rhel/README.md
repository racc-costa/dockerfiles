# Red Hat Enterprise Linux image and Red Hat Enterprise Linux image with OpenSSH Server

This image is based on the official version of Red Hat Enterprise Linux .


# Supported tags and respective `Dockerfile` links

-	[7.3 (7.3/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel/Dockerfile73)
-	[7.3-SSH (7.3-SSH/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel/Dockerfile73-SSH)
-	[6.8 (6.8/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel/Dockerfile68)
-	[6.8-SSH (6.8-SSH/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel/Dockerfile68-SSH)


## Usage

To run:

	docker run -it --name server racccosta/rhel:7.3
	docker run -d -p 22:22 --name server racccosta/rhel:7.3-SSH

	docker run -it --name server racccosta/rhel:6.8
	docker run -d -p 22:22 --name server racccosta/rhel:6.8-SSH

Client can access SSH as 'root' with password 'developer' on SSH tags.


## Source

The source is available on [GitHub](https://github.com/racc-costa/dockerfiles/tree/master/rhel).


## Issues

Please report any issues on [GitHub](https://github.com/racc-costa/dockerfiles/issues).
