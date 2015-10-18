#!/bin/bash

docker run -d --name opscenter -p 8888:8888 bochen/opscenter:5.2.1

CLUSTER_NAME=Bochen
OPS_IP=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' opscenter)

docker run -d --name cassandra1 -p 9042:9042 -p 9160:9160 -p 7199:7199 -e CASSANDRA_CLUSTER_NAME=${CLUSTER_NAME} -e OPS_IP=${OPS_IP} bochen/cassandra:2.2.2

SEEDS_IP=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' cassandra1)

docker run -d --name cassandra2 -e CASSANDRA_CLUSTER_NAME=${CLUSTER_NAME} -e OPS_IP=${OPS_IP} -e CASSANDRA_SEEDS=${SEEDS_IP} bochen/cassandra:2.2.2

curl \
-X POST \
-d \
"{
	\"cassandra\": {
		\"seed_hosts\": \"${SEEDS_IP}\"
	},
	\"cassandra_metrics\": {},
	\"jmx\": {
		\"port\": \"7199\"
	}
}" http://${OPS_IP}:8888/cluster-configs

docker run -d --name zookeeper -p 2181:2181 -p 2888:2888 -p 3888:3888 bochen/zookeeper:3.4.6

docker run -d --name kafka -p 9092:9092 -p 9898:9898 -e KAFKA_LOG_RETENTION_HOURS=1 --link zookeeper:zk bochen/kafka:0.8.2.2
