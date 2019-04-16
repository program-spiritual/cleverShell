#!/usr/bin/env bash

# 初始化环境  git nginx zsh
initWithGitNginxZsh(){
  # update apt-get
  apt-get update
  # install git nginx zsh
  apt-get install -y git nginx zsh
}
# 安装 oh-my-zsh 拓展
installOhMyZsh(){
  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo '
  # 生产环境
  export NODE_ENV="production"
  # zsh 本地字符集
  export LC_ALL=C
  ' >> ~/.zshrc
  source ~/.zshrc
}
# 安装 NVM NodeJS 版本管理工具
installNvm(){
  # 安装 nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
  echo '
   # NVM 配置
   export NVM_DIR="/root/.nvm"
   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
   export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
   ' >> ~/.zshrc
   # 引用
  source ~/.zshrc
}
## 初始化NODEJS环境
installNodejsEnv(){
  # 安装 node
  nvm install v8.12.0
  nvm alias default 8.12.0
  npm i pm2 -g
  # 创建 目录
  cd ~/ && mkdir github release www backups scripts upload
}
# 初始化 SSH 配置
initSsh(){
  # 配置 ssh
ssh-keygen -t rsa -b 4096 -C "node-`date`@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
}

# 初始化 SSH登录
initSshLogin(){
  # 配置 ssh 登录
  chmod 700 ~/.ssh
  touch ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys # 将自己电脑的公钥追加到这个文件
}
#  安装mongodb
installMongo(){
  mkdir -p /data/mongodb/data
  mkdir -p /data/mongodb/config
  mkdir -p /data/mongodb/logs
  cd /data/mongodb
  wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.4.7.tgz
  tar -xzf mongodb-linux-x86_64-3.4.7.tgz
  cd /data/mongodbtest/config
  #  配置 mongodb 文件
  echo '
  dbpath=/data/mongodb/data   #数据存放目录
  logpath=/data/mongodb/logs/mongod.log  #日志文件目录
  pidfilepath=/data/mongodb/mongod.pid  #pid端口文件
  logappend=true   #追加方式写日志文件
  fork=true        #后台运行
  journal=true     #启用日志选项，MongoDB的数据操作将会写入到journal文件夹的文件里
  ' > mongod.conf
  # 写入环境变量
  echo '
    export PATH=$PATH:/data/mongodb/mongodb-linux-x86_64-3.4.7/bin
  ' >> ~/.zshrc
  # 引用
  source ~/.zshrc
  # 启动 mongodb
  mongod -f /data/mongodb/config/mongod.conf
}
## 主函数
main(){
  initWithGitNginxZsh
  installOhMyZsh
  installNvm
  installNodejsEnv
  installMongo
  initSsh
  initSshLogin
}
## 启动脚本  ==============
main
