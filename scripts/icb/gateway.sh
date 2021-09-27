#!/bin/bash
#$1:name
prefix="Acb"
has_busi=false
sql_name="MySql"
proj_name=""
while getopts ":n:b:d:p" opt
do
    case $opt in
        n)
            echo "参数n的值$OPTARG"
            name=$OPTARG
            ;;
        b)
            echo "参数b的值$OPTARG"
            has_busi=true
            ;;
        d)
            echo "参数d的值$OPTARG"
            sql_name=$OPTARG
            ;;
        p)
            echo "参数p的值$OPTARG"
            prefix=$OPTARG
            ;;
        ?)
            ;;
    esac
done
if [ ! -n "$name" ];then
    read -t 30 -p "请输入项目名称:" rname
    if [ -n "$rname" ];then
        name=$rname        
    fi
fi

if [ ! -n "$name" ];then
    echo -e "\033[31m shell error:缺少项目名称 \033[0m"
    exit 1
fi

get_proj_name(){
    proj_name="$1/$1.csproj"
}

if [ hasBusi ];then
    contract_name="$prefix.$name.Contracts"  
    busi_name="$prefix.$name.Business"
fi
test_name="$prefix.$name.Tests"
api_name="$prefix.Gateway.$name"

echo $contract_name,$busi_name,$test_name,$api_name,$sql_name
get_proj_name $contract_name
echo $proj_name

new_sln(){
    sln_name="$prefix.Gateway.$name"    
    mkdir $sln_name
    cd $sln_name
    #创建解决方案
    dotnet new sln -n $sln_name
}

new_contract(){
    if [ ! -n $contract_name ];then
        return 0;
    fi
    dotnet new classlib -n $contract_name
    get_proj_name $contract_name
    dotnet sln add $proj_name
    dotnet add $proj_name package Acb.Core    
}

new_busi(){
    if [ ! -n $busi_name ];then
        return 0;
    fi    
    dotnet new classlib -n $busi_name
    get_proj_name $busi_name
    dotnet sln add $proj_name
    dotnet add $proj_name package Acb.Core
    dotnet add $proj_name package Acb.Dapper
    dotnet add $proj_name package "Acb.Dapper.$sql_name"
}

new_test(){
    dotnet new mstest -n $test_name
    get_proj_name $test_name
    dotnet sln add $proj_name
    dotnet add $proj_name package Acb.Core
    dotnet add $proj_name package Acb.Framework
    dotnet add $proj_name package Acb.MicroService.Client
    if [ hasBusi ];then
        t_proj_name=$proj_name
        get_proj_name $contract_name
        dotnet add $t_proj_name reference $proj_name
        get_proj_name $busi_name
        dotnet add $t_proj_name reference $proj_name
    fi    
}

new_api(){
    dotnet new webapi -n $api_name
    get_proj_name $api_name
    dotnet sln add $proj_name
    dotnet add $proj_name package Acb.Core
    dotnet add $proj_name package Acb.Framework
    dotnet add $proj_name package Acb.WebApi
    dotnet add $proj_name package Acb.MicroService.Client
    if [ hasBusi ];then
        t_proj_name=$proj_name
        get_proj_name $contract_name
        dotnet add $t_proj_name reference $proj_name
        get_proj_name $busi_name
        dotnet add $t_proj_name reference $proj_name
    fi    
}

new_sln
new_contract
new_busi
new_test
new_api
