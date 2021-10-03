### Intro
- using minikube to create cluster k8s
```
minikube start --cpus 4 --memory 8192 --vm-driver virtualbox
minikube addons enable volumesnapshots
minikube addons enable csi-hostpath-driver

```
```
kubectl annotate volumesnapshotclass csi-hostpath-snapclass k10.kasten.io/is-snapshot-class=true
```
### result
volumesnapshotclass.snapshot.storage.k8s.io/csi-hostpath-snapclass annotated
