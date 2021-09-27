#!/bin/bash
expired_day=-181
today=`date '+%Y-%m-%d %H:%M:%S'`
clean_day=`date -d "$expired_day day" +%Y-%m-%d`
echo -e "\e[36m现在是：$today, 清理${expired_day:1}天前的索引\e[0m"
es_index="*-$clean_day"
echo -e "\e[36m开始清理ES索引：$es_index\e[0m"
curl --user elastic:pwd -XDELETE http://192.168.6.2:9200/$es_index
echo -e "\n\e[32m索引清理完成\e[0m"
