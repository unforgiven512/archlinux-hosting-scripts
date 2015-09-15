#!/bin/bash

kill -USR1 `cat /run/rsyslog.pid`

echo "Toggled rsyslog debug state"
echo "Output to /var/log/rsyslog-debug.log"
