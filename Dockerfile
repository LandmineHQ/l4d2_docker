FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN set -e; \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        lib32gcc-s1 \
        lib32stdc++6 \
        libcurl3-gnutls:i386 \
        libcurl3-gnutls && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace && chmod 755 /workspace && \
    useradd -m -d /workspace -s /bin/bash steam

USER steam
WORKDIR /workspace

VOLUME ["/workspace"]
