FROM gitpod/workspace-full:latest

ARG vnfpm=2.30.1
ARG vdbab=1.5.8

# Install pkgs
USER root
RUN apt-get update && apt-get install -y iputils-ping packer && packer version
RUN curl -JLO https://github.com/goreleaser/nfpm/releases/download/v${vnfpm}/nfpm_${vnfpm}_amd64.deb && apt install -y ./nfpm_${vnfpm}_amd64.deb && nfpm -v

# Provide 2nd IP
#RUN ip a add 10.0.5.5/30 dev eth0 && ip a s eth0

# Setup & build dc as user gitpod
USER gitpod

# RUN cd build-alpine && \
#     curl -JLO https://github.com/suntong/dbab/releases/download/${vdbab}/dbab_${vdbab}-1_all.apk && ln -vsf dbab_${vdbab}-1_all.apk dbab.apk && ls -l \
#     docker build -t sys/dbab-alpine:base . && docker images

