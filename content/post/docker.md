---
layout: post
title: "Docker 使用记录"
description: "Docker 安装，设置国内软件源，国内镜像代理实时更新，常用命令。"
author: "谌中钱"
date: "2025-01-17"
image: "/img/temple-404-bg.png"
categories: [ "Tech" ]
tags:
  - "Back-end"
---

<br />
<br />

- [简介安装](#简介安装)
  - [简介](#简介)
  - [安装](#安装)
    - [CentOS 9](#centos-9)
- [常用命令](#常用命令)

# 简介安装

## 简介

> Docker 可帮助开发人员随时随地构建、共享、运行和验证应用程序，而无需繁琐的环境配置或管理。

- 官网：<https://www.docker.com/>
- 文档：<https://docs.docker.com/engine/install/centos/>
- 官方镜像仓库：<https://hub.docker.com/>
  - 国内镜像源实时更新：
    - <https://github.com/dongyubin/DockerHub?tab=readme-ov-file>
      - <https://www.wangdu.site/course/2109.html#google_vignette>

## 安装

### CentOS 9

```shell
# 卸载旧版 Docker
dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

# 查看 centos-extras 是否开启
dnf repolist all 
# 如果未开启，则需要启用 centos-extras 存储库，将其 enabled 的值设置为1
vim /etc/yum.repos.d/OpenCloudOS.repo
# 保存后，清除重建缓存
dnf clean all && dnf makecache

# 设置 Docker 国内软件源
dnf install -y dnf-plugins-core
# dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 安装 Docker
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# 设置 Docker 国内镜像源
tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://docker.1panel.dev",
    "https://docker.foreverlink.love",
    "https://docker.xn--6oq72ry9d5zx.cn",
    "https://docker.zhai.cm",
    "https://docker.5z5f.com",
    "https://a.ussh.net",
    "https://docker.cloudlayer.icu",
    "https://hub.littlediary.cn",
    "https://hub.crdz.gq",
    "https://docker.unsee.tech",
    "https://docker.kejilion.pro",
    "https://registry.dockermirror.com",
    "https://hub.rat.dev",
    "https://dhub.kubesre.xyz",
    "https://docker.nastool.de",
    "https://docker.udayun.com",
    "https://docker.rainbond.cc",
    "https://docker.1panelproxy.com",
    "https://atomhub.openatom.cn",
    "https://docker.m.daocloud.io",
    "https://docker.1ms.run",
    "https://docker.linkedbus.com",
    "https://dytt.online",
    "https://func.ink",
    "https://lispy.org",
    "https://docker.xiaogenban1993.com"
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

# 常用命令

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
