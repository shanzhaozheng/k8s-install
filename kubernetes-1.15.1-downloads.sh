#! bin/bash

docker pull mirrorgooglecontainers/kube-apiserver:v1.15.1
docker pull mirrorgooglecontainers/kube-controller-manager:v1.15.1
docker pull mirrorgooglecontainers/kube-scheduler:v1.15.1
docker pull mirrorgooglecontainers/kube-proxy:v1.15.1
docker pull mirrorgooglecontainers/pause:3.1 
docker pull mirrorgooglecontainers/etcd:3.3.10 
docker pull coredns/coredns:1.3.1
docker pull registry.cn-shenzhen.aliyuncs.com/cp_m/flannel:v0.10.0-amd64

docker tag mirrorgooglecontainers/kube-apiserver:v1.15.1 k8s.gcr.io/kube-apiserver:v1.15.1
docker tag mirrorgooglecontainers/kube-controller-manager:v1.15.1 k8s.gcr.io/kube-controller-manager:v1.15.1
docker tag mirrorgooglecontainers/kube-scheduler:v1.15.1 k8s.gcr.io/kube-scheduler:v1.15.1
docker tag mirrorgooglecontainers/kube-proxy:v1.15.1 k8s.gcr.io/kube-proxy:v1.15.1
docker tag mirrorgooglecontainers/pause:3.1 k8s.gcr.io/pause:3.1 
docker tag mirrorgooglecontainers/etcd:3.3.10 k8s.gcr.io/etcd:3.3.10 
docker tag coredns/coredns:1.3.1 k8s.gcr.io/coredns:1.3.1 
docker tag registry.cn-shenzhen.aliyuncs.com/cp_m/flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64

docker rmi mirrorgooglecontainers/kube-apiserver:v1.15.1 
docker rmi mirrorgooglecontainers/kube-controller-manager:v1.15.1 
docker rmi mirrorgooglecontainers/kube-scheduler:v1.15.1 
docker rmi mirrorgooglecontainers/kube-proxy:v1.15.1 
docker rmi mirrorgooglecontainers/pause:3.1 
docker rmi mirrorgooglecontainers/etcd:3.3.10 
docker rmi coredns/coredns:1.3.1 
docker rmi registry.cn-shenzhen.aliyuncs.com/cp_m/flannel:v0.10.0-amd64

