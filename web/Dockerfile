FROM centos:centos7
MAINTAINER Chris Collins <collins.christopher@gmail.com>

ENV CONTAINER='docker'\
    TERM='xterm'\
    INITDIR='/etc/service'\
    BUILDPKGS='rpm-build rpmdevtools redhat-rpm-config glibc-static git which tar'

ADD build-rpm.sh /build-rpm.sh

RUN yum update -y \
    && yum install -y --nogpgcheck $BUILDPKGS gcc make automake autoconf epel-release \
    && yum install -y httpd mod_ssl mod_auth_kerb \
    && bash /build-rpm.sh 'https://github.com/imeyer/runit-rpm.git' 'runit'  \
    && yum remove --setopt=clean_requirements_on_remove=1 -y $BUILDPKGS  \
    && yum clean all

RUN mkdir -p $INITDIR \
    && chown -R root.root $INITDIR \
    && chmod -R a+x $INITDIR \
    && echo 'SV:123456:respawn:/sbin/runsvdir-start' > /etc/inittab

ENV HTTPDCONF='/etc/httpd/conf/httpd.conf' \
    HTTPDMPM='event' \
    MPMCONF='/etc/httpd/conf.modules.d/00-mpm.conf' \
    HOSTCONF='/etc/httpd/conf.d/vhost.conf' \
    SSLCONF='/etc/httpd/conf.d/ssl.conf' \
    SSLPROTO='SSLProtocol +TLSv1 +TLSv1.1 +TLSv1.2' \
    SSLCIPHERS='SSLCipherSuite ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128:AES256:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!3DES:!MD5:!PSK'

# SSL Hardenting
RUN sed -i -e "/SSLProtocol all -SSLv2.*/d" \
           -e "/^SSLCipherSuite.*/d" \
           -e "/SSLEngine on/d" \
           -e "/<VirtualHost _default_:443>/d" \
           -e "/<\/VirtualHost>/d" $SSLCONF 

RUN echo -e "\
SSLHonorCipherOrder On\n\
${SSLPROTO}\n\
${SSLCIPHERS}\n\
\n\
SSLOptions +StrictRequire\n\
\n\
SSLOptions +StdEnvVars\n\
RequestHeader set X-SSL-Protocol %{SSL_PROTOCOL}s\n\
RequestHeader set X-SSL-Cipher %{SSL_CIPHER}s\n\
" >> $SSLCONF

ADD vhost.conf /etc/httpd/conf.d/vhost.conf
ADD krb5.conf /etc/krb5.conf

ADD apache-config.sh /apache-config.sh

RUN mkdir -p /etc/service/httpd
ADD httpd.run /etc/service/httpd/run
RUN chmod -R a+x /etc/service/httpd

EXPOSE 80 
EXPOSE 443 

ENTRYPOINT ["/sbin/runsvdir", "-P", "/etc/service"]

