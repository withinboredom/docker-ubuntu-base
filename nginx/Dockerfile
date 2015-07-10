# DOCKER-VERSION 1.0.0

FROM withinboredom/consul-agent
MAINTAINER Robert Landers <landers.robert@gmail.com>

ENV ALLOW_DEBUG true

# Install nginx and have it forward logs to Docker
RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null

RUN apt-get update && \
    apt-get install -y nginx php5-fpm php5-mysql php-apc php5-curl php5-gd \
    php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcached php5-ming \
    php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xdebug && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chown -R www-data:www-data /var/lib/nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 80
EXPOSE 443
