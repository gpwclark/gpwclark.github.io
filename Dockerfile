FROM phusion/baseimage
MAINTAINER gpwclark
RUN apt-get update && apt-get install -y \
  ruby-full \
  nodejs \
  npm
RUN mkdir -p /gpwclark.github.io
COPY . /gpwclark.github.io/
WORKDIR /gpwclark.github.io/
EXPOSE 4000
RUN gem install jekyll
ENTRYPOINT ["myblog"]
CMD ["jekyll serve --watch"]
