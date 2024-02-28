#!/usr/bin/bash
set -xe
sudo docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
sudo docker rm -f $(docker ps -qa --filter "name=sausage-store-backend") || true
