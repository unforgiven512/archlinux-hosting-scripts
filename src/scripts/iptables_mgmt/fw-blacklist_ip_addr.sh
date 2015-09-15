#!/bin/bash
#
# fw-blacklist_ip_addr.sh
# (c) 2015 Gerad Munsch <gmunsch@unforgivendevelopment.com>
#
# Blacklist an IP address using iptables

BAD_IP="$1"
REASON="SSH brute force attempt"
ACTION="REJECT"

IP_VER="4"

IPT_TABLE_NAME="blacklist"

GMT_DATE=`date -u +%F`
GMT_TIME=`date -u +%R`

BLACKLIST_FILE="/etc/iptables/iptables.d/filter/60-blacklist.rules"

echo -e "* Adding $BAD_IP to IPv${IP_VER} blacklist"

echo -e "-A blacklist -s ${BAD_IP}\t-m comment --comment \"ADDED: ${GMT_DATE} @ ${GMT_TIME}\t\tREASON: ${REASON}\"\t\t\t-j ${ACTION}" >> $BLACKLIST_FILE

echo -e "* Reloading iptables"

systemctl reload iptables
