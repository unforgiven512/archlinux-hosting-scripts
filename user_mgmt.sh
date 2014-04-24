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

createPhpFpmConf() {
cat > "/etc/php/fpm.d/${username}.conf" << EOF
; start a pool for ${username}
[${username}]

; run this pool as user: ${username} and group: http
user = ${username}
group = http

; open a unique socket for ${username}
listen = /run/php-fpm/php-fpm-${username}.sock

; child process management
; we will use the defaults provided in /etc/php/php-fpm.conf by ArchLinux
; they are listed below for reference:
; pm = dynamic
; pm.max_children = 5
; pm.start_servers = 2
; pm.min_spare_servers = 1
; pm.max_spare_servers = 3
; pm.max_requests = 500
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
pm.max_requests = 500

; per-user logging (logs will be linked into user's home directory)
access.log = /var/log/php-fpm/${username}/access.log

; set open file descriptor rlimit
; default: system defined value
; default2: 1024
rlimit_files = 1024

; chdir to this directory at start
chdir = /srv/http/${username}
EOF
}

username="$1"

createPhpFpmConf
