#!/bin/bash

# add repo
helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
helm repo update

# install
helm install csi-driver-nfs csi-driver-nfs/csi-driver-nfs --namespace kube-system \
--set controller.runOnMaster=true \
--set controller.replicas=1 \
--set feature.enableFSGroupPolicy=true

