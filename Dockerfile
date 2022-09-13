FROM alpine:3.16

COPY ./src/install_shellcheck.sh ./install_shellcheck.sh
COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache bash; \
    bash --version; \
    ./install_shellcheck.sh

ENTRYPOINT ["/entrypoint.sh"]