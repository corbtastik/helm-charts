#!/bin/bash
ORG='Todos Inc.'
TLDN='todos.io'
# Create root cert and private key to sign the certs for the todos services
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
  -subj "/O=${ORG}/CN=${TLDN}" \
  -keyout ${TLDN}.key \
  -out ${TLDN}.crt

# Create a cert and private key for todos-webui.todos.io
SDN='todos-webui'
openssl req -out ${SDN}.${TLDN}.csr \
  -newkey rsa:2048 -nodes -keyout ${SDN}.${TLDN}.key \
  -subj "/CN=${SDN}.${TLDN}/O=${ORG}"

openssl x509 -req -sha256 -days 365 \
  -CA ${TLDN}.crt \
  -CAkey ${TLDN}.key \
  -set_serial 0 -in ${SDN}.${TLDN}.csr \
  -out ${SDN}.${TLDN}.crt
