#!/bin/bash -ex
DAX_NAMESPACE=${DAX_NAMESPACE:-'dax-stable'}

# kubectl create -f dax-metaserv-datasets-volume.yaml
# kubectl create -f dax-metaserv-datasets-claim.yaml --namespace $DAX_NAMESPACE
kubectl create -f dax-metaserv-deployment.yaml --namespace $DAX_NAMESPACE
kubectl create -f dax-metaserv-service.yaml --namespace $DAX_NAMESPACE
kubectl create -f dax-metaserv-ingress.yaml --namespace $DAX_NAMESPACE
