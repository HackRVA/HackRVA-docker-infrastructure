# Uses alpine as the default uses debian distribution too old to use certbot
FROM httpd:alpine AS hackrva-gateway

RUN apk update

# This docker image functions to route incoming http connections to the proper container internally
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf

# Expose sites based on a mounted volume
VOLUME /usr/local/apache2/conf/sites

# Expose ports
EXPOSE 80
EXPOSE 443
