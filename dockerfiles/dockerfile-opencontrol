FROM alpine:3.4
MAINTAINER Tim Kropp @sometheycallme
ENV GOPATH=$HOME/go
# https://github.com/opencontrol/compliance-masonry/blob/master/docs/development.md

RUN apk upgrade --no-cache --available && \
    apk add --no-cache \
      go \
      bash \
      git \
      curl \ 
      tar \
      && curl -L https://github.com/opencontrol/compliance-masonry/releases/download/v1.1.2/compliance-masonry_1.1.2_linux_amd64.tar.gz -o compliance-masonry.tar.gz \
      && tar -xf compliance-masonry.tar.gz \
      && cp compliance-masonry_1.1.2_linux_amd64/compliance-masonry /usr/local/bin \
      && \
    :

ENTRYPOINT ["compliance-masonry"]
