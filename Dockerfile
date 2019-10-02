From ubuntu:18.04

RUN apt-get update \ 
    && apt-get install -qy shellcheck 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]