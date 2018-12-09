#!/bin/bash
echo "Creating named volumes..."
docker volume rm -f kafka-certs #> /dev/null 2>&1
docker volume rm -f kafka-data #> /dev/null 2>&1
docker volume rm -f kafka-scripts #> /dev/null 2>&1
docker volume rm -f ipsm-certs #> /dev/null 2>&1
docker volume rm -f ipsm-data #> /dev/null 2>&1
docker volume create kafka-certs
docker volume create kafka-data
docker volume create kafka-scripts
docker volume create ipsm-certs
docker volume create ipsm-data
echo "Populating volumes"
# cd ${SSL}/server
docker run -v kafka-certs:/data --name helper busybox true
docker cp ${SSL}/${SKS} helper:/data
docker cp ${SSL}/${STS} helper:/data
docker rm helper
# cd ../client
docker run -v ipsm-certs:/data --name helper busybox true
docker cp ${SSL}/${CKS} helper:/data
docker cp ${SSL}/${CTS} helper:/data
docker rm helper
cd ./kafka-scripts
docker run -v kafka-scripts:/data --name helper busybox true
docker cp . helper:/data
docker rm helper
cd ..
echo "Volumes ready to be used"

