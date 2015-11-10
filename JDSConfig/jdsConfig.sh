#!/bin/bash
#
##########################################################################################
#
# Copyright (c) 2013, John Kitzmiller.  All rights reserved.
#
#       THIS SOFTWARE IS PROVIDED BY John Kitzmiller "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL John Kitzmiller, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
##########################################################################################
#
# SUPPORT FOR THIS PROGRAM
#
#       This program is distributed "as is" by John Kitzmiller.
#		Please visit http://www.johnkitzmiller.com/contact for support.
#
##########################################################################################
#
# ABOUT THIS PROGRAM
#
# NAME
#	jdsConfig.sh
#
# SYNOPSIS - How to use
#
# 		Run this script after running the JDS Installer.pkg on an OS X Server.
# 		This script can be run locally, hardcoding the jssURL, jdsUser, jdsPass, and
#		allowInvalidCert variables, or it can be run from the JSS using Parameters 4-7.
#
#
# DESCRIPTION
#
# 		This script uses the jamfds binary to configure and enroll a JDS on OS X server
#		into a JSS.
#
####################################################################################################
#
# HISTORY
#
#	Version: 1.0
#
#	- Created by John Kitzmiller on July 13 2013
#
####################################################################################################

############ VARIABLES ############

jssURL=$4

jdsUser=$5

jdsPass=$6

allowInvalidCert=$7

dnsName=`hostname`

########## END VARIABLES ##########

# Do not modify below this line.

# Find jamfds binary location

jamfds=$(which jamfds)

# Check to make sure the jamfds binary is installed.

if [ ! -f "$jamfds" ];
	then
		echo "ERROR: jamfds binary not found. Please run the JDS installer before using this script."
		exit 2
fi

# Check to make sure parameter 7 is set, otherwise default to require a valid cert

if [ -z $allowInvalidCert ];
	then
		echo "Parameter 7 not set. Defaulting to require a valid certificate."
		allowInvalidCert="no"
fi

# Echo values for the log

echo "The JSS URL is $jssURL."
echo "The JSS Username is $jdsUser."
echo "The JDS Hostname is $dnsName."

# Create the jamfds config file

echo "Creating jamfds configuration file"

if [[ $allowInvalidCert == "yes" ]];
	then
		echo "The JDS will trust an invalid certificate."
		"$jamfds" createConf -url $jssURL -k

elif [[ $allowInvalidCert == "no" ]];
	then
		echo "The JDS will not trust an invalid certificate."
		"$jamfds" createConf -url $jssURL
fi

# Enroll the JDS

echo "Enrolling JDS..."

"$jamfds" enroll -url $dnsName -u $jdsUser -p $jdsPass

"$jamfds" policy

# Reboot - in my testing this was needed for the JDS to function properly.

if [ -f usr/sbin/jamf ];
	then
		echo "Rebooting and submitting logs to the JSS..."
		jamf reboot -background -immediately
	else
		echo "Rebooting..."
		reboot
fi

exit 0
