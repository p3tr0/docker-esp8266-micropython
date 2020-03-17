#### enqack/esp8266-micropython
FROM phusion/baseimage:0.9.19

RUN apt-get update \
    && apt-get install -y \
    apt-utils \
    autoconf \
    automake \
    bash \
    bison \
    build-essential \
    flex \
    gawk \
    gcc \
    g++ \
    git \
    gperf \
    help2man \
    libexpat-dev \
    libffi-dev \
    libreadline-dev \
    libtool \
    libtool-bin \
    make \
    ncurses-dev \
    pkg-config \
    python \
    python-dev \
    python-serial \
    python-setuptools \
    texinfo \
    sed \
    unrar-free \
    unzip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --no-create-home micropython \
    && git clone --recursive https://github.com/pfalcon/esp-open-sdk.git \
    && chown -R micropython:micropython esp-open-sdk

USER micropython

RUN cd /esp-open-sdk && make STANDALONE=y

ENV PATH=/esp-open-sdk/xtensa-lx106-elf/bin:$PATH

USER root

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh && /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["build"]
