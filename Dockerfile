FROM debian:testing

MAINTAINER Antonio P.P. Almeida "perusio@gmail.com"

## Seed debconf selections and install locales: tarantool needs UTF8.
COPY locales_seed.txt /tmp/locales_seed.txt
RUN debconf-set-selections /tmp/locales_seed.txt && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install locales curl

## Set language environment variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
## tarantool repository doesn't accept distribution tags like stable,
## testing, unstable. Only the distribution name.
ENV DEBIAN_TESTING stretch

## Get the repository key, add the to the sources list and install tarantool and gosu.
RUN curl -s http://tarantool.org/dist/public.key | apt-key add - && \
    echo "deb http://tarantool.org/dist/master/debian/ $DEBIAN_TESTING main" > /etc/apt/sources.list.d/tarantool.list && \
    echo "deb-src http://tarantool.org/dist/master/debian/ $DEBIAN_TESTING main" >> /etc/apt/sources.list.d/tarantool.list && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tarantool-common tarantool gosu

## Forward request and error logs to docker log collector and create +
## chown the write logs directory.
RUN ln -sf /dev/stderr /var/log/tarantool/composers.log && \
    mkdir -p /data/db && \
    chown -R tarantool:tarantool /data/db

## Expose the "usual" tarantool port.
EXPOSE 3301

## Where tarantool stores the files (wal, snaphosts, etc).
VOLUME ["/data/db"]

## Define workdir and get the necessary files.
WORKDIR tarantool
COPY instances instances
WORKDIR instances

## Start the tarantool instance. Dropping privileges to run it as
## tarantool user+group.
ENTRYPOINT ["/usr/sbin/gosu", "tarantool", "/usr/bin/tarantool"]
CMD ["composers.lua"]
