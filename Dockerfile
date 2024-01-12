FROM ubuntu:20.04
ARG RELEASE
ARG LAUNCHPAD_BUILD_ARCH
LABEL maintainer="Sumo Logic <docker@sumologic.com>"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update --quiet && \
 apt-get install -y --no-install-recommends apt-utils && \
 apt-get upgrade --quiet --allow-downgrades --allow-remove-essential --allow-change-held-packages -y && \
 apt-get install --quiet --allow-downgrades --allow-remove-essential --allow-change-held-packages -y wget && \
 wget -q -O /tmp/collector.deb https://stag-events.sumologic.net/rest/download/deb/64?version=19.467-2 && \
 dpkg -i /tmp/collector.deb && \
 rm /tmp/collector.deb && \
 apt-get clean --quiet && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY sumologic-collector-docker/run.sh /run.sh
ENTRYPOINT ["/bin/bash", "/run.sh"]
MAINTAINER Sumo Logic <docker@sumologic.com>
ADD sumologic-collector-docker/syslog/sumo-sources.json /etc/sumo-sources.json
EXPOSE 514/udp
EXPOSE 514