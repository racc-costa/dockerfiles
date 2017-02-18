## Redis

Image with Redis and ruby.

## Run

Start as standalone:

	docker run -d -p 6379:6379 --name redis-sa racccosta/redis:3.2.8
	
	docker exec redis-sa redis-cli set 1 "Redis is ok"
	docker exec redis-sa redis-cli get 1

Start as a master / 2 slaves (Replication) :

	docker run -d -p 6380:6379 --name redis-m racccosta/redis:3.2.8
	docker run -d -p 6381:6379 --name redis-s1 --link redis-m racccosta/redis:3.2.8 redis-server /usr/redis/redis.conf --slaveof redis-m 6379
	docker run -d -p 6382:6379 --name redis-s2 --link redis-m racccosta/redis:3.2.8 redis-server /usr/redis/redis.conf --slaveof redis-m 6379
	
	docker exec redis-m redis-cli set 1 "Redis is OK on Master"
	docker exec redis-s1 redis-cli get 1
	docker exec redis-s2 redis-cli get 1

Create a cluster (Sharding):

	docker network create redis-net
	docker run -d -p 6385:6379 --name redis-c1 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6386:6379 --name redis-c2 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6387:6379 --name redis-c3 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6388:6379 --name redis-c4 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6389:6379 --name redis-c5 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	docker run -d -p 6390:6379 --name redis-c6 --net redis-net racccosta/redis:3.2.8 redis-server /usr/redis/redis-cluster.conf
	
	docker exec -it redis-c1 /usr/redis/redis-trib.rb create --replicas 1 172.18.0.2:6379 172.18.0.3:6379 172.18.0.4:6379 172.18.0.5:6379 172.18.0.6:6379 172.18.0.7:6379
	
	docker exec redis-c1 redis-cli set 1 "Redis is OK on Cluster"

## Ports
* **6379**

## Volumes
/data