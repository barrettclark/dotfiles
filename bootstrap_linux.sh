#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo apt-get -qq -y update
sudo apt-get -qq -y dist-upgrade
sudo apt-get -qq -y upgrade
sudo apt-get -qq -y autoremove
sudo apt-get -qq -y install --fix-missing build-essential \
  bash-completion wget curl vim git tree ctags sqlite python_pip \
  redis-server tmux memcached cowsay fortune gradle highlight mosquitto \
  golang docker cmake openssh-server jq r-base fish

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -qq -y nodejs

# https://github.com/magicmonty/bash-git-prompt
rm -rf ~/.bash-git-prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# https://toolbelt.heroku.com/debian
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS21UbuntuPGSQL93Apt
# sudo apt-get -qq install postgresql-9.4-postgis-2.1 postgresql-contrib \
#   postgresql-server-dev-9.4 pgadmin3

# sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
# sudo apt-get -qq update
# sudo apt-get -qq install qgis python-qgis qgis-plugin-grass
