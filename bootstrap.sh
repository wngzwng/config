#!/usr/bin/env bash 
# desc: 部署配置文件


# 检查是否有对应的文件
[ -d "$HOME/.local/config/" ] || mkdir "$HOME/.local/config/"
cd "$HOME/.local/config/"
git clone https://github.com/wngzwng/config.git 

