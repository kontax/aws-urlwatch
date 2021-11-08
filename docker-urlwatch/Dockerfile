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

RUN addgroup -S urlwatch -g 1000 && \
    adduser -S urlwatch -G urlwatch -h /home/urlwatch -u 1000 -D

VOLUME /home/urlwatch/.urlwatch
WORKDIR /home/urlwatch/.urlwatch

ADD scripts/run.sh          /home/urlwatch/run.sh
ADD scripts/urlwatch.yaml   /home/urlwatch/urlwatch.yaml
ADD scripts/urls.yaml       /home/urlwatch/urls.yaml
RUN chown -R urlwatch:urlwatch /home/urlwatch
USER urlwatch

#CMD ["urlwatch", "--cache", "/root/.urlwatch/urlwatch.db"]
ENTRYPOINT ["/home/urlwatch/run.sh"]
