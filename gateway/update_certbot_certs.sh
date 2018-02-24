#!/bin/bash

# Get certs from certbot
function update_certbot_certs() {

  domains=$@

  # Don't run this too often or it will easily hit the rate limit
  for domain in $domains; do
  
    # Only run certbot newly if certs don't already exist
    cert_path="/etc/letsencrypt/live/$domain/fullchain.pem"
    if [ ! -f "$cert_path" ]; then
    
      echo "Getting new cert"
      
      certbot certonly \
        --agree-tos \
        --non-interactive \
        --webroot \
        -w "/usr/local/apache2/htdocs" \
        -d "$domain" \
        -m "hackrva@gmail.com"
    
    fi
  
  done
  
  echo "Try renewing on Let's Encrypt"
  /etc/periodic/daily/certbot-renew.sh
  
}

update_certbot_certs $domains

