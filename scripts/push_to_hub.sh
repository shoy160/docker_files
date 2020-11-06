#!/bin/bash
bizs="biz-auth biz-basic biz-life biz-marketing biz-medical biz-message biz-property iot-biz-communal iot-biz-vehicle iot-biz-security iot-biz-traffic iot-biz-linkage"
apis="api-basic api-life api-marketing api-medical api-property iot-api-communal iot-api-security iot-api-vehicle iot-api-traffic"
hub_local="docker.local"
hub_yz="hub.app-chengdu1.yunzhicloud.com"

push_image(){
    name=$1    
    local local_image="$hub_local/$name"
    local hub_image="$hub_yz/$name"
    echo -e "\033[35m push $local_image to $hub_image \033[0m"
    docker pull $local_image \
        && docker tag $local_image $hub_image \
        && docker push $hub_image \
        && docker rmi $local_image $hub_image
}

for biz in $bizs
do
    push_image "community/$biz"
done

for api in $apis
do
    push_image "community/$api"
done