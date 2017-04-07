http://it.kuchuk.net/2017/04/zabbix-ceph.html

=============================================
Куда, что переместить и назначение каждого:

Расположение:
/etc/zabbix/scripts/
#  (на CephAdmin сервере) 

####Discovery Scprits####
#Обнаружение демонов mon, osd, mds
ceph-daemon-discovery.sh
#Обнаружение серверов на которых osd демоны
ceph-osdnodes-discovery.sh
#Обнаружение Pool-ов
ceph-pools-discovery.sh

####DataGet Scprits####
#Сбор основной массы данных (Статика)
ceph-status.sh
#Сбор данных в основном Discovery данных
ceph-data.sh

Расположение:
/etc/zabbix/zabbix_agentd.d/

####Template Keys#### 
#  (на CephAdmin сервере)
/etc/zabbix/zabbix_agentd.d/ceph.conf 

Расположение:
WebUI Zabbix

####Шаблон Ceph Cluster#### 
#Загрузить через WebUI Zabbix в Configuration > Templates : Import
zbx_export_template_ceph_cluster.xml


На CephAdmin сервере сгенерировать и передать ключи на все узлы кластера
[root@cephadmin ~]# ssh-keygen
[root@cephadmin ~]# ssh-copy-id -i ceph@server1.river.ru
[root@cephadmin ~]# ssh-copy-id -i ceph@server2.river.ru
[root@cephadmin ~]# ssh-copy-id -i ceph@server3.river.ru
 
Просмотреть свежие значения в LatestData можно через 5 минут. 
=============================================================