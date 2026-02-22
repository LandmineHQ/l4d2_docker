FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN set -e; \
    dpkg --add-architecture i386 && \
    apt update && \
    apt install -y --no-install-recommends \
        ca-certificates \
        libc6:i386 \
        libgcc-s1:i386 \
        libstdc++6:i386 \
        libcurl3-gnutls:i386 \
        libcurl3-gnutls && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace && chmod 755 /workspace && \
    useradd -m -d /workspace -s /bin/bash steam

USER steam
WORKDIR /workspace

VOLUME ["/workspace"]
