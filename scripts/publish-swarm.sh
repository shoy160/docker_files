#!/bin/bash
if [ -n "$1" ];then
    cmd=$1
else
    echo -e "create:创建服务,\nupdate:升级服务,\nremove|rm:删除服务,\nrmi:清空无效镜像"
    read -t 30 -p "请输入部署命令:" rname
    if [ -n "$rname" ];then
        cmd=$rname
    fi
fi

if [ -z "$cmd" ];then
    echo -e "\033[31m 脚本异常：缺少部署命令 \033[0m"
    exit 1
fi

registry="docker.local:5000/web"
#微服务列表
micro_list="micro-main micro-user micro-sword micro-story micro-market"
#网关列表
gateway_list="gateway-app gateway-management"

#创建微服务
create_micro(){
    local micro_name=$1
    local micro_version=$2
    local micro_mode=$3
    local micro_host=$4
    local micro_port=$5
    local micro_config=$6

    echo -e "\033[33m $micro_name => $micro_host:$micro_port -> $micro_mode \033[0m"

    docker service create --replicas 1 --name=$micro_name \
    -e ACB_MODE=$micro_mode -e MICRO_SERVICE_HOST=$micro_host -e MICRO_SERVICE_PORT=$micro_port \
    --mount type=bind,source=$micro_config,dst=/publish/appsettings.json \
    -p $micro_port:5000 $registry/$micro_name:$micro_version
}

#创建网关
create_gateway(){
    local gateway_name=$1
    local gateway_version=$2
    local gateway_mode=$3
    local gateway_port=$4
    local gateway_config=$5

    echo -e "\033[33m $gateway_name => *:$gateway_port -> $gateway_mode \033[0m"

    docker service create --replicas 1 --name=$gateway_name -e ACB_MODE=$gateway_mode \
    --mount type=bind,source=$gateway_config,dst=/publish/appsettings.json \
    -p $gateway_port:5000 $registry/$gateway_name:$gateway_version
}

#更新服务
update_service(){
    local service_name=$1
    local image_name=$2
    local image_version=$3

    docker service update --image=$registry/$image_name:$image_version $service_name
}

remove_services(){
    echo "**********删除容器**********************"
    docker service rm  $micro_list
    docker service rm  $gateway_list
}

#清空无效镜像
clean_images(){
    echo "**********清空无效镜像**********************"
    docker rmi $(docker images -q)
}

#创建服务入口
create_services(){
    #read -t 超时时间 -p 指定提示符
    read -p "请输入运行模式(Dev/Test/Ready/Prod):" mode

    if [ -z "$mode" ];then
        echo -e "\033[31m 脚本异常：缺少运行模式 \033[0m"
        exit 1
    fi

    if [ $mode != "Dev" -a $mode != "Test" -a $mode != "Ready" -a $mode != "Prod" ];then
        echo -e "\033[31m 脚本异常：运行模式只能为(Dev/Test/Ready/Prod)中的一种 \033[0m"
        exit 1
    fi

    read -t 30 -p "请输入镜像版本(3.0):" version
    if [ -z "$version" ];then
        version="3.0"
    fi

    read -t 30 -p "请输入host(10.10.10.5):" host
    if [ -z "$host" ];then
        host="10.10.10.5"
    fi

    read -t 30 -p "请输入配置文件地址(/var/www/v3/_config):" dir
    if [ -z "$dir" ];then
        dir="/var/www/v3/_config"
    fi

    if [ ! -d $dir ];then
        echo -e "\033[31m shell error:配置文件目录不存在 \033[0m"
        exit 1
    fi

    echo "**********Craete Services*********************"

    #微服务
    index=1

    for i in $micro_list
    do
        local port=`expr 6200 + $index`
        local name=$i

        create_micro $name $version $mode $host $port $dir/$name.json

        let index++
    done

    #接口
    index=1
    for i in $gateway_list
    do
        local port=`expr 6300 + $index`
        local name=$i
        create_gateway $name $version $mode $port $dir/$name.json

        let index++
    done
}

update_services(){
    echo "**********Update Service**********************"
    read -t 30 -p "请输入镜像版本(3.0):" version
    if [ -z "$version" ];then
        echo -e "\033[31m shell error:请输入镜像版本 \033[0m"
        exit 1
    fi
    for i in $micro_list
    do
        local name=$i
        echo -e "\033[33m update $name => $version \033[0m"
        update_service $name $name $version        
    done

    #接口
    for i in $gateway_list
    do
        local name=$i
        echo -e "\033[33m update $name => $version \033[0m"
        update_service $name $name $version
    done
}

case $cmd in
create)
    create_services
    ;;
update)
    update_services
    ;;
remove|rm)
    remove_services
    ;;
rmi)
    clean_images
    ;;
*)
    echo $cmd
    ;;
esac