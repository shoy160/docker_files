#!/bin/bash
list="hainan_basic hainan_ecp hainan_elastic_job hainan_file hainan_gourmetHotel hainan_information hainan_iot hainan_mall hainan_monitor hainan_oa hainan_payment hainan_raydata hainan_screen hainan_search hainan_wifi"
for name in $list
do
  echo "dump db ${name}"
  docker run -i --rm -v /home/hainan-mysqlbak/hainan-data:/root/backup -e DB_MAX=31 -e DB_HOST=x.x.x.x -e DB_PORT=3306 -e DB_PWD=xxxx -e DB_NAME=$name shoy160/mysql-backup
done
