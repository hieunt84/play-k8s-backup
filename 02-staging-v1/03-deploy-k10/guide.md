## Guide install k10

### add repo
```
helm repo add kasten https://charts.kasten.io/
helm repo update
```

### install chart
```
kubectl create namespace kasten-io
helm install k10 kasten/k10 --namespace=kasten-io
```

### Config annotate
- after k10 running
```
kubectl annotate volumesnapshotclass csi-hostpath-snapclass k10.kasten.io/is-snapshot-class=true
```

### result
volumesnapshotclass.snapshot.storage.k8s.io/csi-hostpath-snapclass annotated

### Ref
```
https://www.youtube.com/watch?v=01qcYSck1c4&t=461s
```