#!/usr/bin/env bash

# add repo
# helm repo add stable https://charts.helm.sh/stable
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo update

# install chart
# kubectl create namespace nfs-server
kubectl config set-context --current --namespace kasten-io
helm install nfs stable/nfs-server-provisioner --namespace kasten-io -f values.yaml
