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

# 2. 安裝 rbenv
echo -e "\e[31m[Rails] Installing RVM ...\e[0m"
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL

# 2. 安裝 rbenv plugins ruby-build
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
exec $SHELL

# ---------------------
# Setting deploy user
# ---------------------

# 1. 新增 rails application deploy user
echo -e "\e[31m[RailsAPP] Create deploy user = $DEPLOY_USER ...\e[0m"
useradd $DEPLOY_USER -m -G $WEB_GROUP -s /bin/bash
echo -e "\e[31m[RailsAPP] Setting Deploy user password ...\e[0m"
passwd $DEPLOY_USER

# 2. 授權 public key 登入 deploy user
mkdir /home/$DEPLOY_USER/.ssh/
cp ~/.ssh/authorized_keys /home/$DEPLOY_USER/.ssh/authorized_keys

# 3. 加入 sudoer 要把 deploy user 加到 web group，因為 static file 也需要 nginx 也需要有權限存取
echo -e "\e[31m[RailsAPP] Add deploy user to sudoer list ...\e[0m"
echo "$DEPLOY_USER  ALL=(ALL:ALL) ALL" >> /etc/sudoers

# 4. Setting deploy folder
echo -e "\e[31m[Rails] Setting deploy user bash config ...\e[0m"
mkdir /var/www
chown $DEPLOY_USER:$DEPLOY_USER /var/www
