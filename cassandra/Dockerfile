FROM bochen/datastax-base
MAINTAINER bochen

ENV CASSANDRA_VERSION 2.2.3
ENV CASSANDRA_CONFIG /etc/cassandra

RUN apt-get install -y \
		sysstat \
		sudo \
		supervisor \
		dsc22="$CASSANDRA_VERSION"-1 \
		datastax-agent \
	&& rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
COPY supervisord.conf /etc/supervisor/conf.d/

ENTRYPOINT ["/docker-entrypoint.sh"]
VOLUME ["/var/lib/cassandra"]

EXPOSE 7000 7001 7199 9042 9160
CMD ["/usr/bin/supervisord"]
