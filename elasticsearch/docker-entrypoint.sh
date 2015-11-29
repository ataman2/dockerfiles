#!/bin/bash
set -e

CFG_FILE=${ES_HOME}/config/elasticsearch.yml

if [ -n "$ES_CLUSTER_NAME" ]; then
    echo 'cluster.name: '${ES_CLUSTER_NAME}'' >> ${CFG_FILE}
fi

if [ -n "$ES_NODE_NAME" ]; then
    echo 'node.name: '${ES_NODE_NAME}'' >> ${CFG_FILE}
fi

if [ -n "$ES_ENABLE_CLUSTER" ]; then
    echo 'discovery.zen.ping.unicast.hosts: ["es"]' >> ${CFG_FILE}
fi

exec "$@"
