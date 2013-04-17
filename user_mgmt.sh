#!/bin/bash

##
# setup user for hosting
##

setupUserForHosting() {
	# create directory for user in /srv/http/
	mkdir -p /srv/http/${username}

	# change ownership of that directory to allow user to read/write, httpd to read/write, others no access
	chmod 0770 /srv/http/${username}
	chown ${username}:http /srv/http/${username}

	# link directory into user's home directory
	ln -s /srv/http/${username} /home/${username}/public_html
}
