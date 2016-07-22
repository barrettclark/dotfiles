#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo apt-get update
sudo apt-get install build-essential bash-completion wget curl vim \
  git tree ctags npm sqlite redis-server tmux memcached cowsay \
  fortune gradle highlight mosquitto golang docker cmake \
  openssh-server jq r-base

# https://github.com/magicmonty/bash-git-prompt
rm -rf ~/.bash-git-prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# https://toolbelt.heroku.com/debian
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS21UbuntuPGSQL93Apt
sudo apt-get install postgresql-9.4-postgis-2.1 postgresql-contrib \
  postgresql-server-dev-9.4 pgadmin3

sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install qgis python-qgis qgis-plugin-grass
