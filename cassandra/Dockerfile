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
	&& rm -rf /var/lib/apt/lists/* \
	&& sed -ri 's/^(rpc_address:).*/\1 0.0.0.0/; ' "$CASSANDRA_CONFIG/cassandra.yaml" \
	&& sed -i 's/^start_rpc.*$/start_rpc: true/' "$CASSANDRA_CONFIG/cassandra.yaml" \
	&& sed -i 's/^\(LOCAL_JMX=\).*/\1no/' "$CASSANDRA_CONFIG/cassandra-env.sh" \
	&& sed -i 's/\(jmxremote.authenticate=\).*/\1false"/' "$CASSANDRA_CONFIG/cassandra-env.sh" \
	&& sed -i '/jmxremote.password/s/^/#/' "$CASSANDRA_CONFIG/cassandra-env.sh"

COPY docker-entrypoint.sh /
COPY supervisord.conf /etc/supervisor/conf.d/

ENTRYPOINT ["/docker-entrypoint.sh"]
VOLUME ["/var/lib/cassandra"]

EXPOSE 7000 7001 7199 9042 9160
CMD ["/usr/bin/supervisord"]
