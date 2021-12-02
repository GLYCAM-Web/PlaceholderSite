#!/usr/bin/env bash
##
## Set up for and deploy a placeholder site
##

USAGE="""
Usage:

	start.bash websiteLocation

	where:

		websiteLocation is a URL where the website will live, e.g., 'test.glycam.org'
"""

isSwarmNode(){
    answer="$(docker info | grep Swarm | sed 's/Swarm: //g')"
    notSwarm='inactive'  
    if [[ "${answer}" == *"${notSwarm}"* ]] ; then
        return 1;
    else
        return 0;
    fi
}

echo "# Bringing up placeholder site on $(date) with the following settings:" > SITE_SETTINGS.bash

if [ "${1}zzz" == "zzz" ] ; then
	if isSwarmMode ; then
		echo "websiteLocation must be specified"
		echo "${USAGE}"
		exit 1
	else
		export SWARM=1 ## false
		export DOMAIN='localhost'
	fi
else
	export SWARM=0 ## true
	export DOMAIN=${1}
fi

export SiteName=${DOMAIN//./$'-'}

. setup.bash
. make_html.bash

echo """
export SWARM=${SWARM}
export DOMAIN="${DOMAIN}"
export SiteName="${SiteName}"
export goodPort=${goodPort}
""" >> SITE_SETTINGS.bash

if isSwarmNode ; then 
	COMMAND="docker stack deploy \
        	--compose-file docker-compose.yml \
        	--compose-file docker-compose_swarm_traefik.yml \
		${SiteName}"
else
	COMMAND="docker-compose  \
        	--file docker-compose.yml \
		-p ${SiteName} \
		up -d "
fi

echo ${COMMAND}
eval ${COMMAND}
