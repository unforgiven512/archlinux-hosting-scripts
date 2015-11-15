# Setup the necessary environment for "archlinux-hosting-scripts" #

## variables ##
### "archlinux-hosting-scripts" root directory (install path) ###
AHS_ROOT_DIR="/opt/archlinux-hosting-scripts"

### add the package's "bin" directory to the environment's $PATH ###
PATH="${AHS_ROOT_DIR}/bin:${PATH}"

## Export the various environment variables ##
export PATH
