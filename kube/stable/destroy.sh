#!/bin/bash -x
DAX_NAMESPACE=${DAX_NAMESPACE:-'lsst-lsp-stable-dax'}

kubectl delete ingress dax-metaserv-ingress --namespace $DAX_NAMESPACE
kubectl delete service dax-metaserv-service --namespace $DAX_NAMESPACE
kubectl delete deployment dax-metaserv-deployment --namespace $DAX_NAMESPACE
# kubectl delete pvc dax-metaserv-datasets-claim --namespace $DAX_NAMESPACE
# kubectl delete pv dax-stable-metaserv-datasets-volume
