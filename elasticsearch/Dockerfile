FROM java:8-jre
MAINTAINER bochen

ENV ES_VERSION 2.1.0
ENV ES_HOME /usr/share/elasticsearch
ENV ES_HEAP_SIZE 512m

RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" > /etc/apt/sources.list.d/elasticsearch-2.x.list \
	&& wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends elasticsearch=$ES_VERSION \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR $ES_HOME
RUN mkdir config data logs

RUN bin/plugin install license
RUN bin/plugin install marvel-agent

COPY docker-entrypoint.sh bin/
COPY elasticsearch.yml config/
COPY logging.yml config/

RUN chown -R elasticsearch: config data logs
USER elasticsearch

VOLUME ["/usr/share/elasticsearch/data"]
EXPOSE 9200 9300

ENTRYPOINT ["bin/docker-entrypoint.sh"]
CMD ["bin/elasticsearch"]
