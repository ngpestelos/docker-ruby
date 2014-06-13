FROM phusion/baseimage:0.9.10

MAINTAINER Nestor G. Pestelos, Jr. "nestor@aelogica.com"

RUN apt-get -y update &&\
    apt-get -y install software-properties-common &&\
    apt-add-repository ppa:brightbox/ruby-ng &&\
    apt-add-repository ppa:nginx/stable &&\
    apt-get -y update &&\
    apt-get -y upgrade

RUN apt-get -y install apt-transport-https autoconf automake \
  bison build-essential ca-certificates \
  cron curl gawk git imagemagick \
  libc6-dev libcurl4-openssl-dev \
  language-pack-en libncurses5-dev libreadline6 libreadline6-dev \
  libsqlite3-dev libssl-dev libtool libv8-dev \
  libxml2-dev libxslt1-dev libyaml-dev nginx \
  openssl pkg-config redis-server ruby2.1 ruby2.1-dev \
  screen sudo syslog-ng vim wget

RUN apt-get clean && locale-gen en_US

RUN echo 'gem: --no-document' &&\
    gem update --system &&\
    gem install bcrypt -v 3.1.7 &&\
    gem install bundler &&\
    gem install mini_portile -v 0.5.3 &&\
    gem install nokogiri -v 1.6.1 &&\
    gem install rails -v 4.1.1 &&\
    gem install sprockets-rails -v 2.1.3 &&\
    gem install haml -v 4.0.5 &&\
    gem install sqlite3 -v 1.3.9 &&\
    gem install devise -v 3.2.4 &&\
    gem install foundation-rails -v 5.2.2.0 &&\
    gem install paper_trail -v 3.0.1 &&\
    gem install cucumber -v 1.3.14 &&\
    gem install pry -v 0.9.12.6 &&\
    gem install capybara -v 2.2.1 &&\
    gem install minitest -v 5.3.3 &&\
    gem install rspec-rails -v 2.14.2 &&\
    gem install unicorn --version '~> 4.8' &&\
    gem install jbuilder --version '~> 2.0' &&\
    gem install sass-rails --version '~> 4.0' &&\
    gem install uglifier --version '~> 1.3' &&\
    gem install coffee-rails --version '~> 4.0' &&\
    gem install jquery-rails --version '~> 3.1' &&\
    gem install turbolinks --version '~> 2.2' &&\
    gem install therubyracer --version '~> 0.12' &&\
    gem install sdoc --version '~> 0.4' &&\
    gem install spring --version '~> 1.0' &&\
    gem install modernizr-rails --version '~> 2.7' &&\
    gem install redis --version '~> 3.0' &&\
    gem install resque --version '~> 1.25'

RUN mkdir /data

ADD nginx.conf /etc/nginx/nginx.conf
ADD start_nginx /data/
RUN chown root:root /data/start_nginx
RUN chmod +x /data/start_nginx
RUN mkdir -p /etc/service/nginx && ln -s /data/start_nginx /etc/service/nginx/run

ADD start_redis /data/
RUN chown root:root /data/start_redis
RUN chmod +x /data/start_redis
RUN mkdir -p /etc/service/redis && ln -s /data/start_redis /etc/service/redis/run
