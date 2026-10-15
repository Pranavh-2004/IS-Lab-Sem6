FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get purge -y unattended-upgrades && \
    apt-get install -y --no-install-recommends \
        nasm \
        binutils \
        gcc \
        gcc-multilib \
        libc6-dev-i386 \
        gdb \
        make \
        vim \
        python3 \
        python3-pip \
        strace \
        file \
        xxd \
        netcat-openbsd \
        iproute2 \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /lab

CMD ["/bin/bash"]