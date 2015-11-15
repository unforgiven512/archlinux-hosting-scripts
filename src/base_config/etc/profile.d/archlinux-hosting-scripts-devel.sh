# Setup the necessary environment for "archlinux-hosting-scripts-devel" (non-packaged, manually installed, "live" development version) #

## variables ##
### set environment variable indicating that the "-devel" version of this package is present ###
AHS_DEVEL_PRESENT=1

### "archlinux-hosting-scripts" root directory (install path) ###
AHS_DEVEL_ROOT_DIR="/opt/archlinux-hosting-scripts-devel"

### add the package's "bin" directory to the environment's $PATH ###
# XXX: we should add a check for the existence of the packaged build's "bin" directory in the path, and
#      if it exists, ensure that the "-devel" version takes precedence
PATH="${AHS_DEVEL_ROOT_DIR}/bin:${PATH}"

## Export the various environment variables ##
export PATH
export AHS_DEVEL_PRESENT
