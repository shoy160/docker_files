#!/bin/bash

echo "**********推送业务容器**********************"

version="3.0"
registry="docker.local:5000"
micros="main user sword story market"

echo "**********推送微服务容器**********************"
for i in $micros
do
    docker tag micro-$i:3.0 $registry/web/micro-$i:$version && docker push $registry/web/micro-$i:$version && docker rmi $registry/web/micro-$i:$version
done

echo "**********推送网关容器**********************"
gateways="app management"
for i in $gateways
do
    docker tag gateway-$i:3.0 $registry/web/gateway-$i:$version && docker push $registry/web/gateway-$i:$version && docker rmi $registry/web/gateway-$i:$version
done