#!/bin/bash

# Logging
touch /var/log/postImagingConfig.log

# Redirect stderr to stdout and print all to log
exec 2>&1 > >(tee -a /var/log/postImagingConfig.log)
NOW="$(date +"%Y-%m-%d-%H-%M")"
echo "Post Imaging Configuration started $NOW"

icon="/usr/local/postImagingConfig/resources/icon.png"

jamf=$(which jamf)

jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

# Check if JAMF binary exists
if [[ -e "$jamf" ]]

	then /bin/echo "Jamf binary present, continuing as planned..."

	else /bin/echo "Jamf binary is not present, we need to halt"

	exit 1

fi

# Check to make sure the machine has enrolled before continuing
/bin/echo "Checking enrollment..."
until [ ! -f "/Library/Application Support/JAMF/FirstRun/Enroll/enroll.sh" ]
    do
        /bin/echo "Machine is not enrolled. Trying enrollment."

        # Attempt enrollment

        /Library/Application\ Support/JAMF/FirstRun/Enroll/enroll.sh

        # Test if enrollment completed, sleep and try again if not

        if [ ! -f "/Library/Application Support/JAMF/FirstRun/Enroll/enroll.sh" ]
        	then
        		break
        	else
        		sleep 30
        fi
    done
/bin/echo "Enrollment complete"

# Fires up JAMF Helper. Notifies the user that their machine is being modified. Mouse clicks are ignored.
"$jamfHelper" -windowType fs -icon $icon -description "Post imaging configuration in progress, please wait." &

# Checking to make sure the JSS is available before proceeding
"$jamf" checkJSSConnection -retry 0
until [ $? = 0 ]
	do
		"$jamf" checkJSSConnection -retry 0
	done

# Enforce management framework, update inventory and run all config policies
"$jamf" manage
"$jamf" recon
"$jamf" policy -event config

# Update inventory one last time since we installed software
"$jamf" recon

# Clean up and reboot
/bin/echo "Cleaning up..."
/bin/rm -rf /usr/local/postImagingConfig/
/bin/rm -f /Library/LaunchDaemons/com.pretendco.firstrun.plist
NOW="$(date +"%Y-%m-%d-%H-%M")"
/bin/echo "Imaging completed $NOW"

# Reboot
"$jamf" reboot -immediately

exit 0
