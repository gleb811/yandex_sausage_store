#!/bin/bash
#set -xe
#docker --context remote compose --env-file deploy.env up backend-green -d --pull "always" --force-recreate
#docker --context remote compose --env-file deploy.env up --scale backend-green=2 -d --no-recreate
#docker --context remote compose --env-file deploy.env up backend-blue -d --pull "always" --force-recreate
#docker --context remote compose --env-file deploy.env up --scale backend-green=2 backend-green -d --no-recreate
#docker --context remote compose --env-file deploy.env up --scale backend-blue=2 backend-blue -d --no-recreate
blue_status=`docker ps -qa --filter "name=sausage-store-backend-blue"`
blue_status=${#blue_status}
green_status=`docker ps -qa --filter "name=sausage-store-backend-green"`
green_status=${#green_status}
if [ $blue_status != 0 ]
then 
  if [ $green_status != 0 ]
  then
    docker rm -f $(docker ps -qa --filter "name=sausage-store-backend-green") || true
  fi
  docker --context remote compose --env-file deploy.env up backend-green -d --pull "always" --force-recreate 
  docker --context remote compose --env-file deploy.env up --scale backend-green=2 -d --no-recreate
# Wait for green become healthy
  docker rm -f $(docker ps -qa --filter "name=sausage-store-backend-blue") || true  
else
  docker --context remote compose --env-file deploy.env up backend-blue -d --pull "always" --force-recreate
  docker --context remote compose --env-file deploy.env up --scale backend-blue=2 backend-blue -d --no-recreate
  if [ $green_status != 0 ]
# Wait for blue become healthy
  then
    docker rm -f $(docker ps -qa --filter "name=sausage-store-backend-green") || true
  fi
fi