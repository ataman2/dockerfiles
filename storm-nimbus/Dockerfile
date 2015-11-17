FROM bochen/storm-base:0.10.0
MAINTAINER bochen

RUN /usr/bin/config-supervisord.sh nimbus
RUN /usr/bin/config-supervisord.sh drpc
ADD start-supervisor.sh /usr/bin/start-supervisor.sh

EXPOSE 3772 3773 6627
CMD /usr/bin/start-supervisor.sh
