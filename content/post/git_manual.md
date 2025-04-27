---
layout: single
title: "Git 使用手册"
description: "-"
author: "谌中钱"
date: "2025-04-20"
image: "/img/temple_404_bg.jpg"
categories: [ "tech" ]
tags:
  - "engineering"
ogurl: "https://blog.climbtw.com/post/git_manual/"
---

<br />
<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [简介](#简介)
- [安装 Git](#安装-git)
  - [Windows 下](#windows-下)
  - [CentOS 9 下](#centos-9-下)
- [Git 常用命令](#git-常用命令)
- [Git 配置 SSH](#git-配置-ssh)
  - [Window 11 下](#window-11-下)
  - [CentOS 9 下](#centos-9-下-1)

<!-- /code_chunk_output -->

# 简介

> Git 是一个免费的开源分布式版本控制系统，旨在处理从小型到快速高效的超大型项目。

- Git 官网: <https://git-scm.com/>
- GitHub 国内镜像源 实时更新:
    - <https://blog.51cto.com/u_17218975/12981033>
        - 备用: <https://fcp7.com/github-mirror-daily-updates.html#google_vignette>

# 安装 Git

## Windows 下

1. 下载地址：<https://git-scm.com/downloads/win>
2. 下载安装包完成后，直接运行安装即可。
3. 设置 GitHub 国内镜像源:
   - Win + R 打开 运行 窗口，输入 cmd 打开 命令终端
   - 操作命令:

```shell
# 设置 GitHub 国内镜像源
git config --global url."https://bgithub.xyz/".insteadOf https://github.com/
# git config --global url."https://gitclone.com/github.com/".insteadOf https://github.com/
# 查看现有配置
# git config --global --get-regexp url

# 如果失效，则删除旧的，设置的新的
# 删除 GitHub 国内镜像源
# git config --global --unset url."https://bgithub.xyz/".insteadOf https://github.com/
# 重新设置
# git config --global url."https://kkgithub.com/".insteadOf https://github.com/
```

## CentOS 9 下

1. 进入云服务终端
    - 参考 [《云服务器购买和使用手册》](https://blog.climbtw.com/post/cloud_server_manual/)
2. 操作命令:

```shell
# 查看本地是否安装 git
dnf list installed | grep git
# 更新包索引，确保包都是最新的
dnf update

# 安装 git
dnf install -y git

# 设置 GitHub 国内镜像源
git config --global url."https://bgithub.xyz/".insteadOf https://github.com/
# git config --global url."https://gitclone.com/github.com/".insteadOf https://github.com/
# 查看现有配置
# git config --global --get-regexp url
# 删除 GitHub 国内镜像源
# git config --global --unset url."https://bgithub.xyz/".insteadOf https://github.com/

# 验证 git
git --version
```

# Git 常用命令

```shell
# 设置用户名和邮箱
git config --global user.email "templechan@126.com"
git config --global user.name "templechan"

# 初始化本地 git 仓库
git init
# 添加文件到暂存区
git add .
# 提交更改到本地
git commit -m "first commit"
# 修改主分支名字
git branch -M main

# 添加远程仓库地址
git remote add origin https://github.com/templechan/blog.git
# 修改为 SSH
git remote set-url origin git@github.com:templechan/blog.git
# 推送代码到远程仓库 origin 的 main 分支，-u 是建立分支联系，远程仓库没有对应分支时使用
git push -u origin main

# 克隆远程仓库到本地
git clone https://github.com/templechan/blog.git
# 克隆远程仓库的特定分支到本地
git clone -b dev https://github.com/templechan/blog.git

# 获取远程分支的最新信息
git fetch --all
# 查看所有分支
git branch -a
# 查看本地分支
git branch
# 查看远程分支
git branch -r

# 创建并切换到本地分支
git checkout -b dev
# 切换分支
git checkout main
# 删除分支
git branch -D dev

# 合并 指定分支 到 当前分支
git merge dev
# 发生冲突后，解决冲突后，将文件提交到暂存区，完成本地合并
git add .
git commit -m "commit"
# 推送到远程仓库（如果需要）
git push
# 如果远程仓库没有本地分支，则加上 -u 建立联系
git push -u origin main
```

# Git 配置 SSH

- 原则：
    - **私钥一定是要放在 客户端 的**，比如：
        - PC 连接 GitHub，PC 是客户端，就把 公钥 放在 GitHub 上。
        - 如果 GitHub Action 连接其他服务器实现 自动化部署，那么 GitHub 是客户端，就把 私钥 放在 GitHub 上。
    - 私钥 通常由 客户端 生成，**但并非绝对**：
        - 如上面的 **自动化部署**，需要服务端 集中管理 密钥，**由 服务端 生成 密钥对**。私钥需分发给客户端。
        - 又或者 企业级 **CA (证书颁发机构)** 统一签发密钥，**也需要服务端 集中管理 密钥**。私钥也需分发给客户端。

## Window 11 下

1. Win + R 打开 运行 窗口，输入 cmd 打开 命令终端
2. 操作命令:

```shell
# 生成 SSH 密钥
ssh-keygen -t rsa -b 4096 -C "templechan@126.com"

# 查看公钥，并复制
type %USERPROFILE%\.ssh\id_rsa.pub

# ‌添加公钥到 GitHub
# 登录 GitHub -> Settings -> SSH and GPG keys -> 粘贴公钥
```

## CentOS 9 下

1. 进入云服务终端
    - 参考 [《云服务器购买和使用手册》](https://blog.climbtw.com/post/cloud_server_manual/)
2. 操作命令:

```shell
# 生成 SSH 密钥
ssh-keygen -t rsa -b 4096 -C "templechan@126.com"

# 查看公钥，并复制
cat ~/.ssh/id_rsa.pub

# ‌添加公钥到 GitHub
# 登录 GitHub -> Settings -> SSH and GPG keys -> 粘贴公钥
```
