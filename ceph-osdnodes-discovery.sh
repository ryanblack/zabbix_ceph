#!/bin/bash

PATH=$PATH:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

#GET POOLS
NODES=`ceph osd tree|grep host|awk '{print $4}'`

if [[ -n ${NODES} ]]; then
    echo -e "{\n";
    echo -e "\t\"data\":[\n\n";
    first=1
    for ND in ${NODES}; do
        if [ $first == 0 ]; then
                echo -e "\t,\n"
        else
                first=0
        fi
        echo -e "\t{\n"
        echo -e "\t\t\"{#OSDNODE}\":\"$ND\"\n"
        echo -e "\n\t}\n"
    done
    echo -e "\n\t]\n"    
    echo -e "}\n";
fi
exit 0
