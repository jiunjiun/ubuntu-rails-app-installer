#!/bin/bash
# @author jiunjiun from eddie li (ADZ)
# @updated_at 2014/08/19
# @version 0.01

DEPLOY_USER='rails'
WEB_GROUP='www-data'
RUBY_VERSION='2.1.2'

# ---------------------
# Ruby + Rails
# ---------------------

# 1. 安裝 node.js for assets pipeline
echo -e "\e[31m[RailsAPP] Installing runtime js library for assets pipelie ...\e[0m"
# echo -e "\e[31m[RailsAPP] Add node.js source for apt ...\e[0m"
# add-apt-repository ppa:chris-lea/node.js -y
echo -e "\e[31m[RailsAPP] Update apt package list and install node.js ...\e[0m"
sudo apt-get install nodejs
sudo apt-get install build-essential libssl-dev
# mysql lib client for gem => mysql2
sudo apt-get install libmysqlclient-dev -y

# 2. 安裝 rbenv
echo -e "\e[31m[Rails] Installing RVM ...\e[0m"
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL

# 3. 安裝 rbenv plugins ruby-build
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
exec $SHELL

source .bash_profile
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

gem install rails