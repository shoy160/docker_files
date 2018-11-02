#!/bin/bash
#$1 name
#$2 version
if [ -n "$1" ];then
    name=$1    
else
    read -t 30 -p "请输入应用名称:" name
    if [ -z "$name" ];then
        echo -e "\033[31m 脚本异常：缺少应用名称 \033[0m"
        exit 1      
    fi
fi

if [ -n "$2" ];then
    version=$2    
else
    read -t 30 -p "请输入镜像版本[latest]:" version
    if [ -z "$version" ];then
        version="latest"        
    fi
fi
echo "update image $name:$version"
# 更新image
kubectl set image deployments/$name $name=172.16.0.64:5000/web/$name:$version -n icb
# 查看更新状态
kubectl rollout status deployments/micro-market -n icb
