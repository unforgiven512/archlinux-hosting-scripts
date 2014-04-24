#!/bin/bash


get_cpu_count() { ## function to get CPU count, and add 1
	declare -i cpuCount
	cpuCount=`cat /proc/cpuinfo | grep processor | wc -l`
	cpuCount=$cpuCount+1
}

build_nginx_conf() { ## function to build nginx.conf
	sed -i 's/^worker_processes.*/worker_processes '$cpuCount'\;/' /etc/nginx/nginx.conf
	
}

create_folder_structure() { ## function to create folder structure for nginx-based hosting
	mkdir -p "/etc/nginx/vhosts-available"
	mkdir -p "/etc/nginx/vhosts-enabled"
	mkdir -p "/etc/nginx/includes"
	mkdir -p "/etc/nginx/conf.d"
}
