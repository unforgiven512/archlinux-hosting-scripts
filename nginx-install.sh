#!/bin/bash
#
# nginx-install.sh
#
# (c) 2013 Gerad Munsch <gmunsch@unforgivendevelopment.com>
#
# Installs nginx and performs basic configuration
#
#

source server.conf
source server.defs

createVhostDirs() {
	mkdir -p /etc/nginx/vhosts-{available,enabled}
}

createNginxConfig() {
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
	
	SYSTEM_CPU_COUNT=`cat /proc/cpuinfo | grep processor | wc -l`
	
	echo -e "\033[1m* Building nginx.conf\033[0m"
	
	source nginx.conf.template
	cat > ${NGINX_CONFIG_FILE} < EOF
	${NGINX_CONF_TEMPLATE}
	EOF
	
	echo -e "\033[1m* Configuration built\033[0m"
}
