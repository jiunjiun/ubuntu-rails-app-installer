#!/bin/bash
echo -e "\e[31mAptitude - Update & Upgrade\e[0m"
aptitude update
aptitude upgrade
echo -e "\e[31mInstall common tools\e[0m"
# 安裝常用工具
aptitude install curl git-core python-software-properties bash-completion htop iftop tmux vim -y
echo -e "\e[31mDownload the shellscript configuration in current user home dir: ~/$(whoami)\e[0m"
cd ~

echo -e "\e[31mSkipping SSH HostKeyChecking ... \e[0m"
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" > ~/.ssh/config

git clone https://github.com/afunction/dotfiles .dotfiles
# 設定 bash, vim, gitconfig
echo -e "\e[31mSetting up bash shell ... \e[0m"
rm -rf .bash_profile
ln -s .dotfiles/bash_profile_ubuntu .bash_profile

echo -e "\e[31mSetting up vim ... \e[0m"
rm -rf .vimrc
ln -s .dotfiles/vimrc .vimrc

echo -e "\e[31mSetting up git ... \e[0m"
rm -rf .gitconfig
ln -s .dotfiles/gitconfig .gitconfig

echo -e "\e[31mDownload vim color schema & bundles ... \e[0m"
cd .dotfiles
# 更新 vim,
git submodule init
git submodule update

echo -e "\e[31mDownload Installer shell script ... \e[0m"
git clone git@github.com:afunction/ubuntu-rails-app-installer.git installer