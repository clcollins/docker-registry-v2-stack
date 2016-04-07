#!/bin/bash

set -x

check_file_exists () {
  local file="$1"

  if [[ ! -f $file ]] ; then
    return 1
  fi

return 0

}


error () {
  local message="$1"
  local date="$(date '+%Y-%m-%dT%H:%M')"

  echo "${date} - ${message}"
  exit 1
}

copy_certs () {
  local ssl_key='/conf/localhost.key'
  local ssl_crt='/conf/localhost.crt'
  local ssl_ca_crt='/conf/ca-cert.crt'
  local ssl_config_file="${SSLCONF}"
  local tls_dir='/etc/pki/tls'

  if ! check_file_exists $ssl_key ; then
    error "${ssl_key} does not exist."
    return 1
  else
    cat ${ssl_key} > ${tls_dir}/private/localhost.key
  fi

  if ! check_file_exists $ssl_crt ; then
    error "${ssl_crt} does not exist."
    return 1
  else
    cat ${ssl_crt} > ${tls_dir}/certs/localhost.crt
  fi

  if check_file_exists $ssl_ca_crt ; then
    sed -i 's|#SSLCACertificateFile /etc/pki/tls/certs/ca-bundle.crt|SSLCACertificateFile /etc/pki/tls/certs/localhost-ca.crt|' $ssl_config_file
    cat ${ssl_ca_crt} > ${tls_dir}/certs/localhost-ca.crt
  fi

  return 0
}


create_log_dir () {
  local log_dir="/var/log/httpd"

  if [[ ! -d ${log_dir} ]] ; then
    mkdir -p ${log_dir}
    chown -R apache.root ${log_dir}
    chmod 0755 ${log_dir}
  fi

  return 0
}


main () {

  copy_certs \
  && create_log_dir 

}

main
