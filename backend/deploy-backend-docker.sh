#!/usr/bin/bash
set -xe
export SPRING_CLOUD_VAULT_TOKEN=${SPRING_CLOUD_VAULT_TOKEN}
sudo docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f sausage-backend || true
sudo docker run --rm -d --name sausage-backend  --pull always\
     --env-file .env \
     --network=sausage_network \
     "${CI_REGISTRY_IMAGE}"/sausage-backend:latest
sudo docker image prune -f