#!/bin/bash

##
# setup user for hosting
##

setupUserForHosting() {
	# create directory for user in /srv/http/
	mkdir -p /srv/http/${uUsername}

	# change ownership of that directory to allow user to read/write, httpd to read/write, others no access
	chmod 0770 /srv/http/${uUsername}
	chown ${uUsername}:http /srv/http/${uUsername}

	# link directory into user's home directory
	ln -s /srv/http/${uUsername} /home/${uUsername}/public_html
}

createPhpFpmConf() {
cat > "/etc/php/fpm.d/${uUsername}.conf" << EOF
; start a pool for ${uUsername}
[${uUsername}]

; run this pool as user: ${uUsername} and group: http
user = ${uUsername}
group = http

; open a unique socket for ${uUsername}
listen = /run/php-fpm/php-fpm-${uUsername}.sock

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
access.log = /var/log/php-fpm/${uUsername}/access.log

; set open file descriptor rlimit
; default: system defined value
; default2: 1024
rlimit_files = 1024

; chdir to this directory at start
chdir = /srv/http/${uUsername}
EOF
}

## main loop / gather arguments ##
while test $# -gt 0; do
	case "$1" in
		-h|--help)
			echo -e "\033[1m<insert help here>\033[0m"
			exit 0
			;;
		-u|--username)
			shift
			if test $# -gt 0; then
				export uUsername="$1"
			else
				echo -e "\033[31mERROR: no username specified\033[0m"
				exit 1
			fi
			shift
			;;
		-v|--verbose)
			export uVerbose="true"
			shift
			;;
		-vv|--debug)
			export uVerbose="true"
			export uDebug="true"
			shift
			;;
		*)
			break
			;;
	esac
done
