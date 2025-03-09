#!/bin/bash

#进入root模式
sudo i

#下载ImmortalWrt wan口固件
wget -O imm.img.gz "https://raw.githubusercontent.com/jinwanwuye/openwrt/refs/heads/main/immortalwrt-24.10.0-x86-64-generic-ext4-combined-wan.img.gz"

#解压固件
gzip -d imm.img.gz

#获取安装的盘符sda或者vda等等
AAA=$(lsblk -l|grep -i boot -B 1 |grep -i disk |awk '{print $1}')

#将固件dd到当前vps上的/dev/磁盘上
sudo dd if=imm.img of=/dev/${AAA} bs=4M status=progress oflag=sync

#强制系统重启
sudo echo b > /proc/sysrq-trigger
