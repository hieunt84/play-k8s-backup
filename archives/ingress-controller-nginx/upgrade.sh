#!/bin/bash
# ref https://kubernetes.github.io/ingress-nginx/deploy/#using-helm

kubectl config set-context --current --namespace ingress-nginx
helm upgrade myingress ingress-nginx/ingress-nginx -n ingress-nginx \
-f ./values-v2.yaml
