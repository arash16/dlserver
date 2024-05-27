#!/bin/sh -e
set -xe

docker build -t arash16/dlserver .
docker push arash16/dlserver
kubectl apply -f k8s.yaml
