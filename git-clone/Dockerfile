FROM withinboredom/consul-agent

MAINTAINER Robert Landers <landers.robert@gmail.com>

RUN apt-get update && \
	apt-get install -y git ca-certificates ssh && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

ENV HOME /root

RUN mkdir /root/.ssh && \
	ssh-keyscan -p2200 github.com > /root/.ssh/known_hosts

ADD root /

ENTRYPOINT ["git"]