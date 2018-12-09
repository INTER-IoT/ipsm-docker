#!/bin/bash
KAFKA_HOST=${IPSM_HOST}
KAFKA_PORT=9092
ZOOKEEPER_PORT=2181
cat <<EOF >environment/ipsm.env
#---------------------------------------------------------------------
# IPSM configuration – should not require any changes
#---------------------------------------------------------------------
IPSM_KAFKA_HOST=kafka

#---------------------------------------------------------------------
# SSL configuration variables - should work as is
#---------------------------------------------------------------------
IPSM_KAFKA_CLIENT_KEYSTORE_LOCATION=/certs/default-kafka-client.keystore.jks
IPSM_KAFKA_CLIENT_KEYSTORE_PASSWORD=${CLIENT_PASS}
IPSM_KAFKA_CLIENT_TRUSTSTORE_LOCATION=/certs/default-kafka-client.truststore.jks
IPSM_KAFKA_CLIENT_TRUSTSTORE_PASSWORD=${CLIENT_PASS}
IPSM_KAFKA_CLIENT_KEY_PASSWORD=${CLIENT_PASS}
EOF

cat <<EOF >environment/kafka.env
#---------------------------------------------------------------------
# Kafka configuration - normally, should not require any changes
#---------------------------------------------------------------------
KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
KAFKA_BROKER_ID=0
KAFKA_DELETE_TOPIC_ENABLE=true
KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS=0
KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=SSL:SSL
KAFKA_LISTENERS=SSL://:${KAFKA_PORT}
KAFKA_NUM_PARTITIONS=1
KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1
KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
KAFKA_ZOOKEEPER_CONNECT=zookeeper:${ZOOKEEPER_PORT}

#---------------------------------------------------------------------
# Custom initialization script - should work as is
#---------------------------------------------------------------------
CUSTOM_INIT_SCRIPT=/scripts/kafka-custom.sh

#---------------------------------------------------------------------
# General Kafka options - YOU HAVE TO use the deployment machine's IP here!
#---------------------------------------------------------------------
KAFKA_ADVERTISED_HOSTNAME=${KAFKA_HOST}
KAFKA_ADVERTISED_LISTENERS=SSL://${KAFKA_HOST}:${KAFKA_PORT}

#---------------------------------------------------------------------
# SSL configuration variables
#---------------------------------------------------------------------
KAFKA_SSL_KEYSTORE_LOCATION=/certs/kafka-server.keystore.jks
KAFKA_SSL_KEYSTORE_PASSWORD=${PASS}
KAFKA_SSL_KEY_PASSWORD=${PASS}
KAFKA_SSL_TRUSTSTORE_LOCATION=/certs/kafka-server.truststore.jks
KAFKA_SSL_TRUSTSTORE_PASSWORD=${PASS}
KAFKA_SSL_CLIENT_AUTH=required
EOF
