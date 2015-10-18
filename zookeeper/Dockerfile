FROM java:8-jre
MAINTAINER bochen

ENV ZK_VERSION 3.4.6

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-"$ZK_VERSION"/zookeeper-"$ZK_VERSION".tar.gz | tar -xzf - -C /opt \
	&& mv /opt/zookeeper-"$ZK_VERSION" /opt/zookeeper \
	&& cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
	&& mkdir -p /tmp/zookeeper

WORKDIR /opt/zookeeper
VOLUME ["/tmp/zookeeper"]
EXPOSE 2181 2888 3888
CMD ["bin/zkServer.sh", "start-foreground"]
