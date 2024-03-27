#!/bin/sh

# 安装OpenClash
### OpenClash 依赖的是 dnsmasq-full，所以需要移除默认的dnsmasq
### 下载并安装 OpenClash
### 添加 luci-compact 并重启，否则会提示进入 luci 页面错误
opkg remove dnsmasq && opkg install dnsmasq-full
wget https://github.com/vernesong/OpenClash/releases/download/v0.46.003-beta/luci-app-openclash_0.46.003-beta_all.ipk -O openclash.ipk
opkg update
opkg install openclash.ipk
opkg install luci luci-base luci-compat
reboot