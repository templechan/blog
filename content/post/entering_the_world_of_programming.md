---
layout: single-no-catalog
title: "走进程序的世界"
description: "本文以知识网络的方式，带你探索编程的奥秘，从基础概念到实践应用，希望能为初学者打开一扇通往代码世界的大门。"
author: "谌中钱"
date: "2025-01-14"
image: "/img/temple_404_bg.jpg"
categories: [ "solutions" ]
tags:
  - "solutions"
weight: 1
ogurl: "https://blog.climbtw.com/post/entering_the_world_of_programming/"
---

<br />

> 在这个数字化的时代，程序已成为连接现实与虚拟的桥梁。本文以知识网络的方式，带你探索编程的奥秘，从基础概念到实践应用，希望能为初学者打开一扇通往代码世界的大门。让我们一起启程，发现程序的无限可能。 —— AI · 序

<style>
.svg-container {
    width: 100%;
    overflow-x: auto;
    text-align: center;
    border: 1px solid #eee;
    margin-top: 40px;
    padding-top: 10px;
}
.svg-content {
    min-width: 1230px;  /* 不小于 SVG 原始宽度 */
    height: 910px;  /* SVG 原始高度 */
}
</style>

<div class="svg-container">
    <object
        data="/svg/entering_the_world_of_programming_mindmap.svg"
        type="image/svg+xml"
        class="svg-content">
    </object>
</div>

<!-- # <a href="https://blog.climbtw.com/post/entering_the_world_of_programming/" target="_blank">《走进程序的世界》</a>

## 初始装备

- 硬件
    - 电脑
        - Windows
            - 机械革命无界14 Pro 2023 锐龙版 (R7 7840HS/32GB/1TB/集显)：**¥ 4000 左右** (本人使用)
                - 详细参数: <a href="https://detail.zol.com.cn/notebook/index2106547.shtml" target="_blank">中关村在线</a>
                - 官网驱动: <a href="https://www.mechrevo.com/service/" target="_blank">驱动下载</a>
        - Mac
    - 网络
        - Wi-Fi
            - <a href="https://blog.climbtw.com/post/vpn_manual/" target="_blank">《梯子使用手册》</a>：**¥ 10/月 左右**
        - 宽带
- 软件
    - 操作系统
        - Window 11
            - <a href="https://blog.climbtw.com/post/windows_system_reinstallation_manual/" target="_blank">《Windows 系统重装手册》</a>：永久激活码 **¥ 10 左右**
        - macOS
        - Linux
            - CentOS 9
                - <a href="https://blog.climbtw.com/post/cloud_server_manual/" target="_blank">《云服务器购买和使用手册》</a>: 服务器 + 域名 - **¥ 300/年 左右**
                - <a href="https://blog.climbtw.com/post/centos_9_manual/" target="_blank">《CentOS 9 命令使用手册》</a>
    - 浏览器
        - Google Chrome (主流)
            - <a href="https://www.google.cn/intl/zh-CN/chrome" target="_blank">下载地址</a>
        - Apple Safari (macOS 自带)
        - Microsoft Edge (Window 11 自带)
    - 代码编辑器
        - <a href="https://blog.climbtw.com/post/vscode_manual/" target="_blank">《Visual Studio Code 使用手册》</a>
            - <a href="https://code.visualstudio.com" target="_blank">下载地址</a>
        - <a href="https://blog.climbtw.com/post/markdown_manual/" target="_blank">《Markdown 使用手册》</a>

## UI/UX (设计)

- 工具
    - <a href="https://blog.climbtw.com/post/mastergo_manual/" target="_blank">《MasterGo 使用手册》</a>
        - 蓝湖
        - iconfont

## 界面开发（前端）

- 基础知识
    - <a href="https://blog.climbtw.com/post/html_manual/" target="_blank">《HTML 使用手册》</a>
    - <a href="https://blog.climbtw.com/post/css_manual/" target="_blank">《CSS 使用手册》</a>
    - <a href="https://blog.climbtw.com/post/js_manual/" target="_blank">《JavaScript 使用手册》</a>
        - TypeScript
- 框架工具
    - React 技术栈
        - Web平台 (SPA, H5)
            - <a href="https://blog.climbtw.com/post/react_manual/" target="_blank">《React 使用手册》</a>
                - Umi
            - <a href="https://blog.climbtw.com/post/next_manual/" target="_blank">《Next 使用手册》</a>
        - 移动平台 (H5 APP)
            - Android, iOS, 小程序
                - <a href="https://blog.climbtw.com/post/taro_manual/" target="_blank">《Taro 使用手册》</a>
                - <a href="https://blog.climbtw.com/post/rn_manual/" target="_blank">《React Native 使用手册》</a>
    - Vue 技术栈
        - Web平台 (SPA, H5)
            - <a href="https://blog.climbtw.com/post/vue_manual/" target="_blank">《Vue 使用手册》</a>
            - <a href="https://blog.climbtw.com/post/nuxt_manual/" target="_blank">《Nuxt 使用手册》</a>
        - 移动平台 (H5 APP)
            - Android, iOS, 小程序
                - <a href="https://blog.climbtw.com/post/uniapp_manual/" target="_blank">《uni-app 使用手册》</a>
                - <a href="https://blog.climbtw.com/post/weex_manual/" target="_blank">《Weex 使用手册》</a>
    - 微前端架构
        - <a href="https://blog.climbtw.com/post/qiankun_manual/" target="_blank">《qiankun 使用手册》</a>

## 数据开发（后端）

- 框架工具
    - Next API 路由
    - Node 技术栈
        - <a href="https://blog.climbtw.com/post/node_manual/" target="_blank">《Node 使用手册》</a>
            - Koa
        - <a href="https://blog.climbtw.com/post/nest_manual/" target="_blank">《Nest 使用手册》</a>
    - 微服务架构
        - Nest 微服务模块
- 数据库
    - PostgreSQL
        - 高一致性，适合复杂分析 (存储订单/用户核心数据 等)
    - MongoDB
        - 高吞吐量读写 (记录用户行为日志 等)
    - Redis
        - 微秒级响应 (处理秒杀库存/购物车缓存 等)
- 数据采集
    - 框架工具
        - <a href="https://blog.climbtw.com/post/scrapy_playwright_manual/" target="_blank">《Scrapy + Playwright 使用手册》</a>

## 程序上线（部署）

- 容器化部署
    - <a href="https://blog.climbtw.com/post/docker_manual/" target="_blank">《Docker 使用手册》</a>
    - <a href="https://blog.climbtw.com/post/nginx_manual/" target="_blank">《Nginx 使用手册》</a>
- CI/CD
    - <a href="https://blog.climbtw.com/post/git_manual/" target="_blank">《Git 使用手册》</a>
    - <a href="https://blog.climbtw.com/post/git_action_manual/" target="_blank">《GitHub Action 使用手册》</a>

## 拓展

- <a href="https://blog.climbtw.com/post/algorithm_research/" target="_blank">《算法研究》</a>
- <a href="https://blog.climbtw.com/post/ai_research/" target="_blank">《AI 研究》</a>
- <a href="https://blog.climbtw.com/post/web3_research/" target="_blank">《Web3 研究》</a>

## 解决方案

- <a href="https://blog.climbtw.com/post/building_a_blog_system/" target="_blank">《构建博客系统》</a>
- <a href="https://blog.climbtw.com/post/design_and_development_of_hrms/" target="_blank">《人资系统 HRMS 的设计和研发》</a>
- <a href="https://blog.climbtw.com/post/design_and_development_of_independent_station/" target="_blank">《电商独立站的设计和研发》</a>
- <a href="https://blog.climbtw.com/post/building_and using_ai_assisted_platforms/" target="_blank">《构建和使用AI辅助平台》</a> -->
