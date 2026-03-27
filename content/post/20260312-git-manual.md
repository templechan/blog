---
layout: post
title: Git 使用手册
subtitle: 
description: 涉及 Git 安装，常用命令，SSH配置 等。
author: 谌中钱
date: 2026-03-12
lastMod: 
image: img/post-bg-default.png
categories: 
- programming
tags: 
- CI/CD
slug: git-manual
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 简介安装](#1-简介安装)
- [2 常用命令](#2-常用命令)
- [3 生成 SSH 密钥](#3-生成-ssh-密钥)

<!-- /code_chunk_output -->


## 1 简介安装

> Git 是一个免费的开源分布式版本控制系统，旨在处理从小型到快速高效的超大型项目。

- 官网: <a href="https://git-scm.com" target="_blank">`https://git-scm.com`</a>
- 安装：在官网直接下载安装即可使用。

## 2 常用命令

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

## 3 生成 SSH 密钥

> 配置好 SSH，以后 推送 代码不用输密码。

```shell
# 生成 公钥（id_ed25519.pub） 和 私钥（id_ed25519），一路回车即可
ssh-keygen -t ed25519 -C "templechan@126.com"

# 找到公钥（id_ed25519.pub）并复制
# Windows
type %USERPROFILE%\.ssh\id_ed25519.pub
# macOS/Linux
cat ~/.ssh/id_ed25519.pub

# 把公钥粘贴到代码平台，GitHub/GitLab/码云 等
# 如 GitHub → Settings → SSH and GPG keys，点击 New SSH key，标题随便填，粘贴公钥（id_ed25519.pub）全文
```
