FROM httpd:alpine AS hackrva-games

# Install git
RUN apk update && apk add \
  git

COPY ./index.html /usr/local/apache2/htdocs/index.html
RUN git clone https://github.com/Matt5sean3/moon-defender /usr/local/apache2/htdocs/moon-defender
RUN git clone https://github.com/Matt5sean3/city-smasher /usr/local/apache2/htdocs/city-smasher

VOLUME /usr/local/apache2/htdocs/img
VOLUME /usr/local/apache2/htdocs/css

EXPOSE 80
