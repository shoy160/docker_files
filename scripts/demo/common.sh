#!/bin/bash

for_demo() {
    local num=$1
    for (( i=0,sum=0;i<$num;i++ )); do        
        [ $[i%2] -eq 1 ] && let sum+=i
    done
    echo sum=$sum

    let sum=0
    for i in {1..100} ; do
        [ $[i%2] -eq 0 ] && let sum+=i
    done
    echo sum=$sum

    let sum=0
    for i in `seq 1 $num` ; do
        [ $[i%3] -eq 0 ] && let sum+=i
    done
    echo sum=$sum
}

while_demo() {
    local num=$1
    local i=0
    local sum=0
    while [ $i -le $num ] ; do
        if [ $[$i%2] -ne 0 ]; then
            let sum+=i            
        fi
        let i+=1
    done
    echo "sum is $sum"
}

while_file() {
    local path="$1"
    cat $path | while read line; do
        echo $line
    done
    # while read line; do
    #     echo $line
    # done < $path
}

until_demo() {
    #监控xiaoming用户，登录就杀死
    until pgrep -u shay &> /dev/null ;do
        sleep 0.5
    done
    pkill -9 -u shay
}

select_demo() {
    PS3="Please choose the menu:"
    select menu in m1 m2 m3 m4
    do
        case $REPLY in
            1|3)
                echo "menu 1 or 3"
                ;;
            2|4)
                echo "menu 2 or 4"
                ;;
            exit)
                break
                ;;
            *)
                echo "no menu $REPLY"
        esac
    done
}

gjxq() {
    red="\033[1;41m  \033[0m"
    yellow="\033[1;43m  \033[0m"

    for i in {1..8}; do
        if [ $[i%2] -eq 0 ]; then
            for i in {1..4}; do
                echo -e -n "$red$yellow";
            done            
        else
            for i in {1..4}; do
                echo -e -n "$yellow$red";
            done             
        fi
        echo
    done
}


# for_demo 100
# while_demo 100
# while_file "common.sh"
# select_demo
gjxq
