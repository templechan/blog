---
layout: post
title: 走进程序的世界
subtitle: 
description: 本文以知识网络的方式，带你探索编程的奥秘，从基础概念到实践应用，希望能为初学者打开一扇通往代码世界的大门。
author: 谌中钱
date: 2026-01-14
lastMod: 
image: img/post-bg-default.png
categories: 
- programming
tags: 
- 解决方案
slug: entering-the-world-of-programming
metadata:
- text: Temple's Blog
  link: https://templechann.com/
weight: 1
showtoc: false
draft: false
---

<br />


> 在这个数字化的时代，程序已成为连接现实与虚拟的桥梁。本文以知识网络的方式，带你探索编程的奥秘，从基础概念到实践应用，希望能为初学者打开一扇通往代码世界的大门。让我们一起启程，发现程序的无限可能。

<style>
.svg-container {
    width: 100%;
    overflow-x: auto;
    text-align: center;
    border: 1px solid #eee;
    margin-top: 40px;
    padding-bottom: 10px;
}
.svg-content {
    min-width: 1300px;  /* 不小于 SVG 原始宽度 */
    height: 900px;  /* SVG 原始高度 */
}
</style>

<div class="svg-container">
    <object
        data="/img/entering-the-world-of-programming-mindmap.svg"
        type="image/svg+xml"
        class="svg-content">
    </object>
</div>

<!-- # <a href="https://templechann.com/post/entering-the-world-of-programming/" target="_blank">《走进程序的世界》</a>

## 初始装备

- 硬件（本地开发）
    - 电脑
        - Windows
            - 机械革命 无界14Pro 2023锐龙版 （R7 7840HS/32GB/1TB/集显）：***¥ 4000 左右*** （本人使用）
                - 首发评测：<a href="https://www.bilibili.com/video/BV1uh4y1e75Y/?spm_id_from=333.337.search-card.all.click&vd_source=6f56a95f9efd1d49b01ec085d119a07a" target="_blank">B站 · 麦香牛奶Mitsu</a>
                - 详细参数：<a href="https://detail.zol.com.cn/2107/2106545/param.shtml" target="_blank">中关村在线</a>
                - 官网驱动：<a href="https://www.mechrevo.com/cn/downloads?serial=VbJS1V&display_product=wu-jie-14-pro&author=148" target="_blank">驱动下载</a>
        - MacBook
            - 推荐 MacBook Air，预算足够可上 MacBook Pro：¥ 9000 ~ 14000 左右
    - 网络
        - WiFi
- 软件
    - 操作系统
        - Window 11（本地开发）
            - <a href="https://templechann.com/post/windows-system-reinstallation-manual/" target="_blank">《Windows 系统重装手册》</a>：淘宝永久激活码 ***¥ 10 左右***
        - macOS（本地开发）
        - Linux（服务器端）
            - CentOS Stream 9 / OpenCloudOS 9（腾讯云）
                - <a href="https://templechann.com/post/cloud-server-manual/" target="_blank">《云服务器购买和使用手册》</a>：服务器 + 域名 = ***¥ 300/年 左右***
                - <a href="https://templechann.com/post/centos9-manual/" target="_blank">《CentOS Stream 9 命令使用手册》</a>
    - 网络
        - <a href="https://templechann.com/post/vpn-manual/" target="_blank">《梯子使用手册》</a>：***¥ 10/月 左右***
    - 浏览器
        - Google Chrome (主流)
            - <a href="https://www.google.cn/chrome/index.html" target="_blank">下载地址</a>（可能需要开启梯子访问）
        - Apple Safari (macOS 自带)
        - Microsoft Edge (Window 11 自带)
    - 代码编辑器
        - <a href="https://templechann.com/post/vscode-manual/" target="_blank">《Visual Studio Code 使用手册》</a>
            - <a href="https://code.visualstudio.com" target="_blank">下载地址</a>
        - <a href="https://templechann.com/post/markdown-manual/" target="_blank">《Markdown 使用手册》</a>

## UI/UX (设计)

- 平台
    - 蓝湖
        - 设计创作
            - MasterGo
        - 协作交付
            - 蓝湖
    - Figma（设计创作 + 协作交付）
- 工具库
    - iconfont

## 界面开发（前端）

- 基础知识
    - <a href="https://templechann.com/post/html-manual/" target="_blank">《HTML 使用手册》</a>
    - <a href="https://templechann.com/post/css-manual/" target="_blank">《CSS 使用手册》</a>
    - <a href="https://templechann.com/post/js-manual/" target="_blank">《JavaScript 使用手册》</a>
        - <a href="https://templechann.com/post/ts-manual/" target="_blank">《TypeScript 使用手册》</a>
- 框架工具
    - React
        - Web平台 (SPA，H5)
            - 客户端渲染
                - <a href="https://templechann.com/post/react-manual/" target="_blank">《React 使用手册》</a>
            - 服务端渲染
                - <a href="https://templechann.com/post/next-manual/" target="_blank">《Next 使用手册》</a>
        - 移动平台
            - 小程序（为主），APP（兼顾）
                - <a href="https://templechann.com/post/taro-manual/" target="_blank">《Taro 使用手册》</a>
            - APP（原生体验）
                - <a href="https://templechann.com/post/rn-manual/" target="_blank">《React Native 使用手册》</a>
    - Vue
        - Web平台 (SPA，H5)
            - 客户端渲染
                - Vue
            - 服务端渲染
                - Nuxt
        - 移动平台
            - 小程序（为主），APP（兼顾）
                - uni-app
    - 微前端
        - qiankun

## 数据开发（后端）

- API 框架
    - Next/Nuxt API 路由
    - Node 技术栈
        - <a href="https://templechann.com/post/express-manual/" target="_blank">《Express 使用手册》</a>
        - Nest
    - 微服务
        - Nest 微服务模块
- 数据库
    - PostgreSQL
        - 高一致性，适合复杂分析 (存储订单/用户核心数据 等)
    - MongoDB
        - 高吞吐量读写 (记录用户行为日志 等)
    - Redis
        - 微秒级响应 (处理秒杀库存/购物车缓存 等)
- 数据采集
    - <a href="https://templechann.com/post/scrapy-playwright-manual/" target="_blank">《Scrapy + Playwright 爬虫使用手册》</a>

## 程序上线（部署）

- 容器化部署
    - <a href="https://templechann.com/post/docker-manual/" target="_blank">《Docker 使用手册》</a>
    - <a href="https://templechann.com/post/nginx-manual/" target="_blank">《Nginx 使用手册》</a>
- CI/CD
    - <a href="https://templechann.com/post/git-manual/" target="_blank">《Git 使用手册》</a>
    - <a href="https://templechann.com/post/github-actions-manual/" target="_blank">《GitHub Actions 使用手册》</a>

## 拓展

- <a href="https://templechann.com/post/algorithm-research/" target="_blank">《算法研究》</a>

## 解决方案

- <a href="https://templechann.com/post/building-blog-site/" target="_blank">《构建博客网站》</a>
- <a href="https://templechann.com/post/building-knowledge-base-qa-system/" target="_blank">《构建知识库问答RAG系统》</a> -->