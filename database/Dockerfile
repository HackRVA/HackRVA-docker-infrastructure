# Keeping the database a separate container allows database backing up to be done in one place
FROM mariadb:10.2
# Needs to expose port 3306 to other docker containers for connecting to mysql
EXPOSE 3306
# Mount mysql settings as a volume
VOLUME /etc/mysql/conf.d
# Use a volume for the database storage
VOLUME /var/lib/mysql
# Mount scripts for creating a new database user
VOLUME /docker-entrypoint-initdb.d

