### Ref
```
https://github.com/rancher/local-path-provisioner
```

### Install
To install, execute:
```
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
```

Check pod
```
kubectl -n local-path-storage get pod
```

### Uninstall
- Before uninstallation, make sure the PVs created by the provisioner have already been deleted. Use kubectl get pv and make sure no PV with StorageClass local-path.

To uninstall, execute:
```
kubectl delete -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

```