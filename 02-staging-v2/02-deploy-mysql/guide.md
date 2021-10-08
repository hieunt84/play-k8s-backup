### Install
```
sh install.sh
```

### Verify
```
kubectl -n mysql get pods -w
```

### Create DB
```
MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace mysql mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo)

kubectl exec -it --namespace=mysql $(kubectl --namespace=mysql get pods -o jsonpath='{.items[0].metadata.name}') \
  -- mysql -u root --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE k10demo"
```