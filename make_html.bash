#!/usr/bin/env bash
##
## Generates the html for the placeholder site
##

## The htdocs directory is mounted into the nginx container
if [ ! -d htdocs ] ; then
	if ! mkdir htdocs ; then
		echo "Could not find or make the htdocs directory.  Exiting."
		exit 1
	fi
fi

##
## The variable "DOMAIN" should be provided by the calling script (start.bash)
##
htmlToDeploy="""
<h1>Hello from ${DOMAIN}!</h1>
The development site that normally lives at ${DOMAIN} is on bardo right now.
It should be reincarnated soon. 
"""

echo "${htmlToDeploy}" > htdocs/index.html
