FROM phusion/baseimage:0.9.10

MAINTAINER Nestor G. Pestelos, Jr. "nestor@aelogica.com"

RUN apt-get -y update &&\
    apt-get -y install software-properties-common &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe" &&\
    apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get -y install build-essential curl wget \
                       libcurl4-openssl-dev ca-certificates \
                       git vim tmux libsqlite3-dev nodejs \
                       libssl-dev libyaml-dev libtool \
                       libxml2-dev gawk \
                       pngcrush imagemagick \
                       language-pack-en sudo cron \
                       rsyslog \
                       ruby2.1 ruby2.1-dev

RUN echo 'gem: --no-document' &&\
    gem update --system &&\
    gem install bundler

RUN apt-get clean && locale-gen en_US

RUN gem install mini_portile -v 0.5.3 &&\
    gem install nokogiri -v 1.6.1

RUN gem install rails -v 4.1.1 &&\
    gem install bcrypt -v 3.1.7 &&\
    gem install sprockets-rails -v 2.1.3 &&\
    gem install haml -v 4.0.5 &&\
    gem install sqlite3 -v 1.3.9

RUN gem install devise -v 3.2.4 &&\
    gem install foundation-rails -v 5.2.2.0 &&\
    gem install paper_trail -v 3.0.1

RUN gem install cucumber -v 1.3.14 &&\
    gem install pry -v 0.9.12.6 &&\
    gem install capybara -v 2.2.1 &&\
    gem install minitest -v 5.3.3 &&\
    gem install rspec-rails -v 2.14.2

RUN apt-add-repository ppa:nginx/stable && \
    apt-get -y update && \
    apt-get -y install nginx

RUN apt-get -y install syslog-ng screen

RUN gem install unicorn --version '~> 4.8' &&\
    gem install jbuilder --version '~> 2.0' &&\
    gem install sass-rails --version '~> 4.0' &&\
    gem install uglifier --version '~> 1.3' &&\
    gem install coffee-rails --version '~> 4.0' &&\
    gem install jquery-rails --version '~> 3.1' &&\
    gem install turbolinks --version '~> 2.2' &&\
    gem install therubyracer --version '~> 0.12'

RUN mkdir /data

ADD nginx.conf /etc/nginx/nginx.conf
ADD nginx.default.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
ADD start_nginx /data/
RUN chown root:root /data/start_nginx
RUN chmod +x /data/start_nginx
RUN mkdir -p /etc/service/nginx && ln -s /data/start_nginx /etc/service/nginx/run
