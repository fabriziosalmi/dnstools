#!/bin/bash

# Define the domain to check
domain="$1"

# Define the list of popular DNS providers
nameservers=(
    "8.8.8.8" # Google Public DNS
    "1.1.1.1" # Cloudflare DNS
    "208.67.222.222" # OpenDNS
    "9.9.9.9" # Quad9 DNS
    "64.6.64.6" # Verisign DNS
    "199.85.126.20" # Norton DNS
)

# Loop through the DNS providers and check the NS records for the domain
for ns in "${nameservers[@]}"; do
    echo "Checking NS records for $domain on $ns..."

    # Query the NS records for the domain using the current DNS provider
    result=$(dig +short @$ns NS $domain)

    # Check if the NS records were found
    if [[ -z $result ]]; then
        echo "NS records not found on $ns"
    else
        echo "NS records found on $ns:"
        echo "$result"
    fi
done
