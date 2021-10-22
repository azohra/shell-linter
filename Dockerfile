FROM alpine:3.13.6

RUN ./src/install_shellcheck

RUN bash --version 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]