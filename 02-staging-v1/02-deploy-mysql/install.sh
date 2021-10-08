#!/bin/sh

# add repo
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

# install chart
kubectl create namespace mysql
helm install mysql bitnami/mysql \
--namespace=mysql \
-f ./values-v1.yaml