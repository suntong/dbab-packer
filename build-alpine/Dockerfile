
FROM alpine:latest

MAINTAINER Tong Sun (https://github.com/suntong/)
# Simplified from https://github.com/suntong/dbab-docker/blob/master/Dockerfile

#set enviromental values
ENV SQUID_HTTP_PORT="3128" \
 SQUID_CACHE_DIR="/var/cache/squid" \
 X=X

#set proxies for alpine apk package manager if necessary
ARG all_proxy
ARG NAME="docker-squid-alpine"
ARG DESCRIPTION="Alpine Squid Proxy"

LABEL name="$NAME" \
 architecture="amd64" \
 description="$DESCRIPTION" \
 org.label-schema.description="$DESCRIPTION" \
 org.label-schema.name="$NAME"

#VOLUME ["$SQUID_CACHE_DIR"]

EXPOSE $SQUID_HTTP_PORT/tcp

HEALTHCHECK CMD /bin/true || exit 1

ENV http_proxy=$all_proxy \
 https_proxy=$all_proxy

RUN apk add --no-cache squid \
 && /usr/sbin/squid -z \
 && true

CMD /usr/sbin/squid -NYCd 1
