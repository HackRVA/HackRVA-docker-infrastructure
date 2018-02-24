# Uses alpine as the default uses debian distribution too old to use certbot
FROM httpd:alpine AS hackrva-gateway

# Install certbot and openssl
# OpenSSL is mostly necessary for the testing system
RUN apk update && apk add \
  openssl \
  certbot

# This docker image functions to route incoming http connections to the proper container internally
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
# Create local certs
COPY ./update_local_certs.sh /bin/update_local_certs.sh
COPY ./update_certbot_certs.sh /bin/update_certbot_certs.sh
COPY ./https_domains /etc/https_domains
COPY ./wellknown_index.html /etc/wellknown_index.html
COPY ./domains /etc/domains
# Expose sites based on a mounted volume
VOLUME /usr/local/apache2/conf/sites

# Expose ports
EXPOSE 80
EXPOSE 443

COPY ./certbot-renew.sh /etc/periodic/daily/certbot-renew.sh
# Need to use our own modified httpd-foreground script to update certs
COPY ./httpd-foreground /usr/local/bin/httpd-foreground
# Add information about whether to use certbot or not
COPY ./use_certbot /etc/use_certbot

VOLUME /etc/letsencrypt

