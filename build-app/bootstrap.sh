#!/usr/bin/env bash

#install EPEL & update yum
sudo yum install -y epel-release
echo "=====**installed epel**====="
sudo yum update
echo "=====**updated yum**====="

#install Git
sudo yum install -y git
echo "=====**installed git**====="

#install Golang
sudo yum install -y golang
echo "=====**installed go (yum)**====="

#clone demo app
git clone https://github.com/jdmendozaa/vuego-demoapp.git /vagrant/vuego-demoapp
echo "=====**cloned Demo app**====="


## install nodejs
# Add NodeSource yum repository to the system
curl -fsSL https://rpm.nodesource.com/setup_14.x | sudo bash -

# install Node.js and npm
sudo yum install -y nodejs
echo "=====**installed nodejs 14**====="

# install build tools
sudo yum install gcc-c++ make
echo "=====**installed build tools**====="

#install Yarn package manager
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install -y yarn
echo "=====**installed yarn**====="

#install Vue CLI
# yarn global add @vue/cli
npm install -g -y @vue/cli
echo "=====**installed vue cli**====="

#envvars backend
sudo sh -c "echo export PORT=4001 >> /etc/profile.d/sh.local"
sudo sh -c "IPSTACK_API_KEY=5bdf35885b5522ecf990fe0f3abcbe5b >> /etc/profile.d/sh.local"

# Build Backend
cd /vagrant/vuego-demoapp/server
go build
mv /vagrant/vuego-demoapp/server/vuego-demoapp /shared
echo "=====**backend bin file moved to shared folder**====="


#Build Frontend
echo 'export PORT=4001' >> /vagrant/vuego-demoapp/spa/.env.production.local
echo 'VUE_APP_API_ENDPOINT="http://10.0.0.8:4001/"' >> /vagrant/vuego-demoapp/spa/src/.env.production.local

cd /vagrant/vuego-demoapp/spa
sudo npm install
sudo npm run build
tar -czvf dist.tar.gz /vagrant/vuego-demoapp/spa/dist
echo "=====**compressing tar**====="
mv dist.tar.gz /shared
echo "=====**move artifact to shared folde**====="

rm -R /vagrant/vuego-demoapp