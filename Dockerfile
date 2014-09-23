FROM phusion/baseimage:0.9.13

MAINTAINER Nestor G. Pestelos, Jr. "nestor@aelogica.com"

RUN apt-get -y update && apt-get -y upgrade

RUN locale-gen en_US

RUN apt-get -y install autoconf automake \
  bison build-essential \
  cron curl gawk git imagemagick \
  libc6-dev libcurl4-openssl-dev \
  language-pack-en libmysqlclient-dev libncurses5-dev \
  libffi-dev libgdbm-dev \
  libpq-dev libreadline6 libreadline6-dev \
  libsqlite3-dev libssl-dev libtool libv8-dev \
  libxml2-dev libxslt1-dev libyaml-dev \
  openssl pkg-config python \
  screen software-properties-common \
  sqlite3 sudo syslog-ng unzip vim wget

RUN apt-add-repository ppa:brightbox/ruby-ng && apt-get -y update && apt-get -y install ruby2.1 ruby2.1-dev

ADD gemrc /etc/

RUN useradd deploy -c "Deploy User" -d /home/deploy -s /bin/bash

RUN mkdir -p /home/deploy

ADD bashrc /home/deploy/.bashrc
ADD bashrc /root/.bashrc

RUN mkdir -p /home/deploy/.gem && chown -R deploy:deploy /home/deploy
