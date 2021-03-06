#!/bin/bash

source server.conf # contains user-defined values about the setup of the server, such as paths, etc
source server.defs # contains constant data about different server types

##
# create domain for user
##

createHostedDomain() {
	# source our template
	source ${server_type}-vhost.template

	# cat template with filled-out variables into appropriate directory for server
	cat > ${SERVER_VHOST_DIR}/${vhost_hostname} < EOF
	${vhost_conf_file_data}
	EOF

	# create directory in user's /srv/http/${username}/ (aka ~/public_html) directory
	mkdir -p /srv/http/${sUsername}/domains/${vhost_hostname}
	chown ${sUsername}:http /srv/http/${sUsername}/domains/${vhost_hostname}
	chmod 0775 /srv/http/${sUsername}/domains/${vhost_hostname}

	# reload server configuration
	systemctl restart ${server_unit}
}

createRedirectDomain() {
if [ "${dHttpdType}" == "nginx" ]; then
cat > "${dHttpdVhostDir}/${sFromDomain}" << EOF
## REDIRECT TO BARE DOMAIN ##
server {
  server_name ${sFromDomain};
  rewrite ^ '$scheme'://${sToDomain}'$request_uri' redirect;
}
EOF
}

enableSSLForDomain() {
if [ $verbose ]; then
	echo "VERBOSE: enabling SSL for ${sDomainName}"
fi
}

## main loop / gather arguments ##
while test $# -gt 0; do
	case "$1" in
		-h|--help)
			echo -e "\033[1m<insert help here>\033[0m"
			exit 0
			;;
		-u)
			shift
			if test $# -gt 0; then
				export sUsername="$1"
			else
				echo -e "\033[31mERROR: no username specified\033[0m"
				exit 1
			fi
			shift
			;;
		-d)
			shift
			if test $# -gt 0; then
				export sDomainName="$1"
			else
				echo -e "\033[31mERROR: no domain name specified\033[0m"
				exit 1
			fi
			shift
			;;
		-s|--ssl)
			export sEnableSSL="true"
			shift
			;;
		-c|--crtfile)
			shift
			if test $# -gt 0; then
				export sSSLCertFile="$1"
			else
				echo -e "\033[31;1mERROR:\033[0m \033[31mno SSL certificate file specified\033[0m"
				exit 1
			fi
			shift
			;;
		-k|--keyfile)
			shift
			if test $# -gt 0; then
				export sSSLKeyFile="$1"
			else
				echo -e "\033[31;1mERROR:\033[0m \033[31mno SSL key file specified\033[0m"
				exit 1
			fi
			shift
			;;
		-p|--private-keyfile)
			shift
			if test $# -gt 0; then
				export sSSLPrivateKeyFile="$1"
			else
				echo -e "\033[31;1mERROR:\033[0m \033[31mno SSL private (encrypted) key file specified\033[0m"
				exit 1
			fi
			shift
			;;
		-v|--verbose)
			export sVerbose="true"
			shift
			;;
		-vv|--debug)
			export sVerbose="true"
			export sDebug="true"
			shift
			;;
		*)
			break
			;;
	esac
done
