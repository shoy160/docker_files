#!/bin/bash
# 保存备份个数，备份31天数据
max_number=31
# 备份保存路径
backup_dir=/root/backup
# 主机
host=localhost

port=3306
# 用户名
user=root
# 密码
password=

#将要备份的数据库
db_name=

# 日期
dd=`date +%Y%m%d%H%M%S`

show_usage="arg: [-m,-d,-h,-P,-u,-p,-n] \
[--max-number=,--backup-dir=,--host=,--port=,--user=,--password=,--db-name=]"
GETOPT_ARGS=`getopt -o m:d:h:P:u:p:n: -al max-number:,backup-dir:,host:,port:,user:,password:,db-name: -- "$@"`
eval set -- "$GETOPT_ARGS"
#获取参数
while [ -n "$1" ]
do
    case "$1" in
            -m|--max-number) max_number=$2; shift 2;;
            -d|--backup-dir) backip_dir=$2; shift 2;;
            -h|--host) host=$2; shift 2;;
            -P|--port) port=$2; shift 2;;
            -u|--user) user=$2; shift 2;;
            -p|--password) password=$2; shift 2;;
            -n|--db-name) db_name=$2; shift 2;;
            --) break ;;
            *) echo $1,$2,$show_usage; break ;;
    esac
done

#echo "host=$host,port=$port,max_number=$max_number,dir=$backup_dir,user=$user,password=$password,db=$db_name"

#如果文件夹不存在则创建
if [ ! -d $backup_dir ]; 
then     
  mkdir -p $backup_dir; 
fi
# client.cnf
cat << EOF > client.cnf
[client]
host = "${host}"
port = "${port}"
user = "${user}"
password = "${password}"
EOF

if [ "$db_name" = "__all__" ];then
  db_name=
fi

filename=${host}_${db_name}

if [ -n "$db_name" ];then
  # 备份单个数据库
  mysqldump --defaults-extra-file=client.cnf -B -F -R --master-data=2  $db_name | gzip > $backup_dir/${filename}-${dd}.sql.gz
else
  # 备份所有数据库
  filename=${host}_all
  mysqldump --defaults-extra-file=client.cnf -F -R --master-data=2  --all-databases | gzip > $backup_dir/${filename}-${dd}.sql.gz
fi

# 参数说明：
# -B：指定数据库
# -F：刷新日志
# -R：备份存储过程等
# -x：锁表 
# --master-data：在备份语句里添加CHANGE MASTER语句以及binlog文件及位置点信息

#写创建备份日志
echo "create $backup_dir/${filename}-${dd}.sql.gz" >> $backup_dir/backup.log

#找出需要删除的备份
delfile=`ls -l -crt $backup_dir | grep ${filename}- | awk '{print $9}' | head -1`

#判断现在的备份数量是否大于$number
count=`ls -l -crt $backup_dir | grep ${filename}- | awk '{print $9}' | wc -l`

if [ $count -gt $max_number ];then
  #删除最早生成的备份，只保留number数量的备份
  rm ${backup_dir}/$delfile
  #写删除文件日志
  echo "delete $delfile" >> $backup_dir/backup.log
fi

# 转unix
# sed -i "s/\r//" mysql_backup.sh && vim mysql_backup.sh # :set ff=unix

