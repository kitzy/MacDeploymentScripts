#!/bin/bash 

# Logging
touch /var/log/postImagingConfig.log
    
# Redirect stderr to stdout and print all to log
exec 2>&1 > >(tee -a /var/log/postImagingConfig.log)
NOW="$(date +"%Y-%m-%d-%H-%M")"
echo "Post Imaging Configuration started $NOW"

# Check if JAMF binary exists
if [[ -e /usr/sbin/jamf ]]

	then /bin/echo "Jamf binary present, continuing as planned..."
	
	else /bin/echo "Jamf binary is not present, we need to halt" 
	
	exit 1

fi

# Fires up Big Honking Text. Notifies the user that their machine is being modified. Mouse clicks are ignored.
/usr/local/postImagingConfig/resources/BigHonkingText -w 100% -h 100% -m -p 0 "  Post imaging configuration in progress, please wait.  " &

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

# Checking to make sure the JSS is available before proceeding
/usr/sbin/jamf checkJSSConnection -retry 0
until [ $? = 0 ]
	do
		/usr/sbin/jamf checkJSSConnection -retry 0
	done

# Enforce management framework, update inventory and run all config policies
/usr/sbin/jamf manage
/usr/sbin/jamf recon
/usr/sbin/jamf policy -event config

# Update inventory one last time since we installed software
/usr/sbin/jamf recon

# Clean up and reboot
/bin/echo "Cleaning up..."
/bin/rm -rf /usr/local/postImagingConfig/
/bin/rm -f /Library/LaunchDaemons/com.pretendco.firstrun.plist
NOW="$(date +"%Y-%m-%d-%H-%M")"
/bin/echo "Imaging completed $NOW"

# Reboot
/usr/sbin/jamf reboot -immediately

exit 0