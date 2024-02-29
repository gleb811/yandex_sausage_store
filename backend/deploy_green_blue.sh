#!/bin/bash
set -xe
docker --context remote compose --env-file deploy.env up backend-green -d --pull "always" --force-recreate
#docker --context remote compose --env-file deploy.env up --scale backend-green=2 -d --no-recreate
#docker --context remote compose --env-file deploy.env up backend-blue -d --pull "always" --force-recreate
docker --context remote compose --env-file deploy.env up --scale backend-green=2 backend-green -d --no-recreate
#docker --context remote compose --env-file deploy.env up --scale backend-blue=2 backend-blue -d --no-recreate
echo 
if [ ${#$(docker ps -qa --filter "name=sausage-store-backend-blue")} != 0 ]
then 
  docker rm -f $(docker ps -qa --filter "name=sausage-store-backend-blue") || true
else
  docker --context remote compose --env-file deploy.env up backend-blue -d --pull "always" --force-recreate
  docker --context remote compose --env-file deploy.env up --scale backend-blue=2 backend-blue -d --no-recreate
fi