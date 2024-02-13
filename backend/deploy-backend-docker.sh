#!/usr/bin/bash
set -xe
SPRING_CLOUD_VAULT_TOKEN=${SPRING_CLOUD_VAULT_TOKEN}
sudo docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f sausage-backend || true
sudo docker run -d --name sausage-backend  --pull always\
     --env SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME} \
     --env SPRING_CLOUD_VAULT_TOKEN=${SPRING_CLOUD_VAULT_TOKEN} \
     --env SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD} \
     --env SPRING_DATA_MONGODB_URI=${SPRING_DATA_MONGODB_URI} \
     --env SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL} \
     --network=sausage_network \
     "${CI_REGISTRY_IMAGE}"/sausage-backend
sudo docker image prune -f
echo ${SPRING_CLOUD_VAULT_TOKEN}
echo ${SPRING_DATASOURCE_PASSWORD}
echo ${VAULT_TOKEN}