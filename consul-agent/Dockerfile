# DOCKER-VERSION 1.0.0

FROM withinboredom/ubuntu-base
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Install Unzip
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV CONSUL_VERSION 0.5.0
ENV DATACENTER "local"
ENV MASTER ""

# Download and install Consul
RUN curl -sSLO https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip && \
    unzip ${CONSUL_VERSION}_linux_amd64.zip && \
    chmod +x consul && \
    mv consul /usr/local/bin/consul && \
    rm ${CONSUL_VERSION}_linux_amd64.zip && \
    groupadd -r consul && \
    useradd -r -g consul consul && \
    mkdir -p /data && \
    chown -R consul:consul /data

VOLUME ["/data"]

ADD root /

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 53 53/udp
