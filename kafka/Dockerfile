FROM java:8-jre
MAINTAINER bochen

ENV SCALA_VERSION 2.10
ENV KAFKA_VERSION 0.8.2.2
ENV KAFKA_HOME /opt/kafka_$SCALA_VERSION-$KAFKA_VERSION

RUN wget -q -O - http://mirrors.ibiblio.org/apache/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz | tar -xzf - -C /opt \
	&& sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zk:2181/' $KAFKA_HOME/config/server.properties

WORKDIR $KAFKA_HOME
COPY kafka-config-start.sh bin/

VOLUME ["/tmp/kafka-logs"]
EXPOSE 9092 9898

ENTRYPOINT ["bin/kafka-config-start.sh"]
CMD ["bin/kafka-server-start.sh", "config/server.properties"]
