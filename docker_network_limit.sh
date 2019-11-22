#!/bin/bash
#filename:modify_docker_container_network_limit.sh
#author:Deng Lei
#email:dl528888@gmail.com
op=$1
container=$2
limit=$3  # Mbits/s
if [ -z $1 ] || [ -z $2 ]; then
    echo "Usage: operation container_name limit(default:5m)"
    echo "Example1: I want limit 5m in the container:test"
    echo "The command is: bash `basename $0` limit test 5"
    echo "Example2: I want delete network limit in the container:test"
    echo "The command is: bash `basename $0` ulimit test"
    exit 1
fi
if [ -z $3 ];then
    limit='5m'
fi
if [ `docker inspect --format "{{.State.Pid}}" $container &>>/dev/null && echo 0 || echo 1` -eq 1 ];then
echo "no this container:$container"
exit 1
fi
ovs_prefix='veth1pl'
container_id=`docker inspect --format "{{.State.Pid}}" $container`
device_name=`echo ${ovs_prefix}${container_id}`
if [ $op == 'limit' ];then
for v in $device_name; do
    ovs-vsctl set interface $v ingress_policing_rate=$((limit*1000))
    ovs-vsctl set interface $v ingress_policing_burst=$((limit*100))
    ovs-vsctl set port $v qos=@newqos -- --id=@newqos create qos type=linux-htb queues=0=@q0 other-config:max-rate=$((limit*1000000)) -- --id=@q0 create queue other-config:min-rate=$((limit*1000000)) other-config:max-rate=$((limit*1000000)) &>>/dev/null && echo 'modify success!' || echo 'modify fail!'
done
elif [ $op == 'ulimit' ];then
for v in $device_name; do
    ovs-vsctl set interface $v ingress_policing_rate=0
    ovs-vsctl set interface $v ingress_policing_burst=0
    ovs-vsctl clear Port $v qos &>>/dev/null && echo 'modify success!' || echo 'modify fail!'
done
fi