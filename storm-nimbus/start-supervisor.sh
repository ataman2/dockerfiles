export IP=`hostname -i`
sed -i -e "s/%zookeeper%/$ZK_PORT_2181_TCP_ADDR/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%nimbus%/$IP/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%localhost%/$IP/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%worker_xms%/$WORKER_XMS/g" $STORM_HOME/conf/storm.yaml
sed -i -e "s/%worker_xmx%/$WORKER_XMX/g" $STORM_HOME/conf/storm.yaml
supervisord
