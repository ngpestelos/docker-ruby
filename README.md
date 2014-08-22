docker-ruby
===========

Base image for Ruby 

### Features

* runs ruby as a non-root user (deploy)
* installs commonly-used gems (e.g. nokogiri)

### Usage

    $ docker build .
    $ docker run -it --rm <image-id> /bin/bash
    $ su deploy
    $ ruby --version