#!/bin/bash
if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]] || [[ -z "$4" ]]
then
    echo "Argument not present."
    echo "Usage $0 Subdomain domain \"Name\" \"IP.Add.re.ss\""

    exit 99
fi
SUBDOMAIN="$1"
DOMAIN="$2"
NAME="$3"
IP="$4"

COUNTRY="ZA"
STATE="Gauteng"
CITY="Johannesburg"

SUBJ="/C=$COUNTRY/ST=$STATE/L=$CITY/O=$DOMAIN LAN/OU=$NAME/CN=$SUBDOMAIN.$DOMAIN"
echo "$SUBJ"

cd "$DOMAIN"

echo "Creating certificate for $SUBDOMAIN.$DOMAIN"

echo "................................................................................................"
echo "Creating certificate request"
openssl req -new -key $SUBDOMAIN.$DOMAIN.key -out $SUBDOMAIN.$DOMAIN.csr -subj "$SUBJ"

echo "authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $SUBDOMAIN.$DOMAIN
DNS.2 = $IP" >  $SUBDOMAIN.$DOMAIN.ext

echo "................................................................................................"
echo "Creating certificate..."
openssl x509 -req -in $SUBDOMAIN.$DOMAIN.csr -CA $DOMAIN.pem -CAkey $DOMAIN.key \
     -CAcreateserial -out $SUBDOMAIN.$DOMAIN.crt -days 397 -sha256 -extfile $SUBDOMAIN.$DOMAIN.ext

echo "................................................................................................"
echo "Done"
