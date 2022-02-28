#!/bin/bash
if [[ -z "$1" ]]
then
  echo "Argument not present."
  echo "Usage $0 domain"

  exit 99
fi

mkdir $1
cd $1

echo "Creating KEY..."
openssl genrsa -des3 -out "$1".key 2048 && echo "... Done."

echo "Creating Root Certificate..."
openssl req -x509 -new -nodes -key "$1".key -sha256 -days 1825 -out "$1".pem && echo "... Done."

