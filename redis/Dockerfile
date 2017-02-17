FROM fedora:25
MAINTAINER Ricardo Costa <racc.costa@gmail.com>

RUN groupadd -r redis && useradd -r -g redis redis

RUN dnf install wget \
        && dnf install tar 

ENV REDIS_VERSAO 3.2.8
ENV REDIS_URL_DOWNLOAD http://download.redis.io/releases/redis-$REDIS_VERSAO.tar.gz
ENV REDIS_SHA1_DOWNLOAD 6780d1abb66f33a97aad0edbe020403d0a15b67f

RUN echo "$REDIS_SHA1_DOWNLOAD *redis.tar.gz" | sha1sum -c - 
RUN wget -O redis.tar.gz "$REDIS_URL_DOWNLOAD" 	
RUN mkdir -p /usr/src/redis	
RUN tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1
RUN rm redis.tar.gz
RUN make -C /usr/src/redis
RUN make -C /usr/src/redis install 

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]
