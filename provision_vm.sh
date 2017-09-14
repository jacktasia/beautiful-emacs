#!/bin/bash

echo 'Installing emacs...'
sudo add-apt-repository ppa:kelleyk/emacs -y
sudo apt-get -qq update
sudo apt-get -qq install emacs25 -y

clone_url=https://github.com/jacktasia/beautiful-emacs
if [ -f /vagrant/id_rsa -a ! -f /home/ubuntu/.ssh/id_rsa ]; then
  echo 'Copying ssh key...'
  cp /vagrant/id_rsa /home/ubuntu/.ssh/id_rsa
  clone_url=git@github.com:jacktasia/beautiful-emacs.git
fi

ssh -o StrictHostKeyChecking=no git@github.com
mkdir -p /home/ubuntu/code
cd /home/ubuntu/code

echo 'Cloning beautiful-emacs'
git clone $clone_url
cd beautiful-emacs
bash setup.sh
