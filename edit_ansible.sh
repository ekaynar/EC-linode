#!/bin/bash

clients=`cat ansible_inventory | grep mon | awk {'print $2'} | sed 's/.*=//'`

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



	#ssh $item 'ip r ' |grep "192." |awk '{print $9}'
