
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

#VOLUME ["$SQUID_CACHE_DIR" "/etc/dnsmasq.d"]

EXPOSE 53/tcp 53/udp $SQUID_HTTP_PORT/tcp

HEALTHCHECK CMD /bin/true || exit 1

ENV http_proxy=$all_proxy \
 https_proxy=$all_proxy

COPY dbab-docker-start.sh /

RUN apk add --no-cache squid dnsmasq curl \
 && /usr/sbin/squid -z \
 && echo "conf-dir=/etc/dnsmasq.d,*.conf" > /etc/dnsmasq.conf \
 && true

CMD /dbab-docker-start.sh
