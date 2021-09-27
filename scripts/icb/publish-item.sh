#!/bin/bash
#read -t 超时时间 -p 指定提示符
read -p "请输入服务名称:" name
if [ -z $name ];then
    echo -e "\033[31m 脚本异常：缺少服务名称 \033[0m"
    exit 1
fi

read -t 30 -p "请输入镜像版本(latest):" version
if [ -z "$version" ];then
    version="latest"
fi
registry="docker.local:5000/web"

local image=$registry/$name:$version

docker tag $name:3.0 $image && docker push $image && docker rmi $image

# 到线上服务器执行以下脚本更新
# docker service update --image=$image $name