FROM debian:jessie
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Add our user and group for redis
RUN groupadd -r redis && useradd -r -g redis redis

# Updating and installing some tools including ruby
RUN apt-get update \
	&& apt-get install -y --no-install-recommends ca-certificates wget \
	&& apt-get install -y ruby \
	&& gem install redis \
	&& rm -rf /var/lib/apt/lists/*

# Redis variables
ENV REDIS_VERSION 3.2.8
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.8.tar.gz
ENV REDIS_DOWNLOAD_SHA1 6780d1abb66f33a97aad0edbe020403d0a15b67f
ENV REDIS_DIR /usr/redis

# Copying settings
RUN mkdir $REDIS_DIR
COPY redis.conf         $REDIS_DIR/redis.conf  
COPY redis-cluster.conf $REDIS_DIR/redis-cluster.conf

# Downloading, unpacking and compiling Redis
RUN set -ex \
	\
	&& buildDeps=' \
		gcc \
		libc6-dev \
		make \
	' \
	&& apt-get update \
	&& apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL" \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& cp /usr/src/redis/src/redis-trib.rb $REDIS_DIR/redis-trib.rb \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -r /usr/src/redis
	
# Persistence folder	
RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

EXPOSE 6379
CMD ["redis-server", "/usr/redis/redis.conf"]