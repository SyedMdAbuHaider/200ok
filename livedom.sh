#!/bin/bash

# Output file to store live domains
output_file="live_domains.txt"

# Function to check if a domain is live
check_domain() {
    domain="$1"
    if ping -c 1 "$domain" >/dev/null 2>&1; then
        echo "$domain" >> "$output_file"
    fi
}

# Check if domain list file is provided as argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain_list_file>"
    exit 1
fi

domain_list_file="$1"

# Check if domain list file exists
if [ ! -f "$domain_list_file" ]; then
    echo "Domain list file not found: $domain_list_file"
    exit 1
fi

# Remove output file if it already exists
if [ -f "$output_file" ]; then
    rm "$output_file"
fi

# Read each domain from the input file and check its live status
while IFS= read -r domain; do
    check_domain "$domain"
done < "$domain_list_file"

echo "Live domains saved to $output_file"
