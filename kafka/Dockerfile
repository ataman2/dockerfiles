FROM java:8-jre
MAINTAINER bochen

ENV SCALA_VERSION 2.10
ENV KAFKA_VERSION 0.8.2.2
ENV KAFKA_HOME /opt/kafka_$SCALA_VERSION-$KAFKA_VERSION

ENV KAFKA_XMS 512m
ENV KAFKA_XMX 512m

RUN wget -q -O - http://mirrors.ibiblio.org/apache/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz | tar -xzf - -C /opt \
	&& sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zk:2181/' $KAFKA_HOME/config/server.properties

WORKDIR $KAFKA_HOME
COPY docker-entrypoint.sh bin/
COPY log4j.properties config/

VOLUME ["/tmp/kafka-logs"]
EXPOSE 9092 9898

ENTRYPOINT ["bin/docker-entrypoint.sh"]
CMD ["bin/kafka-server-start.sh", "config/server.properties"]
