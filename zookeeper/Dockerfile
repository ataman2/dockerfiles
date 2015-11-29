FROM java:8-jre
MAINTAINER bochen

ENV ZK_VERSION 3.4.6
ENV ZK_XMS 256m
ENV ZK_XMX 512m

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-"$ZK_VERSION"/zookeeper-"$ZK_VERSION".tar.gz | tar -xzf - -C /opt \
	&& mv /opt/zookeeper-"$ZK_VERSION" /opt/zookeeper \
	&& cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
	&& echo "export JVMFLAGS=\"-Xmx"${ZK_XMX}" -Xms"${ZK_XMS}"\"" > /opt/zookeeper/conf/java.env \
	&& mkdir -p /tmp/zookeeper

WORKDIR /opt/zookeeper
COPY log4j.properties conf/

VOLUME ["/tmp/zookeeper"]
EXPOSE 2181 2888 3888

CMD ["bin/zkServer.sh", "start-foreground"]
