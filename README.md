# dbab-packer

Packer building template for `dbab` docker container

## Prefix

- This `docker` approach is much simpler than the host-package-installing approach, as everything can be done semi-automatically.
- And the container approach is much safer in theory too.
- This has been my default way of using `dbab` and I've been using it for several rounds of new installations now.
- Thus I'm officially recommending this way as oppose to the host-package-installing approach now, as Debian packaging had always been a frustrating experience again and again for me. So I will update the Debian package for the last time and stop packaging it after 2021.

## Synopsis

From using router to using `dbab` container for DHCP & DNS services in 3~5 easy steps:

- Optional but highly recommended, build a local `squid` caching docker service
  * Refer to [local apt-cacher-ng service](https://docs.docker.com/engine/examples/apt-cacher-ng/) as the guild line if necessary
  * Test it first to make sure it is working fine.
  * If not using the local caching service, remove the `proxy` settings from the `environment_vars` section of `dbab-docker.json`.
- Build `dbab` docker container
  * Start `dbab` docker container
  * Verify with dns requests
  * Verify with web sites browsing
- Optionally (not necessary and not recommended), configure the local `squid` caching and `dbab` services to start automatically on reboot
  * Reboot host
  * Verify that the local `squid` caching and `dbab` docker container services have started automatically
  * Verify again dns requests and web access are still behaving as expected
- Disable router's DHCP and DNS services
  * Boot up another machine/device, verify that `dbab` container provided DHCP and DNS service are working fine
- Change the `dbab` docker's host to Static IP
  * Reboot host
  * Verify that `dbab` docker container services have started automatically
  * Verify again dns requests and web access are still behaving as expected
  * Reboot the other machine/device, verify that DHCP and DNS service are still working fine

Viola, `dbab` is now contained in docker container, in "_merely_" 3~5 "_easy_" steps, :). Well, actually every single point can be an essay by itself, which is too wide for me to cover or support. So this intro and this project only focuses on `dbab`, nothing else. Period.

## Build `dbab` docker container

See 

- [Building `dbab` docker container](https://github.com/suntong/dbab-packer/wiki/Building-dbab-docker-container)

The custom-built docker image is a highly customized one as everyone's case is different. Thus there cannot be a one-size-fit-all solution pre-built generic docker image. But the good news is that such semi-automatic container building should be super easy -- you provide the parameters that fit your case, and the container building will be done automatically.

## Start `dbab` docker container

To start `dbab` docker container:

    docker run -d --rm -p 53:53 -p 67:67 --name my-own-dbab --hostname my-dbab-name myid/my-dbab:latest

## Author(s)

Tong SUN  
![suntong001 from users.sourceforge.net](https://img.shields.io/badge/suntong001-%40users.sourceforge.net-lightgrey.svg "suntong001 from users.sourceforge.net")

