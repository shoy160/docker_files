#!/bin/bash
if [ -n "$1" ];then
    cmd=$1
else
    echo -e "run:创建容器,\nupdate:升级镜像,\nrestart:重启容器,\nremove|rm:删除容器,\nrmi:清空无效镜像"
    read -t 30 -p "请输入部署命令:" rname
    if [ -n "$rname" ];then
        cmd=$rname
    fi
fi

if [ -z "$cmd" ];then
    echo -e "\033[31m shell error:缺少部署命令 \033[0m"
    exit 1
fi

runContainer(){
    read -t 30 -p "请输入部署的服务(type/micros/gateways/all):" type

    if [ -z "$type" ];then
        echo -e "\033[31m shell error:缺少部署的服务 \033[0m"
        exit 1
    fi

    read -t 30 -p "请输入运行模式(Dev/Test/Ready/Prod):" mode

    if [ -z "$mode" ];then
        echo -e "\033[31m shell error:缺少运行模式 \033[0m"
        exit 1
    fi

    if [ $mode != "Dev" -a $mode != "Test" -a $mode != "Ready" -a $mode != "Prod" ];then
        echo -e "\033[31m shell error:运行模式只能为(Dev/Test/Ready/Prod)中的一种 \033[0m"
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

    
    echo "**********创建容器**********************"

    registry="docker.local:5000/web"
    # dir="/var/www/v3"
    # host="10.10.10.5"
    #微服务
    case $type in
    micros|all)
        if [ $1 = true ];then
            removeContainer
        fi

        micros="main user sword story market"
        index=1

        for i in $micros
        do
            microPort=`expr 6200 + $index`

            echo "$i -> $host:$microPort"

            docker run --name=micro-$i --restart=always \
            --privileged=true -e ACB_MODE=$mode -e MICRO_SERVICE_HOST=$host -e MICRO_SERVICE_PORT=$microPort \
            -v $dir/micro-$i.json:/publish/appsettings.json \
            -p $microPort:5000 -d $registry/micro-$i:$version

            let index++
        done
        ;;
    gateways|all)
        #app 接口
        docker run --name=gateway-app --restart=always \
        --privileged=true -e ACB_MODE=$mode \
        -v $dir/gateway-app.json:/publish/appsettings.json \
        -p 6301:5000 -d $registry/gateway-app:$version

        echo "gateway-app -> $host:6301"

        #4s后台接口
        docker run --name=gateway-management --restart=always \
        --privileged=true -e ACB_MODE=$mode \
        -v $dir/gateway-management.json:/publish/appsettings.json \
        -p 6302:5000 -d $registry/gateway-management:$version

        echo "gateway-management -> $host:6302"
        ;;
    *)
        echo $type
        ;;
    esac
    # docker run --name=v3-transfer --restart=always --privileged=true -e ACB_MODE=$mode -v $dir/transfer:/publish -d docker.local:5000/transfer:3.0
}

restartContainer(){
    echo "**********重启容器**********************"
    case t in $1
    micros|all)
        docker restart micro-main micro-user micro-sword micro-story micro-market
        ;;
    gateways|all)
        docker restart gateway-app gateway-management
        ;;
    *)
        echo $1
        ;;
    esac
}

removeContainer(){
    echo "**********删除容器**********************"
    case t in $1
    micros|all)
        docker rm -f micro-main micro-user micro-sword micro-story micro-market
        ;;
    gateways|all)
        docker rm -f gateway-app gateway-management
        ;;
    *)
        echo $1
        ;;
    esac
}

cleanImages(){
    echo "**********清空无效镜像**********************"
    docker rmi $(docker images -q)
}

case $cmd in
run)
    runContainer
    ;;
restart)
    restartContainer all
    ;;
remove|rm)
    removeContainer all
    ;;
rmi)
    cleanImages
    ;;
update)
    runContainer true && cleanImages
    ;;
*)
    echo $cmd
    ;;
esac
