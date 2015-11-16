FROM java:8-jre
MAINTAINER bochen

ENV STORM_VERSION 0.9.6
ENV STORM_HOME /opt/apache-storm-$STORM_VERSION

RUN apt-get update \
	&& apt-get install -y \
		sudo \
		supervisor \
	&& rm -rf /var/lib/apt/lists/* \
	&& wget -q -O - http://mirrors.sonic.net/apache/storm/apache-storm-$STORM_VERSION/apache-storm-$STORM_VERSION.tar.gz | tar -xzf - -C /opt \
	&& groupadd storm \
	&& useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm \
	&& chown -R storm:storm $STORM_HOME \
	&& mkdir /var/log/storm \
	&& chown -R storm:storm /var/log/storm \
	&& ln -s $STORM_HOME/bin/storm /usr/bin/storm

COPY supervisord.conf /etc/supervisor/conf.d/
COPY storm.yaml $STORM_HOME/conf/storm.yaml
COPY cluster.xml $STORM_HOME/logback/cluster.xml
COPY config-supervisord.sh /usr/bin/config-supervisord.sh
COPY start-supervisor.sh /usr/bin/start-supervisor.sh
