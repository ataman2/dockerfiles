FROM bochen/storm-base:0.9.6
MAINTAINER bochen

RUN /usr/bin/config-supervisord.sh supervisor
RUN /usr/bin/config-supervisord.sh logviewer

EXPOSE 6700 8000 9797
CMD /usr/bin/start-supervisor.sh
