### Intro
- using vagrant deploy cluster k8s version 1.18.1
- using csi-driver-host-path
- ref : https://github.com/kubernetes-csi/csi-driver-host-path/blob/master/docs/deploy-1.17-and-later.md

### Steps
1. Start your cluster
```
vagrant up
```

2. Init
```
sh 010.init.sh
```

3. Install volume snapshot
```
sh 011.setup-volume-snapshot.sh
```

4. Deploy csi-driver-host-path

```
git clone https://github.com/kubernetes-csi/csi-driver-host-path.git

deploy/kubernetes-1.19/deploy.sh

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


