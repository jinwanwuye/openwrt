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

echo "请选择您的系统位数："
echo "1. 32位"
echo "2. 64位"
read -p "请输入选项（默认为2）:" option

if [ "$option" == "1" ]; then
    sysbit="x32"
else
    sysbit="x64"
fi

echo "正在下载${sysbit}位iKuaiOS安装包..."
if wget -q " https://raw.staticdn.net/jinwanwuye/openwrt/main/iKuai8_${sysbit}_3.7.16_Build202411141700.iso" -O ikuai8.iso; then
    echo "${sysbit}位iKuaiOS安装包下载完成！"
else
    echo "${sysbit}位iKuaiOS安装包下载失败，请检查下载链接是否可用或网络是否正常。"
    exit 1
fi

echo "正在挂载ISO镜像..."
sudo mount -o loop ikuai8.iso /mnt
echo "ISO镜像挂载成功！"

echo "正在复制ISO镜像启动文件..."
sudo cp -rpf /mnt/boot /
echo "ISO镜像启动文件复制完成！"

echo "请输入：sudo reboot 命令重启系统后前往VNC控制台继续安装。"
