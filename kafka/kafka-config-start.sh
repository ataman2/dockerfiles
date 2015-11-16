#!/bin/bash

function hostname_hash() {
  hash=$(md5sum <<< "$1" | cut -b 1-6)
  echo $((0x${hash%% *}))
}

hostname="${HOSTNAME:-localhost}"
server_properties="${KAFKA_HOME}/config/server.properties"
server_start_bin="${KAFKA_HOME}/bin/kafka-server-start.sh"
cd "${KAFKA_HOME}"

sed -i "s/-Xmx1G -Xms1G/-Xmx512m -Xms512m/g" "${server_start_bin}"

sed -i "s/#advertised.host.name.*/advertised.host.name=${hostname}/" "${server_properties}"

sed -i "s/broker.id=0/broker.id=${KAFKA_BROKER_ID:-$(hostname_hash ${hostname})}/" "${server_properties}"

sed -i -e "s/log.retention.check.interval.ms=300000/log.retention.check.interval.ms=60000/" "${server_properties}"

sed -i -e "s/num.recovery.threads.per.data.dir=1/num.recovery.threads.per.data.dir=4/" "${server_properties}"

if [[ -n "${KAFKA_LOG_RETENTION_HOURS}" ]] ; then
  sed -i -e "s/log.retention.hours=168/log.retention.hours=${KAFKA_LOG_RETENTION_HOURS}/" "${server_properties}"
fi

if [[ -n "${KAFKA_LOG_RETENTION_BYTES}" ]] ; then
  sed -i -e "s/.*log.retention.bytes=.*/log.retention.bytes=${KAFKA_LOG_RETENTION_BYTES}/" "${server_properties}"
fi

if [[ -n "${KAFKA_LOG_SEGMENT_BYTES}" ]] ; then
  sed -i -e "s/.*log.segment.bytes=.*/log.segment.bytes=${KAFKA_LOG_SEGMENT_BYTES}/" "${server_properties}"
fi

if [[ -n "${ZOOKEEPERS}" ]] ; then
  sed -i "s/zookeeper.connect=zk:2181/zookeeper.connect=${ZOOKEEPERS}/" "${server_properties}"
fi

if ! grep -q "auto.leader.rebalance.enable=true" "${server_properties}"; then
  echo "auto.leader.rebalance.enable=true" >> "${server_properties}"
fi

if ! grep -q "delete.topic.enable=true" "${server_properties}"; then
  echo "delete.topic.enable=true" >> "${server_properties}"
fi

export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.rmi.port=9898"
exec "$@"
