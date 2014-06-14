#!/bin/bash
#
#####################################################################################################
#
# Better Update Prompt
#
#	Version: 1.0
#
#	Created by John Kitzmiller on 14 June 2014
#
#   This script is distributed "as is" by kitzy.org. For more information
#   or support for this script, please visit http://github.com/kitzy
#
####################################################################################################


# Path for JAMF Helper - this should not need to be changed
jamfHelper='/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper'

## Assign variables from JSS
applicationTitle="$4"
processNames="$5"
customTrigger="$6"

IFS="," # Set internal field separator to comma to saparate process names

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
description1="needs to quit before ${applicationTitle} can be updated.

Click OK to quit."

###########################
######## Functions ########
###########################

function promptUser()
{
# This is the main prompt function. It relies on the heading, description and process name
# passed to it as parameters 1, 2 and 3, respectively. Even though we're only using this once
# by default, this part was written as a function to simplify the code if the script is expanded
# to provide more prompts for the user.

	promptResult=""
	
	promptResult=`"${jamfHelper}" -lockHUD -windowType utility -icon "$icon" \
	-title "$title" \
	-heading "$1" \
	-alignHeading center \
	-description "$3 $2" \
	-button1 "OK" -button2 "Cancel" \
	-defaultButton "1"`
}

####################################
######## Begin main program ########
####################################

for process in $processNames
do

PID="" # Clear PID to elimnate false positives

PID=`pgrep "$process"` # Get application PID

if [ ! -z "$PID" ] # Detect if application is running
	then
		# Prompt user to quit the running application
		echo "$process is running, prompting user to quit"
		promptUser "$heading1" "$description1" "$process"
		if [[ $promptResult = 0 ]] # 0 indicates user clicked button 1
			then
				echo "User clicked OK"
				# Ask application to quit
				osascript -e "tell application \"$process\" to quit"
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
				echo "ERROR: an unknown error occurred"
				exit 2
		fi
	else
		echo "$process not running, moving on"
fi

done

	# Call the install policy via custom trigger without prompting user
	jamf policy -event $customTrigger
	exit 0