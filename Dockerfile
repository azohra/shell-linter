FROM koalaman/shellcheck-alpine:stable

RUN apk update && apk add --no-cache bash
RUN bash --version

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
