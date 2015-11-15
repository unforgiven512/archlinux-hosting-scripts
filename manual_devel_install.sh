#!/bin/bash
#
# manual_devel_install.sh
# (c) 2015 Gerad Munsch <gmunsch@unforgivendevelopment.com>
#
# Perform installation tasks necessary for a "live" development version of "archlinux-hosting-scripts"
# DO NOT USE UNLESS YOU PLAN ON ACTIVELY DEVELOPING/WORKING ON THIS PACKAGE -- please use the packaged
# version instead (see README.md; PKGBUILD is present in './arch_pkg_src')
#

source ./src/base_config/archlinux-hosting-scripts-devel.conf


updateGitIgnoreFile ()
{
  gitIgnoreFile="${AHS_DEVEL_INSTALL_ROOT_DIR}/.gitignore"
  
}