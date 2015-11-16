FROM bochen/storm-base:0.9.6
MAINTAINER bochen

RUN /usr/bin/config-supervisord.sh ui

EXPOSE 8080
CMD /usr/bin/start-supervisor.sh
