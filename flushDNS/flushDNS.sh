#!/bin/bash

MAJOR_MAC_VERSION=$(sw_vers -productVersion | awk -F '.' '{print $1 "." $2}')

if [ "${MAJOR_MAC_VERSION}" = "10.12" ] || [ "${MAJOR_MAC_VERSION}" = "10.11" ] || [ "${MAJOR_MAC_VERSION}" = "10.10" ] || [ "${MAJOR_MAC_VERSION}" = "10.9" ] || [ "${MAJOR_MAC_VERSION}" = "10.8" ] || [ "${MAJOR_MAC_VERSION}" = "10.7" ]
	then
	    echo "Flushing DNS cache for Sierra, El Capitan, Mavericks, Mountain Lion or Lion"
		killall -HUP mDNSResponder
elif [ "${MAJOR_MAC_VERSION}" = "10.6" ] || [ "${MAJOR_MAC_VERSION}" = "10.5" ] || [ "${MAJOR_MAC_VERSION}" = "10.4" ]
	then
	    echo "Flushing DNS cache for Snow Leopard and earlier"
		dscacheutil -flushcache
	else
		echo "ERROR: OS not supported"
		exit 1
fi

exit 0
