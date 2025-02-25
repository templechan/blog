---
layout: post
title: "Nginx 使用记录"
description: "Nginx 安装，配置。"
author: "谌中钱"
date: "2025-01-18"
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
      - [准备配置文件](#准备配置文件)
        - [nginx.conf 初始备份](#nginxconf-初始备份)
        - [nginx.conf 使用记录](#nginxconf-使用记录)
      - [使用 Docker 搭建](#使用-docker-搭建)
        - [Dockerfile 文件](#dockerfile-文件)
        - [构建命令](#构建命令)
- [常用命令](#常用命令)

# 简介安装

## 简介

> Nginx 是一个 HTTP Web 服务器、反向代理、 内容缓存、负载均衡器、 TCP/UDP 代理服务器、 和邮件代理服务器。

- 官网：<https://nginx.org/>

## 安装

### CentOS 9

#### 准备配置文件

##### nginx.conf 初始备份

```nginx

#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}

}
```

##### nginx.conf 使用记录

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
    

    # upstream blog_server {
    #     ip_hash;
    #     server 172.17.0.1:81 max_fails=3 fail_timeout=30s;
        
    #     keepalive 32; # 保持连接数，减少每次请求的连接开销

    #     # max_fails 服务器失败的最大次数
    #     # fail_timeout 每台服务器失败的超时时间
    # }
    
    upstream twikoo_server {
        ip_hash;
        server 172.17.0.1:82 max_fails=3 fail_timeout=30s;
        
        keepalive 32; # 保持连接数，减少每次请求的连接开销
    }

    server {
        listen 80;
        server_name blog.climbtw.com climbtw.com www.climbtw.com;
        # rewrite ^(.*)$ https://$server_name$1 permanent; # permanent，301 永久重定向，更新 url
        return 301 https://$server_name$request_uri; # 重定向使用 return 效率更高
    }
    
    server {
        listen       443 ssl;
        server_name  blog.climbtw.com;

        ssl_certificate      /etc/nginx/certs/blog.climbtw.com_bundle.pem;
        ssl_certificate_key  /etc/nginx/certs/blog.climbtw.com.key;

        ssl_session_cache    shared:SSL:1m;
        
        ssl_session_timeout  5m;
        #请按照以下协议配置
        ssl_protocols TLSv1.2 TLSv1.3; 
        #请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; 
        ssl_prefer_server_ciphers on;

        # 系统临时维护
        # rewrite ^(.*)$ /maintainace.html break; # break，地址栏 url 不变
        # location = /maintainace.html {
        #     root /etc/nginx/html/nginx/html;
        # }

        location / {
            root   /etc/nginx/html/blog/public;
            # try_files $uri $uri/ /index.html; # 解决单页应用history路由404的问题
            index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /etc/nginx/html/nginx/html;
        }

        error_page   404  /404.html;
        location = /404.html {
            root   /etc/nginx/html/blog/public;
        }

        # # 反向代理：解决跨域问题，动静分离
        # location /api/ {
        #     proxy_pass http://blog_server;
            
        #     proxy_cache my_cache;
        #     proxy_set_header Host $host;
        #     proxy_set_header X-Real-IP $remote_addr;
        #     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        #     proxy_set_header X-Forwarded-Proto $scheme;
        # }
    }

    server {
        listen       443 ssl;
        server_name  twikoo.climbtw.com;

        ssl_certificate      /etc/nginx/certs/twikoo.climbtw.com_bundle.pem;
        ssl_certificate_key  /etc/nginx/certs/twikoo.climbtw.com.key;

        ssl_session_cache    shared:SSL:1m;
        
        ssl_session_timeout  5m;
        #请按照以下协议配置
        ssl_protocols TLSv1.2 TLSv1.3; 
        #请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; 
        ssl_prefer_server_ciphers on;

        # 系统临时维护
        # rewrite ^(.*)$ /maintainace.html break; # break，地址栏 url 不变
        # location = /maintainace.html {
        #     root /etc/nginx/html/nginx/html;
        # }

        # # 反向代理：解决跨域问题，动静分离
        location / {
            proxy_pass http://twikoo_server;
            
            proxy_cache my_cache;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
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
        # rewrite ^(.*)$ /maintainace.html break; # break，地址栏 url 不变
        # location = /maintainace.html {
        #     root /etc/nginx/html/nginx/html;
        # }

        location / {
            root   /etc/nginx/html/climbtw;
            index  index.html index.htm;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /etc/nginx/html/nginx/html;
        }
    }
}
```

#### 使用 Docker 搭建

##### Dockerfile 文件

> 无需，直接使用官方镜像 nginx。

##### 构建命令

准备好 **外部挂载** 文件和文件夹：

- `./conf/nginx.conf`：配置文件
- `/usr/local/src`：项目仓库文件夹
- `./logs`：日志文件夹
- `./conf/certs`：SSL证书文件夹

```shell
# 拉取镜像
docker pull nginx
# 创建并运行容器
docker run -d --restart=always -p 80:80 -p 443:443 -v ./conf/nginx.conf:/etc/nginx/nginx.conf -v /usr/local/src:/etc/nginx/html -v ./logs:/var/log/nginx -v ./conf/certs:/etc/nginx/certs --name nginx nginx
```

# 常用命令

> 使用 Docker 容器搭建，如果需要重启，直接重启容器即可，Nginx 的常用命令需要时再补充。

```shell

```
