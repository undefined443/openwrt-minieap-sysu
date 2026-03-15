# MiniEAP for OpenWrt

MiniEAP 的中山大学适配版，已在东校园至善园稳定运行 2 学年。

## Build

1. 根据你的路由器型号找到对应的 SDK 版本：

   - [OpenWrt Firmware Selector](https://firmware-selector.openwrt.org/)
   - [ImmortalWrt Firmware Selector](https://firmware-selector.immortalwrt.org/)

2. 根据 SDK 版本启动对应镜像：

   - [openwrt/sdk](https://hub.docker.com/r/openwrt/sdk/tags)
   - [immortalwrt/sdk](https://hub.docker.com/r/immortalwrt/sdk/tags)

   ```sh
   docker run -it --name immortalwrt immortalwrt/sdk:mediatek-filogic-23.05-SNAPSHOT bash
   ```

3. 克隆并编译 minieap：

   ```sh
   git clone https://github.com/undefined443/openwrt-minieap-sysu package/minieap
   make menuconfig  # choose `minieap` in section `Network`
   make package/minieap/compile V=s
   ```

   获取编译产物路径：

   ```sh
   find bin -name "minieap*.ipk"
   ```

## Install

1. 将编译产物上传到路由器后，安装：

   ```sh
   opkg install minieap*.ipk
   ```

2. 启动：

   ```sh
   minieap -u <username> -p <password> -n wan -w
   ```

参见：[使用 minieap 实现路由器锐捷认证上网 | 博客园](https://www.cnblogs.com/undefined443/p/18375072)
