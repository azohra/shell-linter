FROM alpine:3.10.3

RUN echo "http://dl-5.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
    apk update && apk add --no-cache shellcheck bash
    
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]