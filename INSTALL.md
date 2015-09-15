# Installation #

It is preferred to install this package using pacman; the PKGBUILD (and related files) are provided in the 'arch_pkg_src' directory.

As this collection of scripts is developed, this file will primarily function as a description/"prototype" of what the PKGBUILD will do,
and the PKGBUILD will be crafted using the information present in this document as a guide.

## Directories ##

### Directory Structure ###

#### Production/Package Installation ####

* /opt/archlinux-hosting-scripts - base/root directory of package
  * ./templates                  - various templates used by the scripts
    * ./config-files             - config file templates, either to be copied/modified, or sourced by the scripts
      * ./nginx                  - templates for nginx: global configs, vhost templates, webapp templates, and more
      * 

#### Development/Source (Manual) Installation ####
*NOTE: This layout shall also describe the structure of the git repository itself. Directories and files that will be ignored via the ".gitignore" file will be prepended
with a caret (^).*

* ./ - When installed, the installation root will be "/opt/archlinux-hosting-scripts-devel"
  * ./arch_pkg_src - contains the PKGBUILD, and other supporting files necessary for 'makepkg' to create a package suitable for installation
  * ./src          - contains all source for the package
    * ./lib          - contains libraries/support scripts necessary for proper function of the scripts
      * ./contrib    - contains 3rd-party scripts, not created by the "archlinux-hosting-scripts" team
    * ./scripts      - the good stuff, the scripts you've been waiting for
    * iptables_mgmt
    * rsyslog_mgmt

### Details ###

The base directory for this package will be '/opt/archlinux-hosting-scripts/', with symlinks to the various scripts being located in '/opt/archlinux-hosting-scripts/bin/'.

The path containing the symlinks will be added to the $PATH environment variable through use of '/etc/profile.d/archlinux-hosting-scripts.sh', and (at some point), bash-completion
functions shall be added, as well.

As the scripts evolve, it is likely that multiple symlinks will call the same script (file), yet perform different functions. 

Configuration will be located in '/etc/archlinux-hosting-scripts/'

## Manual Installation ##

Manual installation has the potential to be useful in specific scenarios, such as utilizing a "live" development (git) version, and being able to actively develop while
the scripts are being used for "production". A script, "manual_install.sh", will be provided to assist with this scenario. The manual installation script will install
the package under '/opt/archlinux-hosting-scripts-devel/', and will set "AHS_DEVEL=1" in the header of each script, allowing concurrent installation of the PKGBUILD built
version and a "live" development version. The PKGBUILD-based version will initially (and likely always) be a "-git" package, rather than a "versioned" package. The manual
installation script shall provide an appropriate ".gitignore" file, facilitating easy creation of git commits/pull requests.