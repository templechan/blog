---
layout: post
title: Node 使用手册
subtitle: 
description: 涉及 Node环境安装 等。
author: 谌中钱
date: 2025-05-08
lastMod: 
image: img/post-bg-default.png
categories: 
- programming
tags: 
- node
slug: node-manual
weight:
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 Node环境安装](#1-node环境安装)
  - [2 Windows 11](#2-windows-11)

<!-- /code_chunk_output -->


## 1 Node环境安装

- Node 官网：<a href="https://nodejs.org/zh-cn/" target="_blank">`https://nodejs.org/zh-cn/`</a>

### 2 Windows 11

- 下载安装版本管理工具 nvm-windows：<a href="https://github.com/coreybutler/nvm-windows/releases/download/1.2.2/nvm-setup.exe" target="_blank">`https://github.com/coreybutler/nvm-windows/releases/download/1.2.2/nvm-setup.exe`</a>
- Nvm 相关命令：

```shell
# 安装最新稳定版Node
nvm install --lts

# 查看已安装列表
nvm list
#     24.14.1
#   * 24.11.1 (Currently using 64-bit executable)

# 使用指定版本
nvm use 24.14.1

# 卸载指定版本
nvm uninstall 24.11.1

# 安装 pnpm
npm install pnpm
# 设置存储目录
pnpm config set store-dir D:\dev\env\env\nvm\.pnpm-store
```