#!/bin/bash
#$1:cmd
#$2:name
#$3:version
if [ -n "$1" ];then
    cmd=$1
else
    echo -e "push:打包项目,\ndel:删除包"
    read -t 30 -p "请输入部署命令:" rname
    if [ -n "$rname" ];then
        cmd=$rname
    fi
fi

if [ -z "$cmd" ];then
    echo -e "\033[31m 脚本异常：缺少部署命令 \033[0m"
    exit 1
fi

nuget_url="http://192.168.0.110:82"
nuget_key="ed97c8430153a668"

if [ -n "$2" ];then
    name=$2    
else
    read -t 30 -p "请输入项目名称:" rname
    if [ -n "$rname" ];then
        name=$rname        
    fi
fi
if [ ! -n "$name" ];then
    echo -e "\033[31m shell error:缺少项目名称 \033[0m"
    exit 1
fi

if [ -n "$3" ];then
    version=$3    
else
    read -t 30 -p "请输入项目版本:" rversion
    if [ -n "$rversion" ];then
        version=$rversion        
    fi
fi
if [ ! -n "$version" ];then
    echo -e "\033[31m shell error:缺少项目版本号 \033[0m"
    exit 1
fi

dir="Acb.MicroService.${name}"
name="Acb.${name}.Contracts"

push_pack(){
    echo "pack ${name} -v ${version}"
    dotnet build -c Release "${dir}/${name}/${name}.csproj"
    dotnet pack /property:PackageVersion=${version} -c Release "${dir}/${name}/${name}.csproj"
    echo " nuget push"
    dotnet nuget push ${dir}/${name}/bin/Release/${name}.${version}.nupkg -k ${nuget_key} -s ${nuget_url}
}

delete_pack(){
    echo "nuget delete"
    dotnet nuget delete ${name} ${version} -k ${nuget_key} -s ${nuget_url} --non-interactive
}

case $cmd in
push)
    push_pack
    ;;
del)
    delete_pack
    ;;
*)
    echo $cmd
    ;;
esac
