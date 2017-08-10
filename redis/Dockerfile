FROM debian:stretch-slim
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

# Add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S redis && adduser -S -G redis redis

# Updating and installing some tools including ruby
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	wget \
	ruby \
	&& rm -rf /var/lib/apt/lists/*

RUN gem install redis \
	&& rm -rf /var/lib/apt/lists/*

# Redis variables
ENV REDIS_VERSION 4.0.1
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-4.0.1.tar.gz
ENV REDIS_DOWNLOAD_SHA1 2049cd6ae9167f258705081a6ef23bb80b7eff9ff3d0d7481e89510f27457591
ENV REDIS_DIR /usr/redis

# Copying settings
RUN mkdir $REDIS_DIR
COPY redis.conf         $REDIS_DIR/redis.conf
COPY redis-cluster.conf $REDIS_DIR/redis-cluster.conf
COPY sentinel.conf      $REDIS_DIR/sentinel.conf

# Downloading, unpacking and compiling Redis
RUN set -ex \
	\
	&& buildDeps=' \
		gcc libc6-dev make \
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
	&& make -C /usr/src/redis -j "$(nproc)"; \
	&& make -C /usr/src/redis install; \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -r /usr/src/redis

# Persistence folder
RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

EXPOSE 6379 26379
CMD ["redis-server", "/usr/redis/redis.conf"]
