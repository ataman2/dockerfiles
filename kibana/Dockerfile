FROM java:8-jre
MAINTAINER bochen

ENV KIBANA_VERSION 4.3.0
ENV KIBANA_HOME /opt/kibana-$KIBANA_VERSION-linux-x64

RUN wget -q -O - https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz | tar -xzf - -C /opt \
    && sed -i -e "s/# elasticsearch.url: \"http:\/\/localhost:9200\"/elasticsearch.url: \"http:\/\/es:9200\"/g" $KIBANA_HOME/config/kibana.yml \
    && $KIBANA_HOME/bin/kibana plugin --install elasticsearch/marvel/latest \
	&& $KIBANA_HOME/bin/kibana plugin --install elastic/sense \
	&& groupadd -r kibana \
    && useradd -r -m -g kibana kibana \
    && chown -R kibana:kibana $KIBANA_HOME

WORKDIR $KIBANA_HOME

COPY docker-entrypoint.sh bin/

USER kibana
EXPOSE 5601

ENTRYPOINT ["bin/docker-entrypoint.sh"]
CMD ["bin/kibana"]
