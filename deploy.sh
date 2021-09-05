#!/bin/bash

DOCKER_HUB_USERNAME=ahmad2sabateen


# Services 
ADMIN_SERVICE=admin-service
USER_SERVICE=user-service
LOGIN_SERVICE=login-service
S3_SERVICE=s3-service

docker tag $ADMIN_SERVICE $DOCKER_HUB_USERNAME/$ADMIN_SERVICE
docker tag $USER_SERVICE $DOCKER_HUB_USERNAME/$USER_SERVICE
docker tag $LOGIN_SERVICE $DOCKER_HUB_USERNAME/$LOGIN_SERVICE
docker tag $S3_SERVICE $DOCKER_HUB_USERNAME/$S3_SERVICE


docker push $DOCKER_HUB_USERNAME/$ADMIN_SERVICE
docker push $DOCKER_HUB_USERNAME/$USER_SERVICE
docker push $DOCKER_HUB_USERNAME/$LOGIN_SERVICE
docker push $DOCKER_HUB_USERNAME/$S3_SERVICE


kubectl apply -f tomcat-test.yaml
kubectl get deployments
kubectl get services







