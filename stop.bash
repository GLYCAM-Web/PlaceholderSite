#!/usr/bin/env bash
##
## Set up for and deploy a placeholder site
##

. SITE_SETTINGS.bash

if isSwarmNode ; then 
	COMMAND="docker stack rm \
		${SiteName}"
else
	COMMAND="docker-compose  \
        	--file docker-compose.yml \
		-p ${SiteName} \
                down "
fi

echo ${COMMAND}
eval ${COMMAND}
