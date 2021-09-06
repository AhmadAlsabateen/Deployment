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


#Digest
ADMIN_SERVICE_DIGEST=`docker inspect --format='{{index .RepoDigests 0}}' $DOCKER_HUB_USERNAME/$ADMIN_SERVICE`
USER_SERVICE_DIGEST=`docker inspect --format='{{index .RepoDigests 0}}' $DOCKER_HUB_USERNAME/$USER_SERVICE`
LOGIN_SERVICE_DIGEST=`docker inspect --format='{{index .RepoDigests 0}}' $DOCKER_HUB_USERNAME/$LOGIN_SERVICE`
S3_SERVICE_DIGEST=`docker inspect --format='{{index .RepoDigests 0}}' $DOCKER_HUB_USERNAME/$S3_SERVICE`


#Fill Values
sed 's/{image-value}/$ADMIN_SERVICE_DIGEST/' admin-service-template.yaml > admin-service.yaml
sed 's/{image-value}/$USER_SERVICE_DIGEST/' user-service-template.yaml > user-service.yaml
sed 's/{image-value}/$S3_SERVICE_DIGEST/' s3-service-template.yaml > s3-service.yaml
sed 's/{image-value}/$LOGIN_SERVICE_DIGEST/' login-service-template.yaml > login-service.yaml


#Deploy
kubectl apply -f admin-service.yaml
kubectl apply -f user-service.yaml
kubectl apply -f login-service.yaml
kubectl apply -f s3-service.yaml

kubectl apply -f ingress.yaml

kubectl get deployments
kubectl get services







