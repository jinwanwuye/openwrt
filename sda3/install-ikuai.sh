#!/bin/sh

#下载内核文件
wget https://github.com/jinwanwuye/openwrt/raw/main/x-wrt-x86-64-generic-initramfs-kernel.bin

#下载安装包
wget https://github.com/jinwanwuye/openwrt/raw/main/iKuai8_x32_3.7.11_Build202403051040.img.gz

#下载内核执行脚本
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda3/x-wrt-install-vps.sh

#获取内核版本
Ker=$(uname -r)

#复制内核文件并替换
cp x-wrt-x86-64-generic-initramfs-kernel.bin /boot/vmlinuz-$Ker

#复制x-wrt固件到根目录并改名
cp iKuai8_x32_3.7.11_Build202403051040.img.gz /x-wrt.img.gz

#复制内核脚本到根目录并改名
cp x-wrt-install-vps.sh /

echo "执行完成，正在重启，稍等五分钟,在浏览器输入https://服务器ip"
reboot