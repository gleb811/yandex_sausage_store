#!/usr/bin/bash
set -xe
sudo docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker network create -d bridge sausage_network || true
sudo docker rm -f $(docker ps -qa --filter "name=sausage-store-backend") || true
sudo docker compose --env-file deploy.env up backend -d --pull "always" --force-recreate
#sudo docker compose --env-file deploy.env up --scale backend=2 -d --no-recreate
sudo docker image prune -f