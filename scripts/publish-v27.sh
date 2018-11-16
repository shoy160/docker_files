#!/bin/bash
if [ -n "$1" ];then
    cmd=$1
else
    echo -e "create:创建服务,\nupdate:升级服务,\nremove|rm:删除服务"
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
service_list="v27-user v27-payment v27-story v27-market"

#创建微服务
create_service(){
    local service_name=$1
    local service_version=$2
    local service_port=$3
    local service_config=$4

    echo -e "\033[33m $service_name => *:$service_port \033[0m"

    docker service create --replicas 1 --name=$service_name \
    --mount type=bind,source=$service_config,dst=/data/_config \
    -p $service_port:5000 $registry/$service_name:$service_version
}

create_services(){
    #read -t 超时时间 -p 指定提示符

    read -t 30 -p "请输入镜像版本(latest):" version
    if [ -z "$version" ];then
        version="latest"
    fi

    read -t 30 -p "请输入配置文件地址(/var/www/v27/_config):" dir
    if [ -z "$dir" ];then
        dir="/var/www/v27/_config"
    fi

    if [ ! -d $dir ];then
        echo -e "\033[31m shell error:配置文件目录不存在 \033[0m"
        exit 1
    fi

    echo "**********Craete Services*********************"

    #微服务
    index=1

    for i in $service_list
    do
        local port=`expr 6000 + $index`
        local name=$i

        create_service $name $version $port $dir

        let index++
    done
}

update_services(){
    echo "**********Update Service**********************"
    read -t 30 -p "请输入镜像版本(latest):" version
    if [ -z "$version" ];then
        version="latest"
    fi
    for i in $service_list
    do
        local name=$i
        echo -e "\033[33m update $name => $version \033[0m"
        docker service update --image=$registry/$name:$version $name
    done
}

remove_services(){
    echo "**********Delete Service**********************"
    docker service rm  $service_list
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
*)
    echo $cmd
    ;;
esac