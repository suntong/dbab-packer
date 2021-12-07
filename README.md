# dbab-packer

Packer building template for `dbab` docker container

## Prefix

- This `docker` approach is much simpler than the host-package-installing approach, as everything can be done semi-automatically.
- And the container approach is much safer in theory too.
- This has been my default way of using `dbab` and I've been using it for several rounds of new installations now.
- Thus I'm officially recommending this way as oppose to the host-package-installing approach now, as Debian packaging had always been a frustrating experience again and again for me. So I will update the Debian package for the last time and stop packaging it after 2021.

## Synopsis

- Optional but highly recommended, build a local `squid` caching docker service
  * Refer to [local apt-cacher-ng service](https://docs.docker.com/engine/examples/apt-cacher-ng/) as the guild line if necessary
  * Test it first to make sure it is working fine.
  * If not using the local caching service, remove the `proxy` settings from the `environment_vars` section.
- Build `dbab` docker container
  * Start `dbab` docker container
  * Verify with dns requests
  * Verify with web sites browsing
- Configure the local `squid` caching and `dbab` services to start automatically on reboot
  * Reboot host
  * Verify that the local `squid` caching and `dbab` docker container services have started automatically
  * Verify again dns requests and web access are still behaving as expected
- Disable router's DHCP and DNS services
  * Boot up another machine/device, verify that DHCP and DNS service are working fine
- Change the `dbab` docker's host to Static IP
  * Reboot host
  * Verify that `dbab` docker container services have started automatically
  * Verify again dns requests and web access are still behaving as expected
  * Reboot the other machine/device, verify that DHCP and DNS service are still working fine

Viola, `dbab` is now contained in docker container, in "_merely_" 18 "_easy_" steps, :). Well, actually every single point can be an essay by itself, however, I don't have the bandwidth to cover or support them. So this intro and this project only focuses on `dbab`, nothing else. Period.

## Build `dbab` docker container

To build with Debian stable (or `stable-backports`) docker as the base, use the new `dbab` package from local, and produce your own docker image named `myid/my-dbab`:

    cd build-dbab/; DBAB_NEW=T packer build -only=docker -var build_base=debian:stable-backports -var target_name=myid/my-dbab dbab-docker.json

Again, due to my limited bandwidth, there won't be such ready-built _"official"_ `dbab` docker container from me, unless I can figure out a way to trigger it in CI in the cloud, someday.

## Start `dbab` docker container

To start `dbab` docker container:

    docker run -d --rm -p 53:53 -p 67:67 --name my-own-dbab --hostname my-dbab-name myid/my-dbab:latest

## Author(s)

Tong SUN  
![suntong001 from users.sourceforge.net](https://img.shields.io/badge/suntong001-%40users.sourceforge.net-lightgrey.svg "suntong001 from users.sourceforge.net")

