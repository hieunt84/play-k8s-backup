
```
kubectl create namespace mysql
helm install mysql bitnami/mysql --namespace=mysql
watch -n 2 "kubectl -n mysql get pods"
```