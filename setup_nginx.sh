#!/bin/bash

## variables from server.conf all start with "n" (ie: $nServerTimezone)
source server.conf
## constants from server.defs all start with "d" (ie: $dHttpdConfDir)
source server.defs

############################################################################

get_cpu_count() { ## function to get CPU count, and add 1
	declare -i cpuCount
	cpuCount=`cat /proc/cpuinfo | grep processor | wc -l`
	cpuCount=$cpuCount+1
}

build_nginx_conf() { ## function to build nginx.conf
	#sed -i 's/^worker_processes.*/worker_processes '$cpuCount'\;/' /etc/nginx/nginx.conf

cat > "/etc/nginx/nginx.conf" << EOF
worker_processes $cpuCount;

events {
	worker_connections 1024;
}

http {
	include			mime.types;
	default_type		application/octet-stream;
	sendfile		on;
	keepalive_timeout	65;
	gzip			on;
	gzip_disable		"msie6";

	## includes ##
	include			/etc/nginx/conf.d/*.conf;
	include			/etc/nginx/includes/*;
	include			/etc/nginx/sites-enabled/*;
}
EOF
}

create_default_site() { ## function to create a default virtual host, and link it to the enabled folder
cat > /etc/nginx/sites-available/default << EOF
server {
  listen 80 default_server;

  # comment your actual hostname, and uncomment the following line to
  # cause nginx to only respond to requests to domain names it knows
  server_name ${nServerHostname};
  #server_name _;

  root /usr/share/nginx/html;
  index index.html index.htm;

  access_log /var/log/nginx/access-default.log;
  error_log  /var/log/nginx/error-default.log;

  location / {
    try_files \$uri \$uri/ /index.html;
  }
}
EOF

ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/000-default
}

create_folder_structure() { ## function to create folder structure for nginx-based hosting
	mkdir -p "/etc/nginx/sites-available"
	mkdir -p "/etc/nginx/sites-enabled"
	mkdir -p "/etc/nginx/includes"
	mkdir -p "/etc/nginx/conf.d"
}

echo_post_install_info() { ## provide the user with some useful info/tips
	echo "The setup process for nginx has successfully completed."
	echo ""
	echo "It is recommended to install the 'nginx_ensite-git' package from the AUR;"
	echo "this will make enabling and disabling sites significantly easier."
}

install_arch_packages() {
	pacman -S nginx php php-fpm mariadb php-gd php-intl php-xcache
}

create_php_configs() {
	### PHP-FPM ###
	## include *.conf files in /etc/php/fpm.d/, which will be necessary for user confs ##
	sed -i 's/\;include=\/etc\/php\/fpm\.d\/\*\.conf/include=\/etc\/php\/fpm\.d\/\*\.conf/' /etc/php/php-fpm.conf

	### PHP.INI ###
	## set our timezone in php.ini ##
	sed -i 's@;date\.timezone.*@date\.timezone = '"$nServerTimezone"'@' /etc/php/php.ini	
	## enable mysqli extension ##
	sed -i 's/;extension=mysqli.so/extension=mysqli.so/' /etc/php/php.ini
	sed -i 's/;extension=gd.so/extension=gd.so/' /etc/php/php.ini
	sed -i 's/;extension=intl.so/extension=intl.so/' /etc/php/php.ini
	let lineNo=`grep -rne 'tidy\.so' /etc/php/php.ini | cut -d: -f1`+1
	sed -i "$lineNo"'i''extension=xcache\.so' /etc/php/php.ini
}

display_help() {
	echo -e "033[1mHELP:\033[0m"
	echo -e "033[1m--initial-setup   - Setup your system for web hosting (first run)\033[0m"
}
