#!/bin/bash

COUNTER=3

echo "Creating Templatesi"
./writeXML.sh
echo "Starting Experiments"

while [  $COUNTER -lt 10 ]; do
	echo The counter is $COUNTER
	echo "Filling The Cluster"
	./prepCluster.sh       
	sleep 60
	echo "Running IO Workload"
	./runtest.sh

	let COUNTER=COUNTER+1 
done


