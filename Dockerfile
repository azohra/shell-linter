FROM alpine:3.13.6

RUN apk update && apk add --no-cache bash
RUN bash --version 

COPY ./src/install_shellcheck.sh ./install_shellcheck.sh
RUN ./install_shellcheck.sh

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]