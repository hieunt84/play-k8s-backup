#!/bin/sh

# uninstall chart
kubectl config set-context --current --namespace mysql
helm uninstall mysql --namespace=mysql
kubectl delete pvc data-mysql-0
kubectl delete ns mysql


