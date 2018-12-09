#!/bin/bash
rm -rf environment
mkdir -p environment

. config.env

SSL=${SSL_CONFIG}/certs
ICFG=environment/ipsm.env
KCFG=environment/kafka.env

CKS=client/default-kafka-client.keystore.jks
CTS=client/default-kafka-client.truststore.jks
SKS=server/kafka-server.keystore.jks
STS=server/kafka-server.truststore.jks

if ([ -e ${SSL}/${CKS} ] && [ -e ${SSL}/${CTS} ] && [ -e ${SSL}/${SKS} ] && [ -e ${SSL}/${STS} ])
then
    if [ -e ${ICFG} ]
    then
        rm ${ICFG}
    fi
    if [ -e ${KCFG} ]
    then
        rm ${KCFG}
    fi
    . ${SSL_CONFIG}/config.env
    . scripts/environment.sh
    . scripts/initialize-volumes.sh
cat << EOF

IPSM docker compose configuration created successfully.

    Usage: docker-compose up  -d

EOF

else
    . scripts/missing-config.sh
fi
