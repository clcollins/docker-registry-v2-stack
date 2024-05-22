#This repository is archived and will no longer receive updates.

Registry-V2
===========

_v1.1 - 2016-04-08_

A docker registry stack using the [Docker Distribution registry v2](https://github.com/docker/distribution/tree/master/registry), Apache with mod_auth_kerb for authentication, and a Redis cache for metadata objects.

These containers should work out of the box, with the exception of a few changes to the config files for Apache \(see below\).

_Note:_ The Docker Registry image in this stack is entirely identical to the upstream.  The Dockerfile to build it just adds a custom config.yml.  You could also just volume mount the file in a container created from Docker.io's registry:2 image \(to /etc/docker/registry/config.yml\).

## Running ##

After building the Docker images, run the stack:

    docker run --name registry-redis \
               --restart always \
               -d registry-redis
    
    docker run --name registry \
               --restart always \
               --link registry-redis:redis \
               -v <LOCAL STORAGE VOLUME>:/var/lib/registry \
               -d registry-v2

    docker run --name registry-web \
               --restart always \
               --link registry:registry \
               -v <LOCAL CONFIG DIR>:/conf \
               -p 443:443 \
               -e SITENAME=<URL OF YOUR REGISTRY> \
               -d registry-web
  
## Special Notes For Apache ##

_SSL_

SSL is on by default, but you need to supply your own SSL certificates.  The `<LOCAL CONFIG DIR>` for the registry-web container should contain the ssl certs and keys, named like so:

1. SSL Certificate:                        `localhost.crt`
2. SSL Key:	                           `localhost.key`
3. (Optional) CA Intermediate Certificate: `ca-cert.crt`


_Kerberos_

Kerberos and mod_auth_kerb are installed, but you'll need to edit the vhost.conf and krb5.conf files with your own Kerberos information.  Alternatively, you can comment out the Kerberos stuff from the vhost.conf file and uncomment the basic authentication stuff, and use that.

## Changelog ##

_v1.1 - 2016-04-08_

Changed config.yml to use `addr: 0.0.0.0:5000` instead of `addr: localhost:5000` for the http section, to fix 503 errors from registry.  Should allow for linking correctly \(no variables required\) without any security issues as long as port 5000 is never mapped by the registry container.
