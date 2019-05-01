#!/bin/bash -e
DAX_NAMESPACE=${DAX_NAMESPACE:-'dax-stable'}

kubectl create secret generic dax-metaserv-config --from-file=./webserv.ini \
--namespace $DAX_NAMESPACE
