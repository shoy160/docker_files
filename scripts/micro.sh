#!/bin/bash
#$1:name
if [ -n "$1" ];then
    name=$1    
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

slnname="Acb.MicroService.$name"

# echo $workdir
# echo $slnname
mkdir $slnname
cd $slnname

#创建解决方案
dotnet new sln -n $slnname

#创建项目
list="Contracts Business Tests Api"
for i in $list
do

case $i in
Tests)
    pname="Acb.$name.$i"    
    dotnet new mstest -n $pname

    dotnet sln add "$pname/$pname.csproj"
    ;;
Api)
    pname="Acb.MicroService.$name"    
    dotnet new webapi -n $pname

    dotnet sln add "$pname/$pname.csproj"
    ;;
*)
    pname="Acb.$name.$i"
    dotnet new classlib -n $pname

    dotnet sln add "$pname/$pname.csproj"
    ;;
esac
done

#引用
projBusiness="Acb.$name.Business/Acb.$name.Business.csproj"
projContracts="Acb.$name.Contracts/Acb.$name.Contracts.csproj"
projTests="Acb.$name.Tests/Acb.$name.Tests.csproj"
projMicroService="Acb.MicroService.$name/Acb.MicroService.$name.csproj"

#项目引用
dotnet add $projBusiness reference $projContracts
dotnet add $projTests reference $projContracts $projBusiness
dotnet add $projMicroService reference $projContracts $projBusiness

#包引用
dotnet add $projContracts package Acb.Core 
dotnet add $projBusiness package Acb.Core
dotnet add $projBusiness package Acb.Dapper
dotnet add $projBusiness package Acb.Dapper.MySql
dotnet add $projTests package Acb.Framework 
dotnet add $projTests package Acb.MicroService.Client
dotnet add $projMicroService package Acb.Framework
dotnet add $projMicroService package Acb.MicroService
