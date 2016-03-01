FROM ubuntu:14.04
MAINTAINER gpwclark
RUN apt-get update && apt-get install -y \
  rvm \
  nodejs \
  npm
RUN rvm install 2.0.0
RUN mkdir -p /gpwclark.github.io
COPY . /gpwclark.github.io/
WORKDIR /gpwclark.github.io/
#EXPOSE 4000
RUN gem install jekyll
#ENTRYPOINT ["myblog"]
#CMD ["jekyll serve --watch"]
