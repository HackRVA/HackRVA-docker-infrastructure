FROM golang:1.8.5-jessie

RUN go get github.com/joho/godotenv
# create a working directory
WORKDIR /go/src/app
# add source code
ADD *.go src/
# add env file
ADD . /go/src/app

# build main.go
RUN go build -o um3wooter src/*.go

RUN apt-get update && \
  apt-get install -y \ 
  cron \
  ca-certificates 

# Add crontab file in the cron directory
RUN touch /etc/cron.d/um3
# # Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/um3
# Setup cronjob
RUN echo '*/5 * * * * cd /go/src/app && ./um3wooter' > /etc/cron.d/um3
# # Apply cron job
RUN crontab /etc/cron.d/um3

CMD cron -f