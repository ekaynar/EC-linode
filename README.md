# Erasure Coding Performance Testing on Linode

Scripts for automation of Ceph, COSBench, pbench, Spark installation on Linode.
Scripts setup the entire cluster (compute and storage).
Uses COSbench to apply I/O workload; pbench for monitoring the OSDs, and SSh scripts to run 

# File Inventory:
  * setup.py - Install and configure COSBench, pbench and Spark
 

# Setting up the Ceph Cluster
  Follow the steps in [here](Benchmarks/ceph-ansible/linode-installation.md)
 
  
# Input Trace File Format
 * sample.input - Sample trace.
 
 Each line represents "4M" object requests. Simulator read the trace and start issuing these requests.
 

# Usage

```

```

# Documentation

Please refer to [D3NSim wiki](https://github.com/ekaynar/d3nSim/wiki) for details.

# Running Multiple Configuration Settings
 
* Edit 'data' variable on multiRun.py. 'multiRun.py' will create separate config file per test case and store the log and result of each run in a seperate file.
 
 ``` python multiRun.py```
 
 * Displayin Results
 The script parses result.txt_ files and displays results in a single table.
 ```
 ./par.sh
 ```
 
