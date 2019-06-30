FROM ubuntu:latest

RUN set -eux; \
    apt-get update && \
    apt-get install -yq build-essential flex flex-doc bison bison-doc
