#!/bin/bash

# Set the title of alert windows
title="PretendCo IT Alerts"

# Define the path to the icon file
icon="/Library/CocoaDialog/JAMFlogo.png"

# Define the path to Cocoa Dialog
CD="/Library/CocoaDialog/CocoaDialog.app/Contents/MacOS/CocoaDialog"

# Define the path to self service
selfService="/Applications/Self Service.app"

# Set the 
alertText="4"
alertSubtext="5"
remindText="6"
remindSubtext="7"
policyID="8"
policyEvent="9"

#### Begin Functions###


function policy()
{
if [ ! -z "$policyID" ];
	then
		jamf policy -id $policyID
fi
	
if [ ! -z "policyEvent" ];
	then
		jamf policy -event $policyEvent
fi
}

function alertPrompt()
{
# Prompt the user to execute a policy
	result1=`$CD msgbox --float ‑‑no‑newline --icon-file "$icon" \
	--title "$title" \
	--text "$alertText" \
	--informative-text "$alertSubtext" \
	--button1 "OK" --button2 "Remind me later"`

# Echo for the log	
echo "User chose button $result1"

}

function remindPrompt()
{
# remind that the user will be reminded later and offer to open self service
	result2=`$CD msgbox --float ‑‑no‑newline --icon-file "$icon"  \
	--title "$title" \
	--text "$remindText"	\
	--informative-text "$remindSubtext" \
	--button1 "OK" --button2 "Launch Self Service"`
	
# Echo for the log
echo "User chose button $result2"
}

#### Begin Main Program ####

alertPrompt

if [ "$result1" == "1" ];
	then
		policy
elif [ "$result1" == "2" ];
	then
		remindPrompt
		if [ "$result2" == "1" ];
			then
				exit 0
		elif [ "$result2" == "2" ];
			then
				open "$selfService"
				exit 0
		fi
fi

echo "ERROR: Something went wrong."

exit 1