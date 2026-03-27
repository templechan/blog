---
layout: post
title: Windows 系统重装手册
subtitle: 
description: 涉及 系统重装的流程 等。
author: 谌中钱
date: 2026-01-17
lastMod: 
image: images/post-bg-default.png
categories: 
- tool
tags: 
- 操作系统
slug: windows-system-reinstallation-manual
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 工具准备](#1-工具准备)
- [2 重装流程](#2-重装流程)
  - [2.1 制作U盘启动盘](#21-制作u盘启动盘)
  - [2.2 进入U盘启动盘的PE系统](#22-进入u盘启动盘的pe系统)
  - [2.3 在PE系统内重装系统](#23-在pe系统内重装系统)
  - [2.4 激活新系统](#24-激活新系统)

<!-- /code_chunk_output -->


## 1 工具准备

- 硬件：
    - 需要重装系统的 **电脑**：需要可以上网
        - 注意 **备份电脑里的资料**，后面会格式化电脑
        - 作者用的 机械革命 无界14Pro 2023锐龙版 （R7 7840HS / 32GB / 1TB / 780M 核显），¥ 4000 左右
    - **空U盘**：容量 ≥ 16 GB，需要格式化
- 软件：
    - 在电脑里 下载并安装好 软件 **U盘纯净启动盘制作工具**：<a href="https://www.sysceo.com/software-softwarei-id-129.html" target="_blank">`https://www.sysceo.com/software-softwarei-id-129.html`</a>
        - 安装时可能提示需要更新，按照建议确认更新就行
    - 需要重装的 Windows 的版本对应的 **永久激活码**：去淘宝搜 Windows永久激活码 购买即可，¥ 10 左右
        - 作者用的 Windows 11 专业工作站版
    - 在电脑里 下载好 需要版本的 **系统镜像文件**：<a href="https://next.itellyou.cn/Original/Index?id=7ab5f0cb-7607-4bbe-9e88-50716dc43de6" target="_blank">`https://next.itellyou.cn/Original/Index?id=7ab5f0cb-7607-4bbe-9e88-50716dc43de6`</a>
        - 作者下载的 ***Windows 11 (business editions), version 25H2 (updated March 2026) (x64) - DVD (Chinese-Simplified)***

## 2 重装流程

### 2.1 制作U盘启动盘

- 在电脑上 插上 准备好的 **U盘**，启动 **U盘纯净启动盘制作工具**
- 在 **U盘模式** 下，选择设备里找到你的 U盘，点击 **一键制作**，等待制作完成即可
- 制作完成后，把之前下载好的 **系统镜像文件** 拷贝到 **U盘** 里

### 2.2 进入U盘启动盘的PE系统

- 插上 U盘 后，重启电脑，不停的按 F2 或 F12 等，进到 启动选择界面
    - 不同品牌型号的电脑，快捷键都不一样，F2，F12 等
        - 这里需要百度查询下，你的品牌的电脑，重启后是 按什么 快捷键 进入启动选择界面
    - ***这一步如果出现问题，可以百度搜索，评论或私信我***
- 在启动选择界面，选择我们 **U盘** 去启动，会进到 U盘 内部的 **PE系统列表** 让你选择，默认 **第一个** 进入就行

### 2.3 在PE系统内重装系统

- **建议** 对电脑全盘格式化，彻底的重装电脑
    - 找到桌面上的 **DiskGenius（分区工具）** 硬盘格式化软件，对 电脑 进行格式化分区
        - 我分了3个盘，你可以按照你的需求进行分区
        - ***不知道怎么使用 DiskGenius 格式化分区，直接百度搜索下即可***
- 电脑格式化完成后，找到桌面上的 **安装系统** 的软件，选择我们之前放到 U盘 内部的 **系统镜像文件**，然后确定，即可开始重装系统
    - 重装期间电脑可能重启几次，重装结束后会关机
- 关机后，再开启电脑，即可进入重装好的 新系统

### 2.4 激活新系统

- 进入到新系统桌面后，在 设置 > 更新和安全 > 激活，输入之前淘宝购买的 **永久激活码**，确认即可