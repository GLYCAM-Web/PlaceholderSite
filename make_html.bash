#!/usr/bin/env bash
##
## Generates the html for the placeholder site
##
##
## The variable "DOMAIN" should be defined in the calling script (start.bash)
##
#
# For develpment sites:
htmlToDeploy="""
<h1>Hello from ${DOMAIN}!</h1>
The development site that normally lives at ${DOMAIN} is on bardo right now.
It should be reincarnated soon. </p>
We apologize for any inconvenience. </p>
In the meantime, please see our main site, <a href=\"https://${MainDomain}\">main website</a>.
"""
#
# For the main site: 
TimeFixedText="We do not yet know when the site will be back up."
if [ "${BackUpDateTime}zzz" != "zzz" ] ; then
	TimeFixedText="We expect the site to be back up by: ${BackUpDateTime}."
fi
if [ "${DOMAIN}" == "${MainDomain}" ] ; then
htmlToDeploy="""
<h1>Hello from ${DOMAIN}!</h1>
The site that normally lives at ${DOMAIN} is down for maintenance.
The development team has been informed.  </p>
${TimeFixedText} </p>
We apologize for any inconvenience. </p>
"""
fi

echo "${htmlToDeploy}" > htdocs/index.html
