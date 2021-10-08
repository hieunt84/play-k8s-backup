### Intro
- using vagrant deploy cluster k8s version 1.18.1
- using vagrant deploy cluster k8s version 1.20.11

### Steps
1. Start your cluster
```
vagrant up
```

2. Init
```
init.sh
```

3. Install volume snapshot
```
shsetup-volume-snapshot.sh
```

4. Deploy nfs-server
```
sh 012.setup-nfs-server.sh
```

5. Deploy nfs-provisioner
```
sh 013.sh
```

6. Deploy csi-driver-nfs

```

```

7. Check volume snapshot class
```
kubectl get volumesnapshotclasses
NAME                     DRIVER                DELETIONPOLICY   AGE
csi-hostpath-snapclass   hostpath.csi.k8s.io   Delete           10s

```

8. Prepare persistent volume
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

9. Take a volume snapshot
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

10. Restore from volume snapshot
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


