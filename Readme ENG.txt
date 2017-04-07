http://it.kuchuk.net/2017/04/zabbix-ceph.html

=============================================
Where to copy each script and their purposes:

Location:
/etc/zabbix/scripts/
#  (on CephAdmin server) 

####Discovery Scprits####

#Discover daemons mon, osd, mds
ceph-daemon-discovery.sh
#Discover servers with osd daemons
ceph-osdnodes-discovery.sh
#Discover Pools
ceph-pools-discovery.sh

####DataGet Scprits####
#Get the mainpart of data (static)
ceph-status.sh
#Get Discovery data
ceph-data.sh

Location:
/etc/zabbix/zabbix_agentd.d/
#  (на CephAdmin сервере)

####Template Keys#### 
/etc/zabbix/zabbix_agentd.d/ceph.conf 

Location:
WebUI Zabbix

####Template Ceph Cluster#### 
#Import it in WebUI Zabbix в Configuration > Templates : Import
zbx_export_template_ceph_cluster.xml

On CephAdmin server generate and copy keys on all cluster nodes
[root@cephadmin ~]# ssh-keygen
[root@cephadmin ~]# ssh-copy-id -i ceph@server1.river.ru
[root@cephadmin ~]# ssh-copy-id -i ceph@server2.river.ru
[root@cephadmin ~]# ssh-copy-id -i ceph@server3.river.ru
 
Watch new data you may in LatestData in 5 minuts
=============================================================