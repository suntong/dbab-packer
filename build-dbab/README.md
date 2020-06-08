
## What is it

A turn key solution as a central LAN server, wrapped in a docker container. 

- Provides DNS, DHCP, [local caching](https://en.wikipedia.org/wiki/Squid) and [ads filtering](https://github.com/suntong/dbab#advantages) services for machines on the LAN
- All configuration for DNS, DHCP, [local caching](https://en.wikipedia.org/wiki/Squid) and [ads filtering](https://github.com/suntong/dbab#advantages) services are done automatic, or semi-automatic
- Built on top of `debian:testing-slim` so you can unleash its full potential right at your fingertip


## How to build it

Having [setup a static IP and a second IP](https://github.com/suntong/dbab/wiki/Dbab-From-Start-To-Finish#static-ip), and [disabled router's DHCP and DNS services](https://github.com/suntong/dbab-packer#synopsis), run

```sh
cd ../build-squid/

# build sys/dbab-squid
docker build -t sys/dbab-squid .

docker run -d -p 3128:3128 --name dbab-squid --hostname dbab-squid --restart=always sys/dbab-squid

cd ../build-dbab/

# build sys/dbab-docker:base
packer build dbab-docker-base.json

docker stop dbab-squid
docker rm dbab-squid

# build sys/dbab-docker:latest
packer build -on-error=ask -var server_domain=mine.org -var server_hostname_r=my-host -var server_ip_r=192.168.0.101 -var server_hostname_v=my-dmz -var server_ip_v=192.168.0.100 -var target_name=sys/dbab-docker dbab-docker-cust.json
```

on a host named `my-host`, with `mine.org` as domain name, and `192.168.0.100` as the virtual (second) IP, whose host-name will be assigned as `my-dmz`. It will build into a docker image called `sys/dbab-docker:latest`, which will be run under the host  `my-host`, which owns the real (first) static IP, `192.168.0.101`.

The `dbab_new.deb` points to `../../dbab_new.deb`, if it does exist, then this new version will be installed in the docker image as well.

## How to run

    docker run -d --net=host --cap-add=NET_ADMIN --name dbab-docker --hostname my-dmz sys/dbab-docker:latest

after having disabled ***host*** machine's local DNS resolution service. E.g.,

`sudo systemctl stop systemd-resolved.service`


