#!/usr/bin/env bash

# Executing bin
cd /shared
chmod +x vuego-demoapp
./vuego-demoapp
echo "=====**bin executed**====="

sudo sh -c "echo export PORT=4001 >> /etc/profile.d/sh.local"
source /etc/profile.d/sh.local

# Running on background
cd /vagrant/run-app
./run-backend.sh < /dev/null >& /dev/null &
disown
exit