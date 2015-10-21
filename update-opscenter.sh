#!/bin/bash

curl \
-X POST \
-d \
"{
	\"cassandra\": {
		\"seed_hosts\": \"$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' cassandra)\"
	},
	\"cassandra_metrics\": {},
	\"jmx\": {
		\"port\": \"7199\"
	}
}" http://$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' opscenter):8888/cluster-configs
