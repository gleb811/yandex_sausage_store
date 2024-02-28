#!/usr/bin/bash
set -xe
sudo docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker rm -f $(docker ps -qa --filter "name=sausage-store-backend") || true
more deploy.env
sudo docker compose --env-file deploy.env up backend -d --pull "always" --force-recreate
sudo docker compose --env-file deploy.env up --scale backend=2 -d --no-recreate
sudo docker image prune -f