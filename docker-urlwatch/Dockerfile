#
# Dockerfile for urlwatch
#

FROM alpine:3.10

RUN set -xe \
    && apk add --no-cache ca-certificates \
                          py-cryptography \
                          build-base      \
                          libffi-dev      \
                          libxml2         \
                          libxml2-dev     \
                          libxslt         \
                          libxslt-dev     \
                          openssl-dev     \
                          python3         \
                          python3-dev     \
    && python3 -m pip install appdirs   \
                              cssselect \
                              keyring   \
                              lxml      \
                              minidb    \
                              pyyaml    \
                              requests  \
                              chump     \
                              urlwatch  \
    && apk del build-base  \
               libffi-dev  \
               libxml2-dev \
               libxslt-dev \
               openssl-dev \
               python3-dev

VOLUME /root/.urlwatch
WORKDIR /root/.urlwatch

ADD run.sh          /run.sh
ADD urlwatch.yaml   /urlwatch.yaml

#CMD ["urlwatch", "--cache", "/root/.urlwatch/urlwatch.db"]
ENTRYPOINT ["/run.sh"]
