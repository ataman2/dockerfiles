#!/bin/bash

docker build -t="bochen/datastax-base" datastax-base
docker build -t="bochen/opscenter:5.2.2" opscenter
docker build -t="bochen/cassandra:2.2.3" cassandra
docker build -t="bochen/zookeeper:3.4.6" zookeeper
docker build -t="bochen/kafka:0.8.2.2" kafka
docker build -t="bochen/storm-base:0.10.0" storm-base
docker build -t="bochen/storm-nimbus:0.10.0" storm-nimbus
docker build -t="bochen/storm-supervisor:0.10.0" storm-supervisor
docker build -t="bochen/storm-ui:0.10.0" storm-ui
