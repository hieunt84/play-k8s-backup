### Intro
- using vagrant deploy cluster k8s version 1.18.1

### Steps
1. Start your cluster
```
vagrant up
```
2. Xóa taint trên node cho phép tạo Pod
```
kubectl taint node k8s-vm node-role.kubernetes.io/master-
```

3. Deploy csi-driver-host-path
```
ref:
https://github.com/kubernetes-csi/csi-driver-host-path

```

4. Check volume snapshot class
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


