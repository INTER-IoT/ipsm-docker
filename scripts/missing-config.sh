cat << EOF

ERROR: Apache Kafka SSL configuration missing!

 - clone the https://github.com/INTER-IoT/ipsm-ssl.git repository
 - read its "README.md"
 - generate the SSL configuration - results in "certs" subfolder being created
 - set the SSL_CONFIG variable in "config.env" pointing the cloned repository main folder
 - re-run the "configure.sh" script

EOF
