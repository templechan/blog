---
layout: post
title: 云服务器购买和使用手册
subtitle: 
description: 涉及 云服务器购买，配置，备案 等。
author: 谌中钱
date: 2026-01-20
lastMod: 
image: img/post-bg-default.png
categories: 
- tool
tags: 
- 操作系统
slug: cloud-server-manual
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 腾讯云](#1-腾讯云)
  - [1.1 资源购买和地址](#11-资源购买和地址)
    - [1.1.1 云服务器](#111-云服务器)
    - [1.1.2 域名](#112-域名)
    - [1.1.3 免费 DNS 服务](#113-免费-dns-服务)
    - [1.1.4 免费 SSL 证书](#114-免费-ssl-证书)
  - [1.2 本地登录云服务器](#12-本地登录云服务器)
  - [1.3 DNS 配置](#13-dns-配置)
  - [1.4 SSL 配置](#14-ssl-配置)
  - [1.5 服务器域名备案](#15-服务器域名备案)

<!-- /code_chunk_output -->


## 1 腾讯云

- 官网地址：<a href="https://cloud.tencent.com" target="_blank">`https://cloud.tencent.com`</a>

### 1.1 资源购买和地址

#### 1.1.1 云服务器

- 轻量应用服务器：<a href="https://curl.qcloud.com/jfCxxg9s" target="_blank">购买地址</a>（对于个人项目是足够的，性价比很高）
    - 选购时，可以找找优惠活动，新人首年一般会便宜很多
    - 购买进行配置时，服务器系统可以选择 ***基于操作系统镜像*** -> **OpenCloudOS9**（是腾讯云基于 CentOS Stream 9 优化的系统）
    - 作者 轻量应用服务器 的配置：上海，2核，2G，300GB（4Mbps，500KB/s），¥ 200/年 左右

#### 1.1.2 域名

- 域名：<a href="https://curl.qcloud.com/5kOAb9KX" target="_blank">购买地址</a>
    - 域名购买后，记得**完成实名认证**，不然无法使用
    - 完成实名认证的域名，后续才能进行 ICP备案
    - 作者购买的是 .com 域名，¥ 100/年 左右

#### 1.1.3 免费 DNS 服务

- DNS 管理台：<a href="https://console.cloud.tencent.com/cns" target="_blank">`https://console.cloud.tencent.com/cns`</a>

#### 1.1.4 免费 SSL 证书

- 免费 SSL 证书：<a href="https://console.cloud.tencent.com/ssl" target="_blank">`https://console.cloud.tencent.com/ssl`</a>
    - 申请时可以勾选 自动DNS验证，节约时间
    - 免费 SSL 证书有效期只有 90 天，到期需要自己手动更新


### 1.2 本地登录云服务器

- XShell、Xftp：
    - XShell：服务器远程登录
    - Xftp：服务器文件管理
    - 家庭/学校免费版下载地址：<a href="https://www.xshell.com/zh/free-for-home-school" target="_blank">https://www.xshell.com/zh/free-for-home-school</a>

### 1.3 DNS 配置

> 腾讯云 DNS 管理台，可以一键配置。

### 1.4 SSL 配置

> 下载好相关域名的 nginx 证书，在云服务器搭建 nginx 服务，在 nginx 配置里设置好 证书路径，可参考 <a href="https://templechann.com/post/nginx-manual" target="_blank">《Nginx 使用手册》</a>。

### 1.5 服务器域名备案

- ICP备案：
    - 地址：<a href="https://console.cloud.tencent.com/beian" target="_blank">`https://console.cloud.tencent.com/beian`</a>
    - 教程：<a href="https://cloud.tencent.com/document/product/243/18909" target="_blank">`https://cloud.tencent.com/document/product/243/18909`</a>
- 公安备案：
    - 地址：<a href="https://beian.mps.gov.cn/web/dashboard/home" target="_blank">`https://beian.mps.gov.cn/web/dashboard/home`</a>
    - 教程：<a href="https://cloud.tencent.com/document/product/243/19142" target="_blank">`https://cloud.tencent.com/document/product/243/19142`</a>