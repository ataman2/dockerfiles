#!/bin/bash
set -e
export IP=`hostname -i`

sed -ri 's/^(rpc_address:).*/\1 0.0.0.0/; ' "$CASSANDRA_CONFIG/cassandra.yaml"
sed -i 's/^start_rpc.*$/start_rpc: true/' "$CASSANDRA_CONFIG/cassandra.yaml"

# change heap sizes
sed -i 's/#MAX_HEAP_SIZE=\"4G\"/MAX_HEAP_SIZE=\"'${CASSANDRA_XMX}'\"/' "$CASSANDRA_CONFIG/cassandra-env.sh"
sed -i 's/#HEAP_NEWSIZE=\"800M\"/HEAP_NEWSIZE=\"'${CASSANDRA_XMS}'\"/' "$CASSANDRA_CONFIG/cassandra-env.sh"

# enable insecure JMX
sed -i 's/^\(LOCAL_JMX=\).*/\1no/' "$CASSANDRA_CONFIG/cassandra-env.sh"
sed -i 's/\(jmxremote.authenticate=\).*/\1false"/' "$CASSANDRA_CONFIG/cassandra-env.sh"
sed -i '/jmxremote.password/s/^/#/' "$CASSANDRA_CONFIG/cassandra-env.sh"
echo 'JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname='${IP}'"' >> "$CASSANDRA_CONFIG/cassandra-env.sh"

# setup datastax-agent
echo "stomp_interface: opscenter" >> /var/lib/datastax-agent/conf/address.yaml
echo "use_ssl: 0" >> /var/lib/datastax-agent/conf/address.yaml

: ${CASSANDRA_LISTEN_ADDRESS='auto'}
if [ "$CASSANDRA_LISTEN_ADDRESS" = 'auto' ]; then
	CASSANDRA_LISTEN_ADDRESS="$IP"
fi

: ${CASSANDRA_BROADCAST_ADDRESS="$CASSANDRA_LISTEN_ADDRESS"}

if [ "$CASSANDRA_BROADCAST_ADDRESS" = 'auto' ]; then
	CASSANDRA_BROADCAST_ADDRESS="$IP"
fi
: ${CASSANDRA_BROADCAST_RPC_ADDRESS:=${CASSANDRA_BROADCAST_ADDRESS}}

if [ -n "${CASSANDRA_NAME:+1}" ]; then
	: ${CASSANDRA_SEEDS:="cassandra"}
fi
: ${CASSANDRA_SEEDS:="$CASSANDRA_BROADCAST_ADDRESS"}

sed -ri 's/(- seeds:) "127.0.0.1"/\1 "'"$CASSANDRA_SEEDS"'"/' "$CASSANDRA_CONFIG/cassandra.yaml"

for yaml in \
broadcast_address \
broadcast_rpc_address \
cluster_name \
endpoint_snitch \
listen_address \
num_tokens \
; do
	var="CASSANDRA_${yaml^^}"
	val="${!var}"
	if [ "$val" ]; then
		sed -ri 's/^(# )?('"$yaml"':).*/\2 '"$val"'/' "$CASSANDRA_CONFIG/cassandra.yaml"
	fi
done

for rackdc in dc rack; do
	var="CASSANDRA_${rackdc^^}"
	val="${!var}"
	if [ "$val" ]; then
		sed -ri 's/^('"$rackdc"'=).*/\1 '"$val"'/' "$CASSANDRA_CONFIG/cassandra-rackdc.properties"
	fi
done

exec "$@"
