#!/bin/bash

if [ -z ${DOCKER_HOST+x} ]; then
        export OPSIP=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' opscenter)
else
        export OPSIP=$(echo $DOCKER_HOST | awk -F '/' '{print $3}' | awk -F ':' '{print $1}')
fi

curl -X POST -d \
"{
	\"cassandra\": {
		\"seed_hosts\": \"$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' cassandra)\"
	},
	\"cassandra_metrics\": {},
	\"jmx\": {
		\"port\": \"7199\"
	}
}" http://$OPSIP:8888/cluster-configs

