# Dockerfile for Marand Think!EHR Server

FROM openjdk:8-jdk-slim-stretch

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y curl zip rsync --no-install-recommends \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

LABEL org.label-schema.vendor="Marand" \
      org.label-schema.url="http://marand.si/" \
      org.label-schema.name="ThinkEHR Server" \
      org.label-schema.version="$THINKEHR_VER" \
      org.label-schema.docker.schema-version="1.0" \
      com.inidus.maintainer="Inidus" \
      com.inidus.contact="Inidus <contact@inidus.com>"

COPY entrypoint.sh /entrypoint.sh

WORKDIR /thinkehr

COPY thinkehr ./

VOLUME /thinkehr/logs /thinkehr/indexes

EXPOSE 8080 7779 7778 7777

CMD ["/entrypoint.sh"]
