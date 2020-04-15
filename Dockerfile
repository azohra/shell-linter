FROM alpine:3.10.3

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.11/community" >> /etc/apk/repositories; \
    apk update && apk add --no-cache bash shellcheck=0.7.0-r1

RUN bash --version && shellcheck --version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]