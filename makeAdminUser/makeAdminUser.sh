#!/bin/bash 
#
####################################################################################################
#
# Copyright (c) 2013, JOHN KITZMILLER.  All rights reserved.
#
#       THIS SOFTWARE IS PROVIDED BY JOHN KITZMILLER "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JOHN KITZMILLER BE LIABLE FOR ANY
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
#       This program is distributed "as is" by John Kitzmiller. For more
#       information or support for this script, please visit kitzy.org.
#
#####################################################################################################
#
# ABOUT THIS PROGRAM
#
# NAME
#	makeAdminUser.sh
#
####################################################################################################
#
# HISTORY
#
#	Version: 1.0
#
#	- Created by John Kitzmiller
#
####################################################################################################

# Check to make sure $3 is set properly by the JSS, if not, set the current username manually
# This is a workaround for D-005003 (resolved in 9.01)

if [ -z $3 ]; 
    then 
        currentUser=`stat -f '%Su' /dev/console` 
    else 
        currentUser=$3 
fi 

# Add the current user to the local admin group on the Mac

dseditgroup -o edit -a $currentUser -t user admin

if [ "$?" == "0" ];
	then
		echo "Successfully added $currentUser to admin group"
	else
		echo "ERROR: Unable to add $currentUser to admin group"
		exit 1
fi

exit 0