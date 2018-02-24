#!/bin/bash

# Generate local certs
function generate_local_certs() {

  domains=$@

  country_code="US"
  state="VA"
  location="Richmond"
  organization="HackRVA"
  organization_unit="NetworkRATs"

  ca_dir="/etc/snake"
  ca_key_path="$pkey_dir/snake.key"
  ca_cert_path="$pkey_dir/snake.pem"
  le_dir="/etc/letsencrypt"
  le_live_dir="/etc/letsencrypt/live"
  htdocs_path="/usr/local/apache2/htdocs"

  echo "Making own certificate authority"
  if [ ! -d $ca_dir ]; then
    mkdir $ca_dir
  fi
  
  if [ ! -f $ca_key_path ]; then
    # Create the root key
    openssl genpkey -out "$ca_key_path" -algorithm rsa -pkeyopt rsa_keygen_bits:2048
    # Remove any existing cert signature
    if [ -f "$ca_cert_path" ]; then
      rm "$ca_cert_path"
    fi
    # Remove any existing cert directories
    for domain in $domains; do
      domain_path="$le_dir/live/$domain"
      if [ -d "$domain_path" ]; then
        rm -r "$domain_path"
      fi
    done
  else
    echo "Certificate authority already exists"
  fi

  root_domain="hackrva.org"
  root_csr_subj="/C=$country_code/ST=$state/L=$location/O=$organization/OU=$organization_unit/CN=$root_domain"
  if [ ! -f "$ca_cert_path" ]; then
    # Self-sign the root key
    openssl req -x509 -new -nodes -key "$ca_key_path" -sha256 -days 30 -out "$ca_cert_path" -subj "$root_csr_subj"
  else
    echo "CA self-signature already exists"
  fi

  wellknown_path="$htdocs_path/.well-known"
  if [ ! -d "$wellknown_path" ]; then
    echo "Creating well-known path directory"
    mkdir "$wellknown_path"
  else
    echo "well-known path directory already exists"
  fi

  echo "Copying CA root cert to well known path"
  # Copy the local CA cert to the well known location
  cp "$ca_cert_path" "$wellknown_path/hackrva_ca.crt"
  # Generate a hosts file directing everything to localhost
  echo "Generating hosts file for local use"
  hosts=$(cat /etc/domains)
  for host in $hosts; do
    echo -e "127.0.0.1\t$host\t$host" >> "$wellknown_path/hosts"
  done
  # Provide a file for retrieving the hosts and the 
  echo "Creating index page for accessing hosts and cert at localhost/.well-known/index.html"
  cp "/etc/wellknown_index.html" "$wellknown_path/index.html"

  # Ensure the letsencrypt directory exists
  if [ ! -d "$le_dir" ]; then
    mkdir "$le_dir"
    # Mark us as using local certs
    echo "local" > "$le_dir/have_certs"
    # Mark us as needing local certs
    echo "local" > "$le_dir/need_certs"
  fi

  # Ensure the letsencrypt live directory exists
  if [ ! -d "$le_live_dir" ]; then
    mkdir "$le_live_dir"
  fi

  # Ensure the CSR directory exists
  csr_directory="$le_dir/csr"
  if [ ! -d "$csr_directory" ]; then
    mkdir "$csr_directory"
  fi

  for domain in $domains; do

    echo "Creating cert for $domain"
  
    cert_path="$le_dir/live/$domain/fullchain.pem"

    # Only make new snakeoil certs if there aren't existing ones 
    if [ ! -f "$cert_path" ]; then
    
      # Ensure the domain directory exists
      domain_path="$le_dir/live/$domain"
      if [ ! -d "$domain_path" ]; then
        mkdir "$domain_path"
      fi
      
      echo "Generating cert"
      
      # Generate the private key
      privkey_path="$domain_path/privkey.pem"
      if [ ! -d "$privkey_path" ]; then
        echo "Creating private key"
        openssl genpkey -out "$privkey_path" -algorithm rsa -pkeyopt rsa_keygen_bits:2048
      else
        echo "Found existing private key"
      fi
      
      echo "Creating CSR"
      
      # Create a CSR for the new key
      num=0
      csr_path="$csr_directory/${num}_csr.csr"
      while [ -f $csr_path ]; do
        num=$((num + 1))
        csr_path="$csr_directory/${num}_csr.csr"
      done
      
      csr_subj="/C=$country_code/ST=$state/L=$location/O=$organization/OU=$organization_unit/CN=$domain"
      openssl req -new -key "$privkey_path" -out "$csr_path" -subj "$csr_subj"

      echo "Signing key"
      # Sign the key
      cert_path="$domain_path/fullchain.pem"
      openssl x509 -req -days 30 -in "$csr_path" -CA "$ca_cert_path" -CAkey "$ca_key_path" -CAcreateserial -out "$cert_path"
      
    else
      echo "Certificate already exists"
    fi
  
  done

}

# Do these actions for the https domains listed in the file
generate_local_certs $(cat /etc/https_domains)

