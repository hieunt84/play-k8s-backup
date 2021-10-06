### Ref
```
https://minikube.sigs.k8s.io/docs/tutorials/volume_snapshots_and_csi/
```

### Intro
- using minikube to create cluster k8s

### Steps
1. Start your cluster
```
minikube start --cpus 4 --memory 8192 --disk-size='40000mb'
```

2. Enable addons
```
minikube addons enable volumesnapshots
minikube addons enable csi-hostpath-driver
```

3. Check volume snapshot class
```
kubectl get volumesnapshotclasses
NAME                     DRIVER                DELETIONPOLICY   AGE
csi-hostpath-snapclass   hostpath.csi.k8s.io   Delete           10s

```

4. Prepare persistent volume
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
5. Take a volume snapshot
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

6. Restore from volume snapshot
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


