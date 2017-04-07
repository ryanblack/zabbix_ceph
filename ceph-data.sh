#!/bin/bash

ceph_bin="/usr/bin/ceph"

# Return the value
case $1 in
  daemon_osd_status)
    status=$($ceph_bin osd dump | grep $2 | awk '{print $2}')
    case $status in
      up)
        echo 1
      ;;
      down)
        echo 0
      ;;
      *)
        echo 2
      ;;
    esac
  ;;
  daemon_mon_status)
    status=$(ssh root@$(echo $2 | cut -d'.' -f2) "sudo systemctl status ceph-osd@*" |grep Active:|awk '{print $2}')
    case $status in
      active)
        echo 1
      ;;
      inactive)
        echo 0
      ;;
      *)
        echo 2
      ;;
    esac
  ;;
  daemon_mds_status)
    status=$($ceph_bin fs dump 2>/dev/null|grep $2|cut -d':' -f3|awk '{print $4}')
    case $status in
      up)
        echo 1
      ;;
      down)
        echo 0
      ;;
      *)
        echo 2
      ;;
    esac
  ;;
  spacetotal)
    echo $($ceph_bin df |awk '{print $1}'|grep G|sed '1d'|cut -d"G" -f1|bc)
  ;;
  spaceavail)
    echo $($ceph_bin df |awk '{print $2}'|grep G|cut -d"G" -f1)
  ;;
  poolspaceavail)
    poolspaceavail=$($ceph_bin df|grep $2 |awk '{print $5}'|cut -d"M" -f1)
    #poolspaceavail=$(echo "scale=2; $poolspaceavail/1000"|bc)
    echo $(echo "scale=2; $poolspaceavail/1000"|bc)
  ;;
  osdspaceavail)
    echo $(ssh root@$2 "sudo df -h" |grep ceph|awk '{print $4}'|cut -d'G' -f1)
  ;;
  osdcount)
    echo $($ceph_bin osd dump |grep max_osd|awk '{print $2}')
esac
  
