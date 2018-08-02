# Erasure Coding Performance Testing on Linode

Scripts for automation of Ceph, COSBench, pbench, Spark installation on Linode.
Scripts setup the entire cluster (compute and storage).
Uses COSbench to apply I/O workload; pbench for monitoring the OSDs, and SSh scripts to run 

# File Inventory:
  * setup.sh - Install and configure COSBench, pbench and Spark
  * workloadCos - Directory for automated COSBench scripts
    * vars.shinc - Config file for test
    * writeXML.sh - create XML templates for COSbench workloads
    * prepCluster.sh - Prepare Cluster for the test and fill it with data
    * runtest.sh - Run the actual IO workload

# Setting up the Ceph Cluster
  Follow the steps defined in [ceph-linode-installation](EC-linode/ceph-linode-installation.md)
 
# Installing and configuring COSBench, pbench and SPark
 ```
 ./setup.sh
 ```

# Testing the Installation
* For Cosbench;
 Open ``http://<Admin_Node_IP>:19088/controller/index.html``
 
 * For pbench
 Open ``http://<Admin_Node_IP>/pub``

# Running COSBench Workload
 
 ```
 cd WorkloadCos
 vim vars.shinc
 ./writeXML.sh
 ./prepCluster.sh
 ./runtest.sh
 ```
 
