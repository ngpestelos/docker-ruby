FROM phusion/baseimage:0.9.10

RUN apt-get update

RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update

RUN apt-get install -y ruby2.1
RUN apt-get install -y build-essential
RUN apt-get install -y curl libcurl4-openssl-dev ca-certificates
RUN apt-get install -y git-core
