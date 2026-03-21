# MiniEAP for OpenWrt

MiniEAP 的中山大学适配版，已在东校园至善园稳定运行 2 学年。

## Prerequisites

1. 任意 Linux 发行版
2. docker

## Build

1. 根据路由器型号（model）确定 CPU 平台：[OpenWrt Table of Hardware](https://toh.openwrt.org/)

   > 以 Redmi AX6000 为例，根据硬件信息中的 Target 和 S.Target 确定其 CPU 平台为 `mediatek/filogic`

2. 找到适配路由器 OpenWrt/ImmortalWrt 发行版的 SDK 镜像：

   - [openwrt/sdk](https://hub.docker.com/r/openwrt/sdk/tags)
   - [immortalwrt/sdk](https://hub.docker.com/r/immortalwrt/sdk/tags)

   > 以 Redmi AX6000 为例，目前运行 ImmortalWrt:23.05-SNAPSHOT 系统，因此选择 `immortalwrt/sdk:mediatek-filogic-23.05-SNAPSHOT` 镜像

3. 使用镜像构建 minieap 安装包：

   ```sh
   git clone https://github.com/undefined443/openwrt-minieap-sysu minieap && \
   docker run -u 0:0 --rm \
       -v ./minieap:/home/build/immortalwrt/package/minieap \
       -v ./output:/home/build/immortalwrt/bin \
       --network=host \
       immortalwrt/sdk:mediatek-filogic-23.05-SNAPSHOT \
       bash -c "make defconfig && make package/minieap/compile V=s" && \
   mv $(find output/packages -name "minieap*") minieap.ipk && \
   rm -rf minieap output
   ```

## Install

1. 将 minieap 安装包上传到路由器：

   ```sh
   scp minieap.ipk root@immortalwrt.lan:
   ssh root@immortalwrt.lan
   ```

2. 安装：

   ```sh
   opkg install minieap.ipk
   ```

## Usage

1. 启动：

   ```sh
   minieap -u <username> -p <password> -w                # 东校区至善园
   minieap -u <username> -p <password> -w --module rjv3  # 其他宿舍楼
   ```

   - `-w`：保存配置到文件（`/etc/minieap.conf`）

2. 允许开机自启：

   ```sh
   /etc/init.d/minieap enable  # 允许开机自启
   /etc/init.d/minieap start   # 启动服务
   ```

参见：[使用 minieap 实现路由器锐捷认证上网 | 博客园](https://www.cnblogs.com/undefined443/p/18375072)
