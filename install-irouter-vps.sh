#!/bin/bash

echo "正在查询IP地址、子网掩码、网关和DNS服务器..."
echo "----------------------------------------------"
ip route show | awk '/default/ {print "网关: "$3}'
echo
ip -o -4 addr show | awk -F '[ /]+' '/global/ {print "IP地址: "$4"\n子网掩码: "$5}'
echo 
awk '/nameserver/ {print "DNS服务器 : ", $2}' /etc/resolv.conf
echo "----------------------------------------------"

while true; do
    read -r -p "请牢记以上信息，按 y 继续，按 n 退出..." yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "请输入 y 或 n.";;
    esac
done

sudo su
apt-get update
sudo apt -y install python3-pip
pip install gdown

echo "请选择您要安装的软路由系统："
echo "1. iRouter软路由"
echo "2. 高恪软路由"
read -p "请输入选项（默认为2）:" option

if [ "$option" == "1" ]; then
    sysbit="1hX5cB8kkOXZ6r_rLoEue1nolUR5OPUz4"
else
    sysbit="1PgTzzStnS2bwumrZK1tl3eb8UAXIuVdh"
fi

echo "正在下载${sysbit}软路由安装包..."
if gdown -O test.iso "${sysbit}"; then
    echo "${sysbit}软路由安装包下载完成！"
else
    echo "${sysbit}软路由安装包下载失败，请检查下载链接是否可用或网络是否正常。"
    exit 1
fi

echo "正在挂载ISO镜像..."
sudo mount -o loop test.iso /mnt
echo "ISO镜像挂载成功！"

echo "正在复制ISO镜像启动文件..."
sudo cp -rpf /mnt/boot /
echo "ISO镜像启动文件复制完成！"

echo "请输入：sudo reboot 命令重启系统后前往VNC控制台继续安装。"

