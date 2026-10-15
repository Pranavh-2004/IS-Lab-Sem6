FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Disable unattended upgrades completely
RUN apt-get update && \
    apt-get purge -y unattended-upgrades && \
    apt-get install -y --no-install-recommends \
        nasm \
        binutils \
        gcc \
        gdb \
        make \
        vim \
        python3 \
        python3-pip \
        libc6-dev-i386 \
        gcc-multilib \
        strace \
        file \
        xxd \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory similar to SEED VMs
WORKDIR /lab

# Keep container alive like SEED containers
CMD ["/bin/bash"]