FROM centos:centos7
MAINTAINER Chris Collins <collins.christopher@gmail.com>

ENV CONTAINER='docker'\
    TERM='xterm'\
    INITDIR='/etc/service'\
    BUILDPKGS='rpm-build rpmdevtools redhat-rpm-config glibc-static git which tar'

ADD build-rpm.sh /build-rpm.sh

RUN yum update -y \
    && yum install -y --nogpgcheck $BUILDPKGS gcc make automake autoconf epel-release \
    && yum install -y redis \
    && bash /build-rpm.sh 'https://github.com/imeyer/runit-rpm.git' 'runit'  \
    && yum remove --setopt=clean_requirements_on_remove=1 -y $BUILDPKGS  \
    && yum clean all

RUN mkdir -p $INITDIR \
    && chown -R root.root $INITDIR \
    && chmod -R a+x $INITDIR \
    && echo 'SV:123456:respawn:/sbin/runsvdir-start' > /etc/inittab

ADD redis.conf /etc/redis.conf

RUN mkdir -p /etc/service/redis
ADD redis.run /etc/service/redis/run
RUN chmod -R a+x /etc/service/redis

EXPOSE 6397

ENTRYPOINT ["/sbin/runsvdir", "-P", "/etc/service"]
