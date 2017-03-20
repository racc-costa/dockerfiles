# Unofficial Oracle Database image

This image contains Oracle Database.


# Supported tags and respective `Dockerfile` links

-	[11.2.0.2-xe (11.2.0.2-xe/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/oracle/Dockerfile)

## Usage


To run:

	docker run -d -p 1521:1521 -p 8080:8080 --name oracle --shm-size=1g -v /app/data:/u01/app/oracle/oradata racccosta/oracle:11.2.0.2-xe
	

## How to test


Wait about 2 minutes until log shows Oracle is ready to use!

	docker logs -f oracle 	


Using sqlplus:

	docker exec -it oracle sqlplus system/oracle@localhost:1521/xe 


Using Oracle Application Express:

	http://localhost:8080/apex

Workspace: internal

Username: admin

Password: oracle


## Persistence folder	
-	/u01/app/oracle/oradata


## Oracle documentation
Oracle 12g Release 2 (12.2) documentation is avaliable on [Oracle Database Online Documentation 12g Release 2 (12.2)](http://www.oracle.com/technetwork/database/enterprise-edition/documentation/database-093888.html).

Oracle 11g Release 2 (11.2) documentation is available on [Oracle Database Online Documentation 11g Release 2 (11.2)](http://docs.oracle.com/cd/E11882_01/index.htm).


## Source

The source is available on [GitHub](https://github.com/racc-costa/dockerfiles/tree/master/oracle).


## Issues

Please report any issues on [GitHub](https://github.com/racc-costa/dockerfiles/issues).
