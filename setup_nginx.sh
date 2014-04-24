#!/bin/bash

source server.defs


get_cpu_count() { ## function to get CPU count, and add 1
	declare -i cpuCount
	cpuCount=`cat /proc/cpuinfo | grep processor | wc -l`
	cpuCount=$cpuCount+1
}

build_nginx_conf() { ## function to build nginx.conf
	#sed -i 's/^worker_processes.*/worker_processes '$cpuCount'\;/' /etc/nginx/nginx.conf

cat >> "/etc/nginx/nginx.conf" < EOF
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
	include			/etc/nginx/vhosts-enabled/*;
}
EOF
}

create_default_vhost() { ## function to create a default virtual host, and link it to the enabled folder
cat >> /etc/nginx/vhosts-available/default < EOF
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

ln -s /etc/nginx/vhosts-available/default /etc/nginx/vhosts-enabled/000-default
}

create_folder_structure() { ## function to create folder structure for nginx-based hosting
	mkdir -p "/etc/nginx/vhosts-available"
	mkdir -p "/etc/nginx/vhosts-enabled"
	mkdir -p "/etc/nginx/includes"
	mkdir -p "/etc/nginx/conf.d"
}
