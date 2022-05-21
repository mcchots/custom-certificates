#! /bin/bash

if [[ -z "$1" ]]
then
    echo "Argument not present."
    echo "Usage $0 domain"

    exit 99
fi

for file in $(ls $1/*.crt)
do
    echo -n "$file: "; openssl x509 -enddate -noout -in $file;
 done

