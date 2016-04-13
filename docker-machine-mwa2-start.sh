#!/bin/bash

# Munki container variables
# Edit this line to point to your munki_repo. It must be within /Users somewhere
MUNKI_REPO="/Users/glgrp/src/munki_repo"
# Create a new folder to house the Django database and point to it here:
MWA2_DB="/Users/glgrp/src/mwa2-db"
# Comment this out or set to '' to disable git
#GIT_PATH='/usr/bin/git'

# Check that Docker Machine exists
if [ -z "$(docker-machine ls | grep mwa2)" ]; then
	docker-machine create -d vmwarefusion --vmwarefusion-disk-size=10000 --vmwarefusion-memory-size=2048 mwa2
	docker-machine env mwa2
	eval "$(docker-machine env mwa2)"
fi

# Check that Docker Machine is running
if [ "$(docker-machine status mwa2)" != "Running" ]; then
	docker-machine start mwa2
	docker-machine env mwa2
	eval "$(docker-machine env mwa2)"
fi

# Get the IP address of the machine
IP=`docker-machine ip mwa2`

# Clean up
# This checks whether munki munki-do etc are running and stops them
# if so (thanks to Pepijn Bruienne):
docker ps -a | sed "s/\ \{2,\}/$(printf '\t')/g" | \
	awk -F"\t" '/munki|mwa2/{print $1}' | \
	xargs docker rm -f
	

# This isn't needed for MWA2 to operate, but is needed if you want a working
# Munki server
docker run -d --restart=always --name="munki" -v $MUNKI_REPO:/munki_repo \
	-p 80:80 -h munki groob/docker-munki

# This is optional for complicated builds. It's essential if you're using gitlab in the docker-machine. 
# docker build -t="grahamrpugh/mwa2" .


# munki-do container
docker run -d --restart=always --name mwa2 \
	-p 8000:8000 \
	-v $MUNKI_REPO:/munki_repo \
	-v $MWA2_DB:/mwa2-db \
	grahamrpugh/mwa2


echo
echo "### Your Docker Machine IP is: $IP"
echo "### Your mwa2 URL is: http://$IP:8000"
echo


