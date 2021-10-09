### Ref
```
https://minikube.sigs.k8s.io/docs/tutorials/volume_snapshots_and_csi/

https://community.veeam.com/blogs-and-podcasts-57/kubernetes-on-your-laptop-630

https://community.veeam.com/blogs-and-podcasts-57/kasten-on-your-minikube-707
```

### Intro
- using minikube to create cluster k8s

### Steps
1. Start your cluster
```
minikube start -p aged --kubernetes-version=v1.18.1 --cpus 4 --memory 8192 --disk-size='40000mb'
```

2. Enable addons
```
minikube -p aged addons enable volumesnapshots
minikube -p aged addons enable csi-hostpath-driver
```

3. Change default sc
```
kubectl patch storageclass csi-hostpath-sc -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

4. We will now delete the standard sc
```
minikube -p aged addons disable default-storageclass
or
kubectl delete sc standard
```

5. Check volume snapshot class
```
kubectl get volumesnapshotclasses
NAME                     DRIVER                DELETIONPOLICY   AGE
csi-hostpath-snapclass   hostpath.csi.k8s.io   Delete           10s

```

6. Prepare persistent volume
```
# example-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: csi-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: csi-hostpath-sc

```
7. Take a volume snapshot
```
# example-csi-snapshot.yaml
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshot
metadata:
  name: snapshot-demo
spec:
  volumeSnapshotClassName: csi-hostpath-snapclass
  source:
    persistentVolumeClaimName: csi-pvc

```

8. Restore from volume snapshot
```
# example-csi-restore.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: csi-pvc-restore
spec:
  storageClassName: csi-hostpath-sc
  dataSource:
    name: snapshot-demo
    kind: VolumeSnapshot
    apiGroup: snapshot.storage.k8s.io
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```


