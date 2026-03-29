---
layout: post
title: Docker 使用手册
subtitle: 
description: 涉及 Docker 安装，国内镜像代理实时更新，设置国内软件源，常用命令 等。
author: 谌中钱
date: 2026-03-06
lastMod: 
image: img/post-bg-default.png
categories: 
- programming
tags: 
- 部署
slug: docker-manual
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->



<!-- /code_chunk_output -->

## 1 简介

> Docker 可帮助开发人员随时随地构建、共享、运行和验证应用程序，而无需繁琐的环境配置或管理。

- 官网：<a href="https://www.docker.com" target="_blank">`https://www.docker.com`</a>
- 文档：<a href="https://docs.docker.com/engine/install/centos" target="_blank">`https://docs.docker.com/engine/install/centos`</a>
- 官方镜像仓库：<a href="https://hub.docker.com" target="_blank">`https://hub.docker.com`</a>
  - 国内镜像源实时更新：
    - 访问需要梯子：<a href="https://github.com/dongyubin/DockerHub?tab=readme-ov-file" target="_blank">`https://github.com/dongyubin/DockerHub?tab=readme-ov-file`</a>
    - 国内备用：<a href="https://www.wangdu.site/course/2109.html#google_vignette" target="_blank">`https://www.wangdu.site/course/2109.html#google_vignette`</a>

## 2 安装

### 2.1 CentOS 9 环境

```shell
# 卸载旧版 Docker
dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
# 自动启用仓库
sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/OpenCloudOS.repo
# 保存后，清除重建缓存
dnf clean all && dnf makecache

# 设置 Docker 国内软件源
dnf install -y dnf-plugins-core
# dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 安装 Docker
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 设置 Docker 国内镜像代理
tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://dockerproxy.net",
    "https://proxy.vvvv.ee",
    "https://dockerproxy.link"
  ]
}
EOF
systemctl daemon-reload

# 启动 Docker
systemctl start docker
systemctl restart docker
# 验证 Docker
docker run hello-world
dokcer images
docker ps -a

# 设置 Docker 自启
systemctl enable docker
```

### 2.2 常用命令

```shell
# 查看所有本地镜像
docker images
# 按关键字搜索本地镜像
docker images | grep 关键字
# 查看所有容器
docker ps -a
# 按关键字搜索容器
docker ps -a | grep 关键字

# 拉取远程镜像
docker pull 镜像名
# 删除镜像
docker rmi 镜像ID
# 删除容器
docker rm 容器ID

# 构建镜像
docker build -t 镜像名 .
# 创建并运行容器
docker run -d --restart=always -p 80:81 --name 容器名 镜像名

# 启动容器
docker start 容器ID
docker restart 容器ID
# 停止容器
docker stop 容器ID

# 查看资源消耗状态
docker stats
# 查看容器网络信息
docker inspect 容器ID
```