#! /bin/bash

plist="com.jamfsoftware.image.plist" # Absolute path to the plist

echo "<result>`defaults read $plist date`</result>"

exit 0