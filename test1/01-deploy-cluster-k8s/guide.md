### Intro
- using minikube to create cluster k8s
```
minikube start --cpus 4 --memory 8192 --disk-size='40000mb'
```

### disable addons
```
minikube addons disable storage-provisioner
minikube addons disable default-storageclass

minikube addons disable volumesnapshots
minikube addons disable csi-hostpath-driver


```

### Result
```
$ minikube start
* minikube v1.23.0 on Microsoft Windows 10 Enterprise LTSC 2019 10.0.17763 Build 17763
* Using the virtualbox driver based on existing profile
* Starting control plane node minikube in cluster minikube
* Restarting existing virtualbox VM for "minikube" ...
* Preparing Kubernetes v1.22.1 on Docker 20.10.8 ...
  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
  - Using image k8s.gcr.io/sig-storage/snapshot-controller:v4.0.0
* Verifying Kubernetes components...
* Enabled addons: storage-provisioner, default-storageclass
* Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```
