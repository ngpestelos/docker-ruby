FROM phusion/baseimage:0.9.10

RUN apt-get -y update &&\
    apt-get -y install software-properties-common &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe" &&\
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe" &&\
    apt-get -y update &&\
    apt-add-repository ppa:brightbox/ruby-ng &&\
    apt-get -y update

RUN apt-get -y upgrade

RUN apt-get -y install ruby2.1 build-essential curl libcurl4-openssl-dev ca-certificates git vim tmux libsqlite3-dev nodejs

RUN gem install bundler
