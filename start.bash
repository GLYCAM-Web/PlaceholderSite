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

if [ "${1}zzz" == "zzz" ] ; then
	echo "websiteLocation must be specified"
	echo "${USAGE}"
	exit 1
fi

export DOMAIN=${1}
export SiteName=${DOMAIN//./$'-'}

. make_html.bash

COMMAND="docker stack deploy \
        --compose-file docker-compose.yml \
	${SiteName}"

echo ${COMMAND}
eval ${COMMAND}
