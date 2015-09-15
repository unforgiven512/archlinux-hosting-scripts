#!/bin/bash
#
# fw-list_sorted_blacklisted_addrs.sh
# (c) 2015 Gerad Munsch <gmunsch@unforgivendevelopment,com>
#
# DESCRIPTION:
# This script will output a sorted list of any IP addresses that have been manually
# blacklisted using the 'fw-blacklist_ip_addr.sh' script (or added manually to the
# target "##-blacklist.rules" file). This will facilitate much easier recognition of
# patterns/IP ranges that produce a lot of bad traffic.
#
# Perhaps it could be cool to create a central repo/database of bad IPs/ranges, from
# which anyone can read, and contributions would be "verified" by the existence of
# multiple entries? Additionally, an IP could be dropped from the repo/db if there are
# no hits for "x" (30?) days?
#
#
# NOTES:
# This script will write its output to a file under /tmp/, with the format as follows:
# /tmp/ip_blacklist_sorted--YYYY-mm-ddTHH:MM:SS+TZOS (the date is ISO-8601 format)
# -example- /tmp/ip_blacklist_sorted--2015-08-11T05:48:01-0500
#
# TODO:
# * Implement a parameter/function to retain dumps on non-volatile storage, with a path
#   read from a config file (ie: /etc/archlinux-hosting-scripts/firewall.cfg)
# * Implement a parameter/function to cleanup old data on /tmp/
# -- * For now, we will xz any existing data, and move it into /tmp/ip_blacklist-archive/
#      at runtime, before generating any new data
#
#

# define some paths
IP_BL_ARCHIVE="/tmp/ip_blacklist-archive"
IPT_BL_RULES_FILE="/etc/iptables/iptables.d/filter/60-blacklist.rules"

# check for $IP_BL_ARCHIVE
if [ ! -d "${IP_BL_ARCHIVE}" ]; then
	mkdir "${IP_BL_ARCHIVE}"
fi

# use "for" to xz and move any existing data
for data in /tmp/ip_blacklist_sorted*; do
	# move data to $IP_BL_ARCHIVE
	mv "$data" "${IP_BL_ARCHIVE}/"
	# compress data with 'xz'
	xz "${IP_BL_ARCHIVE}/$(basename ${data})"
done

# precompute filename
IP_BL_SORTED_OUT="ip_blacklist_sorted-$(date --iso-8601=seconds)"


cat "$IPT_BL_RULES_FILE" | sed -r 's/#?-A blacklist -s \b([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*)\b.*-m comment.*REJECT/\1/gm' | sed '/^#.*$/d' | sort -V > "$IP_BL_SORTED_OUT"

less "$IP_BL_SORTED_OUT"
