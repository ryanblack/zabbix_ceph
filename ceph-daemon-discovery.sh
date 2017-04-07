#!/bin/bash
set -o nounset
set -o errexit

PATH=$PATH:/sbin:/usr/sbin:/bin:/usr/bin
export PATH

#GET OSD DAEMONS
DAEOSD=`ceph osd tree |grep osd.|awk '{print $3}'`
#GET MON DAEMONS
#DAEMON=`ceph -s |grep quorum| awk -F "quorum" '{print $2}'|cut -d' ' -f3|cut -d',' -f 1- --output-delimiter=$'\n'`
DAEMON=`ceph mon dump 2>/dev/null|grep mon|awk '{print $3}'`
#GET MDS DAEMONS
DAEMDS=`ceph fs dump 2>/dev/null|grep seq|awk '{print $4}'`

if [[ -n $DAEOSD ]]; then
    echo -e "{\n";
    echo -e "\t\"data\":[\n\n";
    first=1
    for DMN in $DAEOSD; do
        if [ $first == 0 ]; then
                echo -e "\t,\n"
        else
                first=0
        fi
        echo -e "\t{\n"
        echo -e "\t\t\"{#DMNOSD}\":\"$DMN\"\n"
        echo -e "\n\t}\n"
    done
    echo -e "\t,\n"
fi
if [[ -n $DAEMON ]]; then
    first=1
    for DMN in $DAEMON; do
        if [ $first == 0 ]; then
                echo -e "\t,\n"
        else
                first=0
        fi
        echo -e "\t{\n"
        echo -e "\t\t\"{#DMNMON}\":\"$DMN\"\n"
        echo -e "\n\t}\n"
    done
    echo -e "\t,\n"
fi
if [[ -n $DAEMDS ]]; then
     first=1
     for DMN in $DAEMDS; do
        if [ $first == 0 ]; then
                echo -e "\t,\n"
        else
                first=0
        fi
        echo -e "\t{\n"
        echo -e "\t\t\"{#DMNMDS}\":\"$DMN\"\n"
        echo -e "\n\t}\n"
    done
    echo -e "\n\t]\n"
    echo -e "}\n";
fi
exit 0
