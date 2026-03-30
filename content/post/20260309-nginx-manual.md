---
layout: post
title: Nginx 使用手册
subtitle: 
description: 涉及 Nginx 安装，常用配置 等。
author: 谌中钱
date: 2026-03-09
lastMod: 
image: img/post-bg-default.png
categories: 
- programming
tags: 
- 部署
slug: nginx-manual
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 简介](#1-简介)
- [2 安装](#2-安装)
  - [2.1 CentOS 9 环境](#21-centos-9-环境)
    - [2.1.1 Docker 方式](#211-docker-方式)
      - [2.1.1.1 挂载配置文件](#2111-挂载配置文件)
      - [2.1.1.2 容器构建文件](#2112-容器构建文件)

<!-- /code_chunk_output -->


## 1 简介

> Nginx 是一个 HTTP Web 服务器、反向代理、 内容缓存、负载均衡器、 TCP/UDP 代理服务器、 和邮件代理服务器。

- Nginx 官网: <a href="https://nginx.org" target="_blank">`https://nginx.org`</a>

## 2 安装

### 2.1 CentOS 9 环境

#### 2.1.1 Docker 方式

- 环境依赖：
    - Docker 安装：参考 <a href="https://templechann.com/post/docker-manual" target="_blank">《Docker 使用手册》</a>
    - 进入云服务器终端：参考 <a href="https://templechann.com/post/cloud-server-manual" target="_blank">《云服务器购买和使用手册》</a>
    - ./conf/nginx.conf：挂载配置文件
    - ./conf/certs：存放 SSH 证书
    - ./docker-compose.yml：容器构建文件

```shell
# 1 创建文件夹，用来存放 外部挂载文件
mkdir -p /usr/local/src/nginx/conf/certs
mkdir -p /usr/local/src/nginx/logs
mkdir -p /usr/local/src/nginx/html
cd /usr/local/src/nginx



# 2 准备挂载文件
# 创建挂载配置文件 ./conf/nginx.conf
# SSH证书存放到   ./conf/certs
# 创建容器构建文件 ./docker-compose.yml



# 3 创建启动容器
docker compose up -d
```

##### 2.1.1.1 挂载配置文件

`./conf/nginx.conf：`

```nginx
worker_processes  1;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;

    keepalive_timeout  65;
    
    proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=my_cache:100m inactive=60m max_size=1g use_temp_path=off;

    # 开启gzip
    gzip  on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml;
    gzip_min_length 1024; # 设置最小压缩数据大小，小于该值的数据将不进行压缩
    gzip_comp_level 5; # 设置压缩级别，1 为最快压缩，9 为最高压缩率（建议设置为 4~6）

    gzip_buffers 16 8k; # 设置用于存储压缩数据的缓冲区数量和大小
    gzip_http_version 1.1; # 仅对支持 HTTP/1.1 或更高版本的客户端启用 Gzip 压缩
    gzip_vary on; # 启用 Vary 响应头，告知缓存代理服务器对不同编码方式进行缓存分离处理
    gzip_static on; # 启用对预生成 .gz 文件的直接传输支持，减少服务器实时压缩负担
    gzip_disable "msie6"; # 禁用对特定客户端（如 IE6）的 Gzip 支持，避免兼容性问题
    gzip_proxied any; # 指定在代理场景下是否启用压缩（如 any 表示对所有请求启用压缩）
    

    upstream blog_server {
        ip_hash;
        server 172.17.0.1:81 max_fails=3 fail_timeout=30s;
        
        keepalive 32; # 保持连接数，减少每次请求的连接开销

        # max_fails 服务器失败的最大次数
        # fail_timeout 每台服务器失败的超时时间
    }
    
    upstream twikoo_server {
        ip_hash;
        server 172.17.0.1:82 max_fails=3 fail_timeout=30s;
        
        keepalive 32;
    }

    upstream ctw_server {
        ip_hash;
        server 172.17.0.1:90 max_fails=3 fail_timeout=30s;
        
        keepalive 32;
    }

    server {
        listen 80;
        server_name templechann.com www.templechann.com climbtw.com www.climbtw.com;
        # rewrite ^(.*)$ https://$server_name$1 permanent; # permanent，301 永久重定向，更新 url
        return 301 https://$server_name$request_uri; # 重定向使用 return 效率更高
    }

    # 通过 ip 访问的话，优先匹配 显式标记为 default_server 的 server，如果没有则 使用第一个 server
    # 这里设置下，通过 ip 访问的话，跳到博客容器
    server {
        listen 80 default_server;
        server_name _;
        # rewrite ^(.*)$ https://$server_name$1 permanent; # permanent，301 永久重定向，更新 url
        return 301 https://templechann.com$request_uri; # 重定向使用 return 效率更高
    }
    
    server {
        listen       443 ssl;
        server_name  templechann.com www.templechann.com;

        ssl_certificate      /etc/nginx/certs/templechann.com_bundle.pem;
        ssl_certificate_key  /etc/nginx/certs/templechann.com.key;

        ssl_session_cache    shared:SSL:1m;
        
        ssl_session_timeout  5m;
        # 请按照以下协议配置
        ssl_protocols TLSv1.2 TLSv1.3; 
        # 请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; 
        ssl_prefer_server_ciphers on;

        # 系统临时维护
        # rewrite ^(.*)$ /maintainace.html break; # break，地址栏 url 不变
        # location = /maintainace.html {
        #     root /usr/share/nginx/html;
        # }

        # location / {
        #     root   html;
        #     # try_files $uri $uri/ /index.html; # 解决单页应用 history 路由 404 的问题
        #     index  index.html index.htm;
        # }

        # 反向代理
        location / {
            proxy_pass http://blog_server;
            
            proxy_cache my_cache;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        # error_page 500 502 503 504 /50x.html;
        # location = /50x.html {
        #     root /usr/share/nginx/html;
        # }

        # error_page 404 /404.html;
        # location = /404.html {
        #     root /usr/share/nginx/html;
        # }
    }

    server {
        listen       443 ssl;
        server_name  xxx.templechann.com;

        ssl_certificate      /etc/nginx/certs/xxx.templechann.com_bundle.pem;
        ssl_certificate_key  /etc/nginx/certs/xxx.templechann.com.key;

        ssl_session_cache    shared:SSL:1m;
        
        ssl_session_timeout  5m;
        # 请按照以下协议配置
        ssl_protocols TLSv1.2 TLSv1.3; 
        # 请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; 
        ssl_prefer_server_ciphers on;

        # 系统临时维护
        # rewrite ^(.*)$ /maintainace.html break; # break，地址栏 url 不变
        # location = /maintainace.html {
        #     root /usr/share/nginx/html;
        # }

        # 反向代理
        location / {
            proxy_pass http://twikoo_server;
            
            proxy_cache my_cache;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        # error_page 500 502 503 504 /50x.html;
        # location = /50x.html {
        #     root /usr/share/nginx/html;
        # }
    }

    server {
        listen       443 ssl;
        server_name  climbtw.com www.climbtw.com;

        ssl_certificate      /etc/nginx/certs/climbtw.com_bundle.pem;
        ssl_certificate_key  /etc/nginx/certs/climbtw.com.key;

        ssl_session_cache    shared:SSL:1m;
        
        ssl_session_timeout  5m;
        #请按照以下协议配置
        ssl_protocols TLSv1.2 TLSv1.3; 
        #请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; 
        ssl_prefer_server_ciphers on;

        # 系统临时维护
        rewrite ^(.*)$ /maintainace.html break; # break，地址栏 url 不变
        location = /maintainace.html {
            root /usr/share/nginx/html;
        }

        # 反向代理
        location / {
            proxy_pass http://ctw_server;
            
            proxy_cache my_cache;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        # error_page   500 502 503 504  /50x.html;
        # location = /50x.html {
        #     root  /usr/share/nginx/html;
        # }
    }
}
```
##### 2.1.1.2 容器构建文件

`./docker-compose.yml：`

```yml
version: '3'

services:
  nginx:
    image: nginx:alpine-slim
    container_name: nginx
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      # 配置文件挂载
      - ./conf/nginx.conf:/etc/nginx/nginx.conf
      # SSL 证书
      - ./conf/certs:/etc/nginx/certs
      # 日志
      - ./logs:/var/log/nginx
      # 网站根目录（把你的静态网站放这里）
      - ./html:/usr/share/nginx/html
    # 解决 alpine 权限 403 问题
    user: root

    # 可选：加入时区，保证日志时间正确
    environment:
      - TZ=Asia/Shanghai
```
