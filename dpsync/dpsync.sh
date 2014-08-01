#!/bin/bash


# Edit the following variables to suit your environment


server="" #DNS name or IP address of the master distribution point server
sharename="" #Name of the master distribution point
username="" #Read only uername for the master distribution point
password="" #Password for the read only user account, alphanumeric only - special characters will cause a failure
targetshare="" #Absolute path to the local distribution point



####################################################################################################
######################################## Begin Main Program ########################################
####################################################################################################



# Test for special characters in password
if [[ "$password" =~ [^a-zA-Z0-9] ]]
	then
		echo "ERROR: special characters in password are not supported. Aborting"
		exit 1
fi

# Make sure CasperShare exists
if [ -d "$targetshare" ]
	then
		echo "Found CasperShare at $targetshare"
	else
		echo "ERROR: CasperShare not found at $targetshare. Aborting"
		exit 2
fi

# Make directory for CasperShare mount
mkdir "/Volumes/$sharename"
# Error checking
if [ "$?" == "0" ]
	then
		echo "Sucessfully created /Volumes/$sharename"
	else
		echo "ERROR: Unable to create /Volumes/$sharename. Aborting"
		exit 3
fi

# Mount CasperShare from master DP
mount_afp "afp://$username:$password@$server/$sharename" "/Volumes/$sharename"
# Error checking
if [ "$?" == "0" ]
	then
		echo "Sucessfully mounted CasperShare from master DP to /Volumes/$sharename"
	else
		echo "ERROR: Unable to mount CasperShare from master DP. Aborting"
		rm -rf "/Volumes/$sharename"
		exit 4
fi

# Sync contents of master DP to local CasperShare
rsync -avr --delete "/Volumes/$sharename/" "$targetshare"
# Error checking
if [ "$?" == "0" ]
	then
		echo "rsync completed sucessfully"
	else
		echo "NOTE: rsync returned a non-zero exit status"
fi

# Clean up
umount "/Volumes/$sharename"
# Error checking
if [ "$?" == "0" ]
	then
		echo "Sucessfully unmounted /Volumes/CasperShare"
	else
		echo "ERROR: Unable to unmount /Volumes/CasperShare."
		exit 5
fi

exit 0