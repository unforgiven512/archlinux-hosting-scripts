# archlinux-hosting-scripts #

## Overview ##
This project aims to provide a collection of scripts to prepare/install, configure, manage, and maintain various hosting services -- on Arch Linux.

### Hosted Services ###

#### Initial Services ####
Initially, the scripts will focus on the following software:
* nginx     - high-performance HTTP server
* mariadb   - open source relational database, forked from MySQL
* php       - extremely popular interpreted language, with a vast array of webapps available
  * php-fpm - "fast process manager" for PHP, for interfacing with nginx (per-user pool setup, etc.)
* postfix   - a popular mail transfer agent
  * postfixadmin - a web-based administration utility, written in PHP, for managing postfix
* dovecot   - a popular, secure POP3/IMAP server
* rsyslog   - an extremely flexible, lightweight, and versatile syslog daemon; deployment is focused on collecting logs from remote devices (systemd-journald collects local logs)
* znc       - an extremely popular IRC "bouncer", allowing an "always-on" connection to your favorite IRC channels, even while you're away

#### Long-term Goals ####
Over time, it is likely that support will be added for...:
* node.js / npm
* A jabber server (undecided, at the moment):
  * jabberd2
  * ejabberd
* murmur (mumble server)
* mono/asp.net
* apache
* tomcat
* iperf
* ntpd
* tor
* openvpn
* monitorix

### System Administration ###
Additionally, scripts will be included to help with general system administration...

#### Initial Administration Support ####
Initial support will assist with managing:
* iptables
* pacman/yaourt
* etckeeper
* Configuration of some software (via globals in '/etc/' and per-user in '/etc/skel/' or '/home/${user}/'):
  * sudo              - enable the "wheel" group for sudo access
  * GNU screen        - "~/.screenrc" file, with extra "sudo" windows for members of the "wheel" group
  * bash              - (Global) '/etc/bash.bashrc' as well as per-user '~/.bashrc'
  * yaourt            - optimizations to '/etc/yaourtrc' and '~/.yaourtrc'
  * makepkg           - optimizations to '/etc/makepkg.conf' and '~/.makepkg.conf'
  * mkinitcpio        - add some bare-bones configuration of the "MODULES=()" array, using the modules for the hypervisor set in config
  * nginx             - along with the management of nginx (as listed above), a "vhost"-style directory structure will be set up to ease configuration
  * systemd-networkd  - generation of the '/etc/systemd/network/eth0-static.network' file from the settings in the config, disable any netctl/dhclient/dhcpcd services
  * systemd-resolved  - creation of the necessary symlinks
  * systemd-timesyncd - enable systemd to handle NTP, if full 'ntpd' is unnecessary
* SSL certificates --
  * nginx
  * dovecot
  * znc
  * jabber server (jabberd2/ejabberd)
  * systemd-journal-remote
  * system CA certificates
* SSH server options
  * X11 forwarding
  * public-key authentication
  * port forwarding and gateway functionality

#### Long-term Goals ####
On the radar:
* logrotate
* fail2ban
* scponly
* sudo -- more fine-grained control of permissions, etc.
* sysctl's (using "##-sysctl.conf" files in '/etc/sysctl.d/')
* advanced systemd functionality
  * user-mode systemd
  * boot analysis
  * coredump control
  * journal control
    * maximum disk usage
    * centralized logging
    * log levels
  * general systemd configuration
  * advanced configuration of "systemd-resolved" and "systemd-timesyncd"
  * advanced systemd-networkd functionality
* Kernel module handling:
  * "modprobe.d"
  * "modules-load.d"
* tmp file handling:
  * "tmpfiles.d"
  * additional tmpfs mounts (ie: tmpfs for mariadb)
* shared-installs of pacman-managed webapps (ie: wordpress, phpmyadmin, mediawiki, etc.)
* Advanced SSL management
  * CAs
  * CRLs
  * OCSP
* GnuPG management
* Management of parameters in '/etc/security/'
* Management of "pam" authentication
* Management of Java environment(s)
* Advanced networking features:
  * IP/Layer3 routing
  * Network Load Balancing
  * haproxy
  * IPsec tunnels
  * GRE tunnels
  * Virtual (private) networks
* LVM (Logical Volume Management) tools
* Management of additional databases and data sources (ie: postgresql, sqlite, etc.)
* LDAP
* RADIUS
* PolicyKit authorization
* Additional shell customization
* Kerberos
* Samba
  * SMB over VPN
  * Active Directory
  * Domain Controller
  * Member Server
  * Authentication
  * RODC (Read-Only Domain Controller)
* NFS
* D-Bus configuration
* cron/systemd.timer (scheduled tasks) management
* Event Notifications:
  * Email
  * Real-time XMPP notifications
  * PushBullet integration?
* And more!

### Additional Packages ###
It would be nice to support some of the following packages, for system management, reporting, etc.
* nagios
* collectd
* MeshCentral
  * I've already created a systemd ".service" unit file for the mesh agent
  * The process of signing up for a new account, and creating a new mesh could be (at least somewhat) automated
  * The mesh ID (hash) could be stored in a config file

### Centralized Configuration ###
For configuration that would be common amongst a group of hosts, a central repository, preferably under VCS (git), to host the config files
would be great. The slave hosts could check at a set interval (ie: 30 minutes) for updates to the repository, and pull down changes as-needed,
keeping all hosts in sync.

## Contact Information ##
If you have any questions, comments, or ideas, use the tools located on the source code repo (repo locations listed below), check out our website,
or contact us using the information provided.

[GitHub](https://github.com/unforgiven512/archlinux-hosting-scripts)
[BitBucket](https://bitbucket.org/unforgiven512/archlinux-hosting-scripts)
[Unforgiven Development](http://unforgivendevelopment.com)
