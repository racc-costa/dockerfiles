# Red Hat Enterprise Linux image with OpenSSH

This image contains the official version of Red Hat Enterprise Linux with OpenSSH.


# Supported tags and respective `Dockerfile` links

-	[7.3 (7.3/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel/Dockerfile)
-	[6.8 (7.3/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/rhel/Dockerfile)

## Usage


To run:

	docker run -d -p 22:22 --name redhat -it racccosta/rhel:7.3
 
Client can access SSH as root without password.

## Source

The source is available on [GitHub](https://github.com/racc-costa/dockerfiles/tree/master/rhel).


## Issues

Please report any issues on [GitHub](https://github.com/racc-costa/dockerfiles/issues).
