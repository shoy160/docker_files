#!/bin/bash
projects="Acb.MicroService.Main Acb.MicroService.Market Acb.MicroService.Shield Acb.MicroService.Story Acb.MicroService.Sword Acb.MicroService.User Acb.Gateway.App Acb.Gateway.AppManagement Acb.Gateway.Dealer Acb.Gateway.Shield"
if [ -n "$1" ];then
    name=$1    
else
    read -t 30 -p "请输入项目名称:" rname
    if [ -n "$rname" ];then
        name=$rname        
    fi
fi

cd $name
# 切换分支
git checkout release
# 拉取分支
git pull -v --progress "origin"
# 合并分支
git merge --progress "origin" master
# 推送合并之后的分支
git push --progress "origin" release:release
# 切换回主分支
git checkout master