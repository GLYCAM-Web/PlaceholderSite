#!/usr/bin/env bash
##
## Generates the html for the placeholder site
##
##
## The variable "DOMAIN" should be defined in the calling script (start.bash)
##
## Warning, copy pasta:
## Attempting to prevent page caching. This is done by adding the head and meta
##		tags, as demonstrated on this site. Hard to test until deployed. 
##		https://cristian.sulea.net/blog/disable-browser-caching-with-meta-html-tags/

#
# For develpment sites:
htmlToDeploy="""
<head>
<meta http-equiv='Cache-Control' content='no-cache, no-store, must-revalidate' />
<meta http-equiv='Pragma' content='no-cache' />
<meta http-equiv='Expires' content='0' />
</head>
<body>
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
</body>
"""
fi

echo "${htmlToDeploy}" > htdocs/index.html
