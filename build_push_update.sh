#!/bin/bash

####################默认参数####################
#仓库目录
kHarbor=192.168.2.234:5000/cmcdcp/
#镜像名称
kImages=sftp
#镜像版本
kTag=8.8p1
#部署的服务名称
kName=sftp
#部署的命名空间
kNamespace=cmcdcp
#部署的资源类型
#pod (po)、replicationcontroller (rc)、deployment (deploy)、daemonset (ds)、job、replicaset (rs)
kKind=deployments
################################################

#参数模式
if  [ -n "$1" ] ;then
echo "使用快速参数构建模式"
echo "已检测到参数kTag"
kTag=$1
echo "$kTag"
sleep 2
fi

#打包
sudo docker build -t $kHarbor$kImages:$kTag .

sleep 2
echo

#推送仓库
sudo docker push $kHarbor$kImages:$kTag

#升级版本
#kubectl set image deployments,rc nginx=nginx:1.9.1 --all
kubectl set image $kKind $kName *=$kHarbor$kImages:$kTag --namespace=$kNamespace

sleep 2

podName=`kubectl get pod --namespace=$kNamespace | grep $kName |awk '{print $1}'`
kubectl delete pod $podName --namespace=$kNamespace --grace-period=0 --force
