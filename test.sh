#!/bin/bash

clients=`cat ~/ceph-linode/ansible_inventory | grep client | awk {'print $2'} | sed 's/.*=//'`
#rgws=`cat ~/ceph-linode/ansible_inventory |grep rgw| awk {'print $2'} | sed 's/.*=//'`
rgws=`ansible -m shell -a "ip r " rgws |grep "192.168" |awk '{print $9}'`
count=0
echo $rgws
for item in ${clients}

do
	arr=($rgws)
	echo ${arr[$count]}
	ssh $item "bash -s" -- < ./manage-etc-hosts.sh "remove rgw "
	ssh $item "bash -s" -- < ./manage-etc-hosts.sh "add rgw ${arr[$count]}"
	count=$((count+1))	

done


#arr=($clients)
#scp -r ~/.ssh/id_rsa ${arr[0]}:~/.ssh/
#scp -r ~/workloadCos ${arr[0]}:~/
#scp -r /etc/ansible/hosts ${arr[0]}:/etc/ansible
#scp -r /etc/ansible/ansible.cfg  ${arr[0]}:/etc/ansible


#ansible -m copy -a "src=/ceph-ansible-keys/cf9fa922-6b4b-4d6f-b453-f1239b7ef90e/etc/ceph/ceph.client.admin.keyring  dest=/etc/ceph/ceph.client.admin.keyring" rgws -i ~/ceph-linode/ansible_inventory

 
#ansible -m copy -a "src=/ceph-ansible-keys/cf9fa922-6b4b-4d6f-b453-f1239b7ef90e/etc/ceph/ceph.client.admin.keyring  dest=/etc/ceph/ceph.client.admin.keyring" clients -i ~/cep-linode/ansible_inventory


