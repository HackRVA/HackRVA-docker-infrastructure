# Uses alpine as the default uses debian distribution too old to use certbot
FROM httpd:alpine AS hackrva-gateway

# Install certbot
RUN apk update && apk add \
  certbot

# This docker image functions to route incoming http connections to the proper container internally
COPY ./httpd.conf.pre /usr/local/apache2/conf/httpd.conf.pre
COPY ./httpd.conf.post /usr/local/apache2/conf/httpd.conf
# Expose sites based on a mounted volume
VOLUME /usr/local/apache2/conf/sites

# Expose ports
EXPOSE 80
EXPOSE 443

COPY ./certbot-renew.sh /etc/periodic/daily/certbot-renew.sh
# Need to use our own modified httpd-foreground script to update certs
COPY ./httpd-foreground /usr/local/bin/httpd-foreground

VOLUME /etc/letsencrypt/live

