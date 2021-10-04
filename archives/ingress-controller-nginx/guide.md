### Monitor ingress controller nginx
1. Step 01: config in values.yaml
```
controller:
  hostNetwork: true
  hostPort:
    enabled: true
  kind: DaemonSet

```

2. Step 02: create namespace ingress-nginx
```
sh install.sh 
```

### Ref
```console
- https://www.youtube.com/watch?v=UvwtALIb2U8&t=426s
- https://kubernetes.github.io/ingress-nginx/deploy/#using-helm
```
