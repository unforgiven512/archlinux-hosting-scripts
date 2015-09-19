#!/bin/bash
#
# configure_pacman_makepkg_package-.sh
#
# (c) 2015 Gerad Munsch
#
#####
#
## DESCRIPTION: ##
# This script is intended for use during the initial setup of your Arch Linux system, in preparation for
# hosting various internet services. Though the script has a _really_ long filename, and can be invoked using
# "$ configure_pacman_makepkg_package-query_and_yaourt.sh [ACTION]", it is intended to be called via simpler,
# more task-specific symlinks, such as "ahs-install_package-query" and "ahs-configure_yaourt".
#
## ACTIONS: ##
# 

# the manual_devel_install.sh installer will uncomment the following line if this is a "-devel" install:
#AHS_DEVEL=1

# source system information from '/etc/ahs/install.conf' and '/etc/ahs/system.conf' ('/etc/ahs-devel/' if using manually-installed package)
if [ $AHS_DEVEL ]; then
  AHS_CONFIG_PATH="/usr/local/etc/ahs-devel"
  AHS_ROOT_PATH="/opt/ahs-devel"
  AHS_BIN_PATH="/usr/local/bin"
else
  AHS_CONFIG_PATH="/etc/ahs"
  AHS_ROOT_PATH="/opt/ahs"
  AHS_BIN_PATH="/usr/bin"
fi

source "${AHS_CONFIG_PATH}/install.conf"
source "${AHS_CONFIG_PATH}/system.conf"

# configure pacman
config_pacman_conf () {
  # show detailed package info on install/upgrade
  sed -i 's/^#\(Ver.*sts\)/\1/' "${PACMAN_CONF_FILE}"
}