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
	mkdir -p /srv/http/${username}/${vhost_hostname}

	# reload server configuration
	systemctl restart ${server_unit}
}
