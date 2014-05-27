FROM phusion/baseimage:0.9.10

MAINTAINER Nestor G. Pestelos, Jr. "nestor@aelogica.com"

RUN apt-get -y update &&\
    apt-get -y install software-properties-common &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe" &&\
    apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get -y install build-essential curl wget \
                       libcurl4-openssl-dev ca-certificates \
                       git vim tmux libsqlite3-dev nodejs \
                       libssl-dev libyaml-dev libtool \
                       libxml2-dev gawk \
                       pngcrush imagemagick \
                       language-pack-en sudo cron \
                       rsyslog

RUN echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
    mkdir /src && cd /src && git clone https://github.com/sstephenson/ruby-build.git &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build && ruby-build 2.1.1 /usr/local

RUN gem update --system &&\
    gem install bundler

RUN apt-get clean && locale-gen en_US

RUN gem install mini_portile -v 0.5.3 &&\
    gem install nokogiri -v 1.6.1

RUN gem install rails -v 4.1.1 &&\
    gem install devise -v 3.2.4 &&\
    gem install foundation -v 5.2.2 &&\
    gem install cucumber -v 1.3.14 &&\
    gem install capybara -v 2.2.1 &&\
    gem install paper_trail -v 3.0.1 &&\
    gem install bcrypt -v 3.1.7 &&\
    gem install sprockets-rails -v 2.1.3 &&\
    gem install haml -v 4.0.5 &&\
    gem install sqlite3 -v 1.3.9 &&\
    gem install pry -v 0.9.12.6
