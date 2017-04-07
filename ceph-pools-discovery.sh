#!/bin/bash

PATH=$PATH:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

#GET POOLS
POOLS=`ceph df|sed -n '6,$p'|awk '{print $1}'`

#echo -e ${POOLS}

if [[ -n ${POOLS} ]]; then
    echo -e "{\n";
    echo -e "\t\"data\":[\n\n";
    first=1
    for PL in ${POOLS}; do
        if [ $first == 0 ]; then
                echo -e "\t,\n"
        else
                first=0
        fi
        echo -e "\t{\n"
        echo -e "\t\t\"{#POOL}\":\"$PL\"\n"
        echo -e "\n\t}\n"
    done
    echo -e "\n\t]\n"    
    echo -e "}\n";
fi
exit 0
