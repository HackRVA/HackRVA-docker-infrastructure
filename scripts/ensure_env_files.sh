#!/bin/bash

ENV_FILES=(
  "./db.env"
  "./memberserver.env"
  "./hackmap.env"
  "./mediawiki.env"
  "./aptly.env"
)

declare -A DEFAULT_CONTENTS
DEFAULT_CONTENTS["./db.env"]="DB_HOST=database\nDB_USER=root\nDB_PASSWORD=secret"
DEFAULT_CONTENTS["./memberserver.env"]="SERVER_PORT=3000\nAPI_KEY=changeme"
DEFAULT_CONTENTS["./hackmap.env"]="MAP_KEY=default_map_key"
DEFAULT_CONTENTS["./mediawiki.env"]="MEDIAWIKI_DB_HOST=database\nMEDIAWIKI_DB_USER=root\nMEDIAWIKI_DB_PASSWORD=secret"
DEFAULT_CONTENTS["./aptly.env"]="APTLY_API_USER=admin\nAPTLY_API_PASSWORD=securepassword"

for FILE in "${ENV_FILES[@]}"; do
  if [ ! -f "$FILE" ]; then
    echo "Creating missing env file: $FILE"
    echo -e "${DEFAULT_CONTENTS[$FILE]}" > "$FILE"
  else
    echo "Env file already exists: $FILE"
  fi
done

echo "All required env files are ensured."

