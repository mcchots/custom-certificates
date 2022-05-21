#!/bin/bash
if [[ -z "$1" ]] || [[ -z "$2" ]] #|| [[ -z "$3" ]] || [[ -z "$4" ]]
then
    echo "Argument not present."
#    echo "Usage $0 Subdomain domain \"Name\" \"IP.Add.re.ss\""
    echo "Usage $0 Subdomain domain"

    exit 99
fi
SUBDOMAIN="$1"
DOMAIN="$2"
#NAME="$3"
#IP="$4"

cd $DOMAIN

echo "Creating certificate..."
openssl x509 -req -in $SUBDOMAIN.$DOMAIN.csr -CA $DOMAIN.pem -CAkey $DOMAIN.key \
     -CAcreateserial -out $SUBDOMAIN.$DOMAIN.crt -days 397 -sha256 -extfile $SUBDOMAIN.$DOMAIN.ext

echo "................................................................................................"
echo "Done"
