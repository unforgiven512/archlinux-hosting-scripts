# /etc/ahs(-devel)/install.conf #
(c) 2015 Gerad Munsch

## OVERVIEW:
This configuration file controls various aspects of the "initial-platform-setup"
scripts. Please note that -- in most cases -- it should be OK to retroactively 
change options here, and re-run the original script. I will do my best to make
note of cases where this will not work, and provide a workaround, if need be.

## PARAMETERS:
Following this brief note about formatting and structure, you will find a more
in-depth explanation of what each configuration option does. Additionally, this
is where I will try to include the aformentioned note about "after the fact"
changes not working properly. The parameter information will be broken down into
sections, and will be as close to the actual order in the config file itself as
is possible.

### SECTIONS:
Please note that some sections _may_ have sub-sections.

#### pacman:
* `AHS_INSTALL_CONFIGURE_PACMAN` - this parameter controls whether the installer will touch any of the following _pacman_-related options below
  * *DEFAULT*: Y
* `AHS_PACMAN_VERBOSE_PACKAGELISTS` - this parameter will cause _pacman_ to show a detailed table of package information during installs/upgrades
  * *DEFAULT*: Y
* `AHS_PACMAN_USE_COLOR` - this parameter will cause _pacman_ to use colorized output when run interactively in a capable terminal
  * *DEFAULT*: Y
* `AHS_PACMAN_USE_TOTALDOWNLOAD` - this parameter will cause _pacman_ to display, when downloading, the amount downloaded, download rate, ETA, and completed percentage of the entire download list, rather than the percent of each individual download target (package); the progress bar will still reflect the progress of each, individual package.
  * *DEFAULT*: N
* `AHS_PACMAN_CHECKSPACE_DISABLE` - *NOTE:* _It is not recommended to disable this option._ When enabled, _pacman_ will perform an approximate check for adequate available disk space before installing packages.
  * *DEFAULT*: N
* `AHS_PACMAN_SHARED_CACHE_PRESENT` - this parameter provides the scripts knowledge of whether a shared _pacman_ cache is in use, which changes the state of some configuration options to better handle that scenario
  * *DEFAULT*: N
* `AHS_PACMAN_REPO_MULTILIB_ENABLED` - if you don't think you'll ever need 32-bit support, you can go ahead and disable the _multilib_ repository by changing this to "N"
  * *DEFAULT*: Y
* `AHS_PACMAN_REPO_TESTING_ENABLED` - if you're feeling lucky, and want to test package(s) before they hit the main repos, go ahead and enable the _testing_ repo by changing this to "Y"
  * *DEFAULT*: N
