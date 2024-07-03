# Use the official Ubuntu image as a base
FROM ubuntu:latest

# Create a directory for backups
RUN mkdir /backup

# Set the working directory
WORKDIR /backup

# Add the backup script to the container
ADD backup.sh .

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    cron \
    mysql-client

# Add crontab file in the cron directory
RUN touch /etc/cron.d/db-backup

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/db-backup

# Setup cron job to run every day at 1am
RUN echo '0 1 * * * cd /backup && sh backup.sh' > /etc/cron.d/db-backup

# Apply cron job
RUN crontab /etc/cron.d/db-backup

# Run cron in the foreground
CMD ["cron", "-f"]

