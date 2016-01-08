docker-mwa2
==========

This Docker container runs [MunkiWebAdmin2](https://github.com/munki/mwa2).
The container expects that your munki repo is mounted in /munki_repo.
To retain data, you should also create a folder on your host for the SQLite database 
to store its data. 
In order to function fully, munki-tools needs to be accessible (specifically, 
the `makecatalogs` command). This is achievable 
by running a munki container and linking it.

Several options, such as the timezone and admin password are customizable using environment variables.

#Munki container
You can run a linked munki container as follows:

```bash
docker run -d --restart=always --name="munki" -v $MUNKI_REPO:/munki_repo \
	-p 80:80 -h munki groob/docker-munki
```

The official guide on [linking containers](https://docs.docker.com/userguide/dockerlinks/) is very helpful.

#Image Creation
```$ docker build -t="grahamrpugh/mwa2" .```

#Running the MunkiWebAdmin2 Container

Run the following command. You need to set the host values of `$MUNKI_REPO` and 
`$MWA2_DB` either in a script or by altering the command:

```bash
docker run -d --restart=always --name mwa2 \
	-p 8000:8000 \
	-v $MUNKI_REPO:/munki_repo \
	-v $MWA2_DB:/mwa2-db \
	grahamrpugh/mwa2
```

The default admin username is "admin" and the default password is "password".

#One-step build-and-run

The repo contains an executable script named `docker-machine-mwa2-start.sh` which will create a 
_docker-machine_ and run munki and mwa2 containers. 
