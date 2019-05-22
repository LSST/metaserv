#!/bin/bash -ex
DAX_NAMESPACE=${DAX_NAMESPACE:-'lsst-lsp-int-dax'}

kubectl create -f dax-metaserv-deployment.yaml --namespace $DAX_NAMESPACE
kubectl create -f dax-metaserv-service.yaml --namespace $DAX_NAMESPACE
kubectl create -f dax-metaserv-ingress.yaml --namespace $DAX_NAMESPACE
