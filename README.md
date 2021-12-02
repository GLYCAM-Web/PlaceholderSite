# Placeholder Site

This repo sill spin up a very simple placeholder site.

Requirements:  docker, docker-compose

Optional:  docker swarm

To start a site:

`bash start.sh   # will spin up a site at 'localhost:goodPort' `

`bash start.sh test.glycam.org  # will spin up a site at test.glycam.org (need swarm) `

You can find information including the value of 'goodPort' in `SITE_SETTINGS.bash`.

You can override certain setings in `LocalSettings.bash`.

To take the site down:

`bash stop.sh`   # from the same directory

