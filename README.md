# 版本v9.0_b202109200103
### EFI启动安装x-wrt
 wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-x-wrt-efi.sh && chmod 777 install-x-wrt-efi.sh && ./install-x-wrt-efi.sh

### x-wrt安装
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-x-wrt.sh && chmod 777 install-x-wrt.sh && ./install-x-wrt.sh

### opewrt安装
wget https://raw.githubusercontent.com/jinwanwuye/openwrt/main/install-openwrt.sh && chmod 777 install-openwrt.sh && ./install-openwrt.sh

### openwrt 访问不了解决办法
## 在vnc界面输入 
nano /etc/config/network
## 添加wan口，并把eth0绑定到wan口，把lan口绑定到eth1.
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

## 然后按ctrl+x退出，输入
/etc/init.d/network restart
## 重启网卡生效


