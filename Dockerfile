FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# SteamCMD 常见必需的 32位运行库 + 证书
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        # DST x64 依赖（amd64）
        libcurl3-gnutls \
        libstdc++6 \
        libgcc-s1 \
        # SteamCMD 32位依赖（i386）
        libc6:i386 \
        libstdc++6:i386 \
        libgcc-s1:i386 \
        libcurl4:i386 \
        libtinfo6:i386 && \
    rm -rf /var/lib/apt/lists/*

# workspace 作为 steam 用户的 home（你会整目录挂载它）
RUN mkdir -p /workspace && chmod 755 /workspace && \
    useradd -m -d /workspace -s /bin/bash steam

USER steam
WORKDIR /workspace

VOLUME ["/workspace"]