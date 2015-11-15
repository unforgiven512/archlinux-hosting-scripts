#!/bin/bash
#
# (c) 2015 Gerad Munsch <gmunsch@unforgivendevelopment.com>
#
# DESCRIPTION:
# Currently a very primitive MySQL backup script, it will
# evolve to have defined paths, a dedicated backup user,
# as well as associated systemd '.service' and '.timer'
# units for automated backups.
#

mysqldump --single-transaction --flush-logs --master-data=2 --all-databases -u root -p | xz > "mysqldump--alldatabases--$(date --iso-8601=seconds).sql.xz"
