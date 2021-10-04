#!/bin/sh

# uninstall chart
kubectl config set-context --current --namespace kasten-io
helm uninstall k10 --namespace=kasten-io
# kubectl delete pvc ...
kubectl delete ns kasten-io


