#!/bin/sh

# upgrade
kubectl config set-context --current --namespace kasten-io
helm upgrade k10 kasten/k10 --namespace=kasten-io -f ./values-v1.yaml
