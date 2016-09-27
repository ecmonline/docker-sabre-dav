FROM phusion/baseimage:0.9.15
MAINTAINER Daniel Huhn <daniel.huhn@ecm.online>

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD docker /

RUN ./installAll.sh
VOLUME ["/var/www/files"]

EXPOSE 80
