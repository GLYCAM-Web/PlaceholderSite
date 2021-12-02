#!/usr/bin/env bash
#
##
## Setup for the placeholder sites
##
#
## Set default values
#
MainDomain='glycam.org'  ## the domain that is not a development domain
BackUpDateTime=''  ## Applies only to the main site - time the site should be back up by
LowPort='58000'  ## lowest local, non-traefik-access port to consider
HighPort='58009'  ## highest local, non-traefik-access port to consider
##
#
## Read in LocalSettings.bash if it exists
#
# The file LocalSettings.bash is git-ignored and can be used to override defaults above
if [ -f "LocalSettings.bash" ] ; then
	. LocalSettings.bash
fi
##
#
## Determine an open port to use
#
echo "Initializing the placeholder site"
echo "First, finding a good port"
if isSwarmNode ; then
	usedPorts=$(docker service ls --format "{{.Ports}}")
else 
	usedPorts=$(docker ps -a --format "{{.Ports}}")
fi
i=${LowPort}
goodPort="None"
while [ "${i}" -le "${HighPort}" ] ; 
do
        if [[ "${thePorts}" != *"5808${i}"* ]] ; then
                export goodPort="${i}"
                echo "Found a good port : ${goodPort}:"
                break
        else
                echo "port 5808${i} is in use"
        fi
	i=$((i+1))
done
if [ "${goodPort}" == "None" ] ; then
	echo "Unable to find an unused port."
        echo "Consider setting a different range in the LocalSettings.bash file"
	echo "Exiting."
	exit 1
fi
##
#
## Ensure that the htdocs directory exists
#
# The htdocs directory is mounted into the nginx container
if [ ! -d htdocs ] ; then
	if ! mkdir htdocs ; then
		echo "Could not find or make the htdocs directory.  Exiting."
		exit 1
	fi
fi
##
#
