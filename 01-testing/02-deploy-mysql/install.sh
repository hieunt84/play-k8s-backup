#!/bin/sh

# install chart
kubectl create namespace mysql
helm install mysql bitnami/mysql \
--namespace=mysql \
-f ./values-v1.yaml