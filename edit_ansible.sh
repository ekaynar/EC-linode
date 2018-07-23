#!/bin/bash

rm /etc/ansible/hosts
rm pbench-agent-list

clients=`cat ~/ceph-linode/ansible_inventory | grep client | awk {'print $2'} | sed 's/.*=//'`

echo "[cosbench-driver]" >> /etc/ansible/hosts
for item in ${clients}
do
	echo $item >> /etc/ansible/hosts
done

echo "" >> /etc/ansible/hosts
echo "[cosbench-controller]" >> /etc/ansible/hosts
for item in ${clients}
do
	echo $item >> /etc/ansible/hosts
	break
done
echo "" >> /etc/ansible/hosts


pbench_agent=`cat ~/ceph-linode/ansible_inventory | grep ansible |awk {'print $2'} | sed 's/.*=//'`

rm -rf pbench-agent-list

echo "[pbench-agent]" >> /etc/ansible/hosts
for item in ${pbench_agent}
do
        echo $item >> /etc/ansible/hosts
done


pbench_agent=`cat ~/ceph-linode/ansible_inventory | grep osd |awk {'print $2'} | sed 's/.*=//'`

rm -rf pbench-agent-list

echo "[pbench-agent]" >> /etc/ansible/hosts
for item in ${pbench_agent}
do
        echo $item >> pbench-agent-list
done
pbench_webserver=`cat ~/ceph-linode/ansible_inventory |grep client | awk {'print $2'} | sed 's/.*=//'`
echo "[pbench-webserver]" >> /etc/ansible/hosts
for item in ${pbench_webserver}
do
        echo $item >> /etc/ansible/hosts
        break
done
echo "" >> /etc/ansible/hosts


rgws=`cat ~/ceph-linode/ansible_inventory |grep rgw| awk {'print $2'} | sed 's/.*=//'`
echo "[rgws]" >> /etc/ansible/hosts
for item in ${rgws}
do
        echo $item >> /etc/ansible/hosts
done
echo "" >> /etc/ansible/hosts



