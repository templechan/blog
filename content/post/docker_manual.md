---
layout: single
title: "Docker 使用手册"
description: "-"
author: "谌中钱"
date: "2025-04-12"
image: "/img/temple-404-bg.png"
categories: [ "tech" ]
tags:
  - "engineering"
---

<br />
<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [简介](#简介)
- [安装 Docker](#安装-docker)
  - [CentOS 9 下](#centos-9-下)
- [Docker 常用命令](#docker-常用命令)

<!-- /code_chunk_output -->

# 简介

> Docker 可帮助开发人员随时随地构建、共享、运行和验证应用程序，而无需繁琐的环境配置或管理。

- Docker 官网: <https://www.docker.com>
- Docker 文档: <https://docs.docker.com/engine/install/centos>
    - Docker 国内软件源:
        - 阿里云镜像: <https://developer.aliyun.com/mirror/docker-ce?spm=a2c6h.13651102.0.0.39fd1b11KE7ti3>
- Docker 官方镜像仓库: <https://hub.docker.com>
    - Docker 镜像仓库 国内镜像源 实时更新: <https://github.com/dongyubin/DockerHub?tab=readme-ov-file>

# 安装 Docker

## CentOS 9 下

1. 进入云服务终端
    - 参考 [《云服务器购买和使用手册》](https://blog.climbtw.com/post/cloud_server_manual/)
2. 操作命令:

```shell
# 卸载旧版 Docker
dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

# 更新包索引，确保包都是最新的
dnf update
# 安装 dnf 存储库 的 管理软件包
dnf install -y dnf-plugins-core
# 设置  Docker 国内软件源
# dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 安装 Docker
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# 设置 Docker 镜像仓库 国内镜像源
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://docker.mybacc.com",
    "https://dytt.online",
    "https://lispy.org",
    "https://docker.xiaogenban1993.com",
    "https://docker.yomansunter.com",
    "https://aicarbon.xyz",
    "https://666860.xyz",
    "https://docker.zhai.cm",
    "https://a.ussh.net",
    "https://hub.littlediary.cn",
    "https://hub.rat.dev",
    "https://docker.m.daocloud.io"
  ]
}
EOF
# 重新加载配置文件
systemctl daemon-reload
# 设置 Docker 自启
systemctl enable docker

# 验证 Docker
docker --version
# Docker version 28.1.1, build 4eba377

# 启动 Docker
systemctl start docker
systemctl restart docker
```

# Docker 常用命令

```shell
# 查看所有本地镜像
docker images
# 按 关键字 搜索本地镜像
docker images | grep 关键字
# 查看所有容器
docker ps -a
# 按 关键字 搜索容器
docker ps -a | grep 关键字

# 拉取远程镜像
docker pull 镜像名
# 构建镜像
docker build -t 镜像名 .
# 创建并运行容器
docker run -d --restart=always -p 80:80 --name 容器名 镜像名

# 启动容器
docker start 容器ID
docker restart 容器ID
# 停止容器
docker stop 容器ID

# 删除镜像
docker rmi 镜像ID
# 删除容器
docker rm 容器ID

# 查看容器日志
docker logs --tail 30 容器ID
docker logs -f 容器ID
# 查看资源消耗状态
docker stats
# 查看容器网络信息
docker inspect 容器ID
```
