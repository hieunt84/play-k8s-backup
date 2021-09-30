#!/bin/sh

# install chart
kubectl create namespace mongodb
kubectl config set-context --current --namespace mongodb
kubectl apply -f ./deployment.yaml --namespace=mongodb
