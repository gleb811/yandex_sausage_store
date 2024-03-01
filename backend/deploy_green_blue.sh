#!/bin/bash
#set -xe

#Define green/blue containers status
blue_status=`docker ps -qa --filter "name=sausage-store-backend-blue"`
blue_status=${#blue_status}
green_status=`docker ps -qa --filter "name=sausage-store-backend-green"`
green_status=${#green_status}
if [ $blue_status != 0 ] #if blue running
then 
  if [ $green_status != 0 ] #if green running
  then
    docker rm -f $(docker ps -qa --filter "name=sausage-store-backend-green") || true #remove green
  fi
  docker --context remote compose --env-file deploy.env up backend-green -d --pull "always" --force-recreate  #Start fresh green version
#Define green health status
  green_health_status=`docker ps -qa --filter "name=sausage-store-backend-green" --filter "health=healthy"`
  green_health_status=${#green_health_status}
    while [ $green_health_status = 0 ] #Wait for green becom healty
    do
    green_health_status=`docker ps -qa --filter "name=sausage-store-backend-green" --filter "health=healthy"`
    green_health_status=${#green_health_status}
    echo 'Waiting for green become healthy' 
    sleep 20s
    done
  docker rm -f $(docker ps -qa --filter "name=sausage-store-backend-blue") || true  #Remove blue
#  docker --context remote compose --env-file deploy.env up --scale backend-green=2 backend-green -d --no-recreate
else
  docker --context remote compose --env-file deploy.env up backend-blue -d --pull "always" --force-recreate
  if [ $green_status != 0 ]
# Wait for blue become healthy
  then
    blue_health_status=`docker ps -qa --filter "name=sausage-store-backend-blue" --filter "health=healthy"`
    blue_health_status=${#blue_health_status}
    while [ $blue_health_status = 0 ]
    do
      blue_health_status=`docker ps -qa --filter "name=sausage-store-backend-blue" --filter "health=healthy"`
      blue_health_status=${#blue_health_status}
      echo 'Waiting for blue become healthy' 
      sleep 20s
    done
    docker rm -f $(docker ps -qa --filter "name=sausage-store-backend-green") || true
  fi
#  docker --context remote compose --env-file deploy.env up --scale backend-blue=2 backend-blue -d --no-recreate
  
fi
