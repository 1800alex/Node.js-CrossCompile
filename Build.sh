#!/bin/bash

cd chroot/
sudo ./RunChrootNoMounts.sh "cd /Code/; ./Build-node-v4.6.2.sh; chmod a+rw ./BuiltNode/*; exit"
cd ../
