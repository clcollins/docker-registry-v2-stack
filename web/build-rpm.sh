#!/bin/bash

set -x

RPMUSER='rpmbuilder'
RPMHOME="/home/$RPMUSER"
SOURCE="$1"
NAME="$2"

f_err () {
  echo "$1"
  exit 1
}

f_warn() {
  echo "$(date '+%Y-%m-%dT%H:%M') - $1" | tee $LOGFILE
  exit 0
}

/usr/sbin/useradd $RPMUSER || f_err "Unable to add user $RPMUSER"

/bin/mkdir -p $RPMHOME/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} || f_err "Unable to make directories"
/bin/echo '%_topdir %(echo $HOME)/rpmbuild' > $RPMHOME/.rpmmacros
/bin/chown -R $RPMUSER $RPMHOME

/bin/su -c "/usr/bin/git clone $SOURCE $NAME" - rpmbuilder  || f_err "Unable to clone $SOURCE"
/bin/su -c "/home/rpmbuilder/$NAME/build.sh $NAME 1>/dev/null" - rpmbuilder  || f_err "Unable to build $NAME"

/usr/bin/yum install -y $RPMHOME/rpmbuild/RPMS/*/*.rpm  || f_err "Unable to install $NAME"

if [[ $? == 0 ]] ; then
  /usr/sbin/userdel $RPMUSER
  /bin/rm -rf $RPMHOME
fi
