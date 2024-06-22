# Ubuntu云服务器安装ikuai
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-ikuai-vps.sh && chmod +x install-ikuai-vps.sh && ./install-ikuai-vps.sh

# X-WRT版本 22.10_b202304222337

# EFI启动安装
## 安装x-wrt到服务器的sda1分区
 wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda1/install-x-wrt-efi.sh && chmod 777 install-x-wrt-efi.sh && ./install-x-wrt-efi.sh

## 安装x-wrt到服务器的sda2分区
 wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda2/install-x-wrt-efi.sh && chmod 777 install-x-wrt-efi.sh && ./install-x-wrt-efi.sh

## 安装x-wrt到服务器的vda1分区
 wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/vda1/install-x-wrt-efi.sh && chmod 777 install-x-wrt-efi.sh && ./install-x-wrt-efi.sh

## 安装x-wrt到服务器的vda2分区
 wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/vda2/install-x-wrt-efi.sh && chmod 777 install-x-wrt-efi.sh && ./install-x-wrt-efi.sh

## 安装opewrt-koolshare到服务器的sda1分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda1/install-openwrt-koolshare.sh && chmod 777 install-openwrt-koolshare.sh && ./install-openwrt-koolshare.sh

## 安装opewrt-koolshare到服务器的sda2分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda2/install-openwrt-koolshare.sh && chmod 777 install-openwrt-koolshare.sh && ./install-openwrt-koolshare.sh

## 安装install-immortalwrt到服务器的vda2分区
 wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-immortalwrt.sh && chmod 777 install-immortalwrt.sh && ./install-immortalwrt.sh

## 安装openwrt到服务器的vda2分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-openwrt.sh && chmod 777 install-openwrt.sh && ./install-openwrt.sh

## 安装opewrt-koolshare到服务器的vda2分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-openwrt-koolshare.sh && chmod 777 install-openwrt-koolshare.sh && ./install-openwrt-koolshare.sh

# 普通启动选这个
### x-wrt安装到服务器vda1
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/vda1/install-x-wrt.sh && chmod 777 install-x-wrt.sh && ./install-x-wrt.sh

### x-wrt安装到服务器vda2
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/vda2/install-x-wrt.sh && chmod 777 install-x-wrt.sh && ./install-x-wrt.sh

### ikuai安装到腾讯云vda1分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-ikuai.sh && chmod 777 install-ikuai.sh && ./install-ikuai.sh

### ikuai安装到服务器sda1分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda1/install-ikuai.sh && chmod 777 install-ikuai.sh && ./install-ikuai.sh

### x-wrt安装到服务器sda1分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda1/install-x-wrt.sh && chmod 777 install-x-wrt.sh && ./install-x-wrt.sh

### ikuai安装到服务器sda2分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda2/install-ikuai.sh && chmod 777 install-ikuai.sh && ./install-ikuai.sh

### x-wrt安装到服务器sda2分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda2/install-x-wrt.sh && chmod 777 install-x-wrt.sh && ./install-x-wrt.sh

### ikuai安装到服务器sda3分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda3/install-ikuai.sh && chmod 777 install-ikuai.sh && ./install-ikuai.sh

### x-wrt安装到服务器sda3分区
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/sda3/install-x-wrt.sh && chmod 777 install-x-wrt.sh && ./install-x-wrt.sh

## 确定磁盘的路径和分区类型
使用 df 和 mount 命令可以查看 VPS 的磁盘信息，确定磁盘的第一个分区挂载路径，例如 /dev/sda1、/dev/vda1、/dev/xvda1 等等。需要注意的是，此分区的挂载路径以及可用空间大小，通常情况下此分区挂载在 / 或者 /boot 下，而我们在刷机过程中需要将固件等文件保存在此路径下。

使用 fdisk -l 命令可以查看分区类型，以确定分区是否为 GPT。如果分区为 GPT，则需要刷写 EFI 固件。但通常情况下分区不是 GPT 类型。

# openwrt 访问不了解决办法
## 在vnc界面输入 
### 关闭防火墙
/etc/init.d/firewall stop
### 阻止防火墙开机启动
/etc/init.d/firewall disable
### 编辑网卡
nano /etc/config/network
### 添加wan口，并把eth0绑定到wan口，把lan口绑定到eth1.
config interface 'loopback'  
        option device 'lo'  
        option proto 'static'  
        option ipaddr '127.0.0.1'  
        option netmask '255.0.0.0'  

config globals 'globals'  
        option ula_prefix 'fdfb:fb9a:169e::/48'  

config device  
        option name 'br-lan'  
        option type 'bridge'  
        list ports 'eth1'  

config interface 'lan'  
        option device 'br-lan'  
        option proto 'static'  
        option ipaddr '192.168.1.1'  
        option netmask '255.255.255.0'  
        option ip6assign '60'  

config interface 'wan'  
        option ifname 'eth0'  
        option proto 'dhcp'  

### 然后按ctrl+x退出，输入
/etc/init.d/network restart
### 重启网卡生效


