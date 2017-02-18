# Unofficial Redis Docker image

This image contains the official version of Redis ([http://download.redis.io/releases](http://download.redis.io/releases)) and the dependencies for running Ruby scripts such as redis-trib.br that provides resources for clustering.


# Supported tags and respective `Dockerfile` links

-	[3.2.8 (3.2.8/Dockerfile)](https://github.com/racc-costa/dockerfiles/blob/master/redis/Dockerfile)

## Usage


To boot in standalone mode:

	docker run -d -p 6379:6379 --name redis racccosta/redis:3.2.8
	

To build a master with 2 slaves (Replication):

	docker network create redis-net
	docker run -d -p 6380:6379 --name redis    --net redis-net racccosta/redis:3.2.8
	docker run -d -p 6381:6379 --name redis-s1 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis.conf --slaveof redis 6379
	docker run -d -p 6382:6379 --name redis-s2 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis.conf --slaveof redis 6379


To create a cluster with 3 master and 3 replicas (Sharding):

	docker network create redis-net
	docker run -d -p 6385:6379 --name redis-c1 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6386:6379 --name redis-c2 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6387:6379 --name redis-c3 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6388:6379 --name redis-c4 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6389:6379 --name redis-c5 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6390:6379 --name redis-c6 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	
	docker exec -it redis-c1 /usr/redis/redis-trib.rb create --replicas 1 172.18.0.2:6379 172.18.0.3:6379 172.18.0.4:6379 172.18.0.5:6379 172.18.0.6:6379 172.18.0.7:6379


To build a master with 2 slaves (Replication) and 3 Sentinels (High availability):

	docker network create redis-net
	docker run -d -p 6380:6379 --name redis    --net redis-net racccosta/redis:3.2.8
	docker run -d -p 6381:6379 --name redis-s1 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis.conf --slaveof redis 6379
	docker run -d -p 6382:6379 --name redis-s2 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis.conf --slaveof redis 6379

	docker run -d -p 6395:6379 --name sentinel1 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/sentinel.conf --sentinel
	docker run -d -p 6396:6379 --name sentinel2 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/sentinel.conf --sentinel
	docker run -d -p 6397:6379 --name sentinel3 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/sentinel.conf --sentinel
	
	docker exec sentinel1 redis-cli SENTINEL MONITOR redis 172.18.0.2 6379 2 
	docker exec sentinel2 redis-cli SENTINEL MONITOR redis 172.18.0.2 6379 2 
	docker exec sentinel3 redis-cli SENTINEL MONITOR redis 172.18.0.2 6379 2 
	
	docker exec sentinel1 redis-cli SENTINEL SET redis down-after-milliseconds 3000
	docker exec sentinel2 redis-cli SENTINEL SET redis down-after-milliseconds 3000
	docker exec sentinel3 redis-cli SENTINEL SET redis down-after-milliseconds 3000
	
	docker exec sentinel1 redis-cli SENTINEL SET redis failover-timeout 180000
	docker exec sentinel2 redis-cli SENTINEL SET redis failover-timeout 180000
	docker exec sentinel3 redis-cli SENTINEL SET redis failover-timeout 180000
	
	docker exec sentinel1 redis-cli SENTINEL SET redis parallel-syncs 5
	docker exec sentinel2 redis-cli SENTINEL SET redis parallel-syncs 5
	docker exec sentinel3 redis-cli SENTINEL SET redis parallel-syncs 5
	

## How to test


Testing standalone mode:

	docker exec redis redis-cli set 1 "Redis is ok"
	docker exec redis redis-cli get 1


Testing  master with 2 slaves (Replication):

	docker exec redis redis-cli set 1 "Redis is OK on Master"
	docker exec redis    redis-cli get 1
	docker exec redis-s1 redis-cli get 1
	docker exec redis-s2 redis-cli get 1


Testing a cluster with 3 master and 3 replicas (Sharding):

	docker exec redis-c1 redis-cli set 1 "Redis is OK on Cluster"


Testing Sentinel (Failover):

Go to [Testing the failover](https://github.com/racc-costa/dockerfiles/tree/master/redis).


## Persistence folder	
-	/data


## Redis documentation
Redis documentation is available on [Redis website](https://redis.io).


## Source

The source is available on [GitHub](https://redis.io/topics/sentinel).


## Issues

Please report any issues on [GitHub](https://github.com/racc-costa/dockerfiles/issues).
