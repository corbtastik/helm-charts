#!/bin/bash
ORG=${ORG:-'Todos Inc.'}
DOMAIN=${DOMAIN:-'todos.io'}
SUB_DOMAIN=${SUB_DOMAIN:-'todos-webui'}
OUTPUT=${OUTPUT:-'.generated'}

# parse options
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done

# Create root cert and private key to sign the certs for the sub domain services
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
  -subj "/O=${ORG}/CN=${DOMAIN}" \
  -keyout ${OUTPUT}/${DOMAIN}.key \
  -out ${OUTPUT}/${DOMAIN}.crt

# Create a cert and private key for sub domain services
openssl req -out ${OUTPUT}/${SUB_DOMAIN}.${DOMAIN}.csr \
  -newkey rsa:2048 -nodes -keyout ${OUTPUT}/${SUB_DOMAIN}.${DOMAIN}.key \
  -subj "/CN=${SUB_DOMAIN}.${DOMAIN}/O=${ORG}"

openssl x509 -req -sha256 -days 365 \
  -CA ${OUTPUT}/${DOMAIN}.crt \
  -CAkey ${OUTPUT}/${DOMAIN}.key \
  -set_serial 0 -in ${OUTPUT}/${SUB_DOMAIN}.${DOMAIN}.csr \
  -out ${OUTPUT}/${SUB_DOMAIN}.${DOMAIN}.crt
