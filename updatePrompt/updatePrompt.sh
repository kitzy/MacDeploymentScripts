#!/bin/bash
#
####################################################################################################
#
# Copyright (c) 2014, kitzy.org.  All rights reserved.
#
#       THIS SOFTWARE IS PROVIDED BY KITZY.ORG AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#####################################################################################################
#
# SUPPORT FOR THIS PROGRAM
#
#       This program is distributed "as is" by kitzy.org. For more
#       information or support for this script, please visit http://github.com/kitzy
#
#####################################################################################################
#
# ABOUT THIS PROGRAM
#
# NAME
#	updatePrompt.sh
#
# SYNOPSIS - How to use
#	
#
# DESCRIPTION
# 	
#
####################################################################################################
#
# HISTORY
#
#	Version: 1.0
#
#	- Created by John Kitzmiller on May 28 2014
#
####################################################################################################


# Path for JAMF Helper - this should not need to be changed
jamfHelper='/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper'

## Assign variables from JSS

applicationTitle="$4"
processName="$5"
customTrigger="$6"


####################################################################
######## Use the below variables to change the alert window ########
####################################################################

# Title of the alert window
title="IT Alerts"

# Icon displayed in the alert window
icon="/Library/CocoaDialog/JAMFlogo.png"

# Bold heading of the alert window
heading1="Update ${applicationTitle}"

# Main text of the alert window
description1="${applicationTitle} needs to quit before being updated. Please save all work before clicking OK."

######## Functions ########

# This is the main prompt function. It relies on the heading and description passed to it
# as parameters 1 and 2, respectively. Even though we're only using this once by default,
# this part was written as a function to simplify the code if the script is expanded to
# provide more prompts for the user.

function promptUser()
{
	promptResult=""
	
	promptResult=`"${jamfHelper}" -lockHUD -windowType utility -icon "$icon" \
	-title "$title" \
	-heading "$1" \
	-alignHeading center \
	-description "$2" \
	-button1 "OK" -button2 "Cancel" \
	-defaultButton "1"`
}

####################################
######## Begin main program ########
####################################

# Get application PID
PID=`ps aux | grep -w "$processName" | grep -v grep | awk '{print $2}'`

if [ ! -z "$PID" ] # Detect if application is running
	then
		# Prompt user to quit the running application
		echo "$applicationTitle is running, prompting user to quit"
		promptUser "$heading1" "$description1"
		if [[ $promptResult = 0 ]] # 0 indicates user clicked button 1
			then
				echo "User clicked OK"
				# Ask application to quit
				osascript -e "tell application \"$applicationTitle\" to quit"
				# Call install policy via custom trigger
				jamf policy -event $customTrigger
				exit 0
		elif [[ $promptResult = 2 ]] # 2 indicates user clicked button 2
			then
				# Echo for the log, then exit
				echo "User clicked Cancel"
				exit 0
		elif [[ $promptResult = 1 ]] # 1 indicates jamfHelper was unable to launch
			then
				echo "ERROR: jamfHelper returned status 1: unable to launch"
				exit 1
			else
				# If jamfHelper returns anything other than 0, 1 or 2,
				# report an error to the JSS and exit
				echo "an unknown error occurred"
				exit 2
		fi
	else
		echo "$applicationTitle not running, moving on to silent intstall"
		# Call the install policy via custom trigger without prompting user
		jamf policy -event $customTrigger
		exit 0
fi
