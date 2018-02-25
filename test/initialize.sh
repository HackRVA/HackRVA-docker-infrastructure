#!/usr/bin/bash

# Set to not use certbot
echo "false" > ./gateway/use_certbot

# Create the persist directories
if [ ! -d ./persist ]; then
  mkdir persist
fi

if [ ! -d ./persist/mysql ]; then
  mkdir persist/mysql
fi

if [ ! -d ./persist/images ]; then
  mkdir persist/images
fi

# Create the database initialization script
initdb_dir="./database/init"
# This is generally just for testing purposes, doesn't need great security
mw_user="hackrva_mw"
mw_db="hackrva_mw"
mw_pw="mwpw"

if [ ! -d $initdb_dir ]; then
  mkdir "$initdb_dir"
fi

init_path="$initdb_dir/1.init.sql"
add_user_path="$initdb_dir/2.add_mw_user.sql"
# echo "CREATE DATABASE \`$mw_db\`;" > "$add_user_path"
echo "GRANT ALL PRIVILEGES ON \`$mw_db\`.* TO '$mw_user'@'%' IDENTIFIED BY '$mw_pw';" >> "$add_user_path"
cp "test/wiki/init.sql" "$init_path"

# Prepare the repository for building
# Copy the LocalSettings.php file for the wiki
cp "test/wiki/LocalSettings.php" "wiki/LocalSettings.php"

