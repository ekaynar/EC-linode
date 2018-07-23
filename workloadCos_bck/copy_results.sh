#!/bin/bash

source="gprfc038.sbu.lab.eng.bos.redhat.com"
dest="/root/results/"
scp -r root@$source:/var/www/html/pub $dest/


