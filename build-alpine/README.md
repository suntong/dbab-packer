
## What is dbab-alpine

A turn key solution as a central LAN server, wrapped in a small docker container. 

- Provides DNS, DHCP, [local caching](https://en.wikipedia.org/wiki/Squid) and [ads filtering](https://github.com/suntong/dbab#advantages) services for machines on the LAN
- All configuration for DNS, DHCP, [local caching](https://en.wikipedia.org/wiki/Squid) and [ads filtering](https://github.com/suntong/dbab#advantages) services are done automatic, or semi-automatic
- Only less than 55M in image size (53.5MB as we speak)
- Compressed size is only less than 20MB if uploaded to docker hub (17.36 MB as we speak)


## How to build

Having

- [setup a static IP and a second IP](https://github.com/suntong/dbab/wiki/Dbab-From-Start-To-Finish#static-ip) (theoretically single IP and docker using host networking could also work, but for max protection, separated IP is better), and
- [disabled router's DHCP and DNS services](https://github.com/suntong/dbab-packer#synopsis) (may also do afterwards)

then run

```sh
docker build -t sys/dbab-alpine:base .

packer build -on-error=ask -var server_domain=mine.org -var server_hostname=my-dmz -var server_ip=192.168.0.100 -var target_name=sys/dbab-alpine dbab-docker.json
```

on a host with `mine.org` as domain name, and `192.168.0.100` as the second IP, whose host-name will be assigned as `my-dmz`. It will build into a docker image called `sys/dbab-alpine:latest`.

The latest `dbab.apk`, which is required for above build, can be downloaded from dbab release page, like [dbab_1.5.0-1_all.apk](https://github.com/suntong/dbab/releases/download/1.5.01/dbab_1.5.0-1_all.apk).

## How to run

    docker run -d --restart=always --net=host --cap-add=NET_ADMIN --name dbab-docker --hostname my-dmz sys/dbab-alpine:latest

after having disabled ***host*** machine's local DNS resolution service. E.g.,

`sudo systemctl stop systemd-resolved.service`


