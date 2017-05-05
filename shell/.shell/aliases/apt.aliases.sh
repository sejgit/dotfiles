#!/bin/bash
# apt.aliases.sh
# sej 2016 03 15
# 2017 03 20 update to change which to hash so-as to work with arch linux
# 2017 05 05 update to make faster for darwin

# set apt aliases

if [ $(uname -s) == "Linux" ]; then
    function _set_pkg_aliases()
    {
	if hash apt 2>/dev/null; then
	    alias apts='apt-cache search'
	    alias aptshow='apt-cache show'
	    alias aptinst='sudo apt-get install -V'
	    alias aptupd='sudo apt-get update'
	    alias aptupg='sudo apt-get dist-upgrade -V && sudo apt-get autoremove'
	    alias aptupgd='sudo apt-get update && sudo apt-get dist-upgrade -V && sudo apt-get autoremove'
	    alias aptrm='sudo apt-get remove'
	    alias aptpurge='sudo apt-get remove --purge'
	    alias chkup='/usr/lib/update-notifier/apt-check -p --human-readable'
	    alias chkboot='cat /var/run/reboot-required'
	    alias pkgfiles='dpkg --listfiles'
	fi
    }

    _set_pkg_aliases
fi

