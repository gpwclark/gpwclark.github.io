FROM phusion/baseimage
MAINTAINER gpwclark
RUN apt-get install ruby-full rubygems nodejs npm
RUN gem install jekyll
VOLUME ./
PORT 
