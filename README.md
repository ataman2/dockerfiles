dockerfiles
===========

My dockerfiles inspired by many different implementations widely available on the internet.
All images are based on **java:8-jre** image.

Currently available technologies:
* cassandra (with datastax agent)
* kafka
* opscenter
* storm
* zookeeper

They might be run separately or as a whole cluster using docker-compose.

### Usage

Build all images:

* ```./build.sh```

Start a cluster:

* ```docker-compose up```

Increase amount of cassandras and supervisors to 3:

* ```docker-compose scale scalable-cassandra=2 storm-supervisor=3```

Inject cassandra cluster information to opscenter:

* ```./update-opscenter.sh```

Direct access to container:

* ```docker exec -i -t cassandra bash```

### Access to services

* OpsCenter ```http://localhost:8888/```

* Storm UI ```http://localhost:9999/```

* ```kafka-topics.sh --zookeeper $(docker inspect --format='{{ .NetworkSettings.IPAddress }}' zookeeper):2181 --create --replication-factor 1 --partition 1 --topic test```

* ```kafka-topics.sh --zookeeper $(docker inspect --format='{{ .NetworkSettings.IPAddress }}' zookeeper):2181 --describe```

* ```cqlsh $(docker inspect --format='{{ .NetworkSettings.IPAddress }}' cassandra) 9042```

* ```nodetool --host $(docker inspect --format='{{ .NetworkSettings.IPAddress }}' cassandra) status```

* ```storm jar topology.jar com.your.package.AwesomeTopology -c nimbus.host=$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' storm-nimbus) -c nimbus.thrift.port=6627```
