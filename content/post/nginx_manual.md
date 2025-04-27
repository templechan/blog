---
layout: single
title: "Nginx 使用手册"
description: "-"
author: "谌中钱"
date: "2025-04-16"
image: "/img/temple_404_bg.jpg"
categories: [ "tech" ]
tags:
  - "engineering"
ogurl: "https://blog.climbtw.com/post/nginx_manual/"
---

<br />
<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [简介](#简介)
- [安装 Nginx](#安装-nginx)
  - [CentOS 9 下](#centos-9-下)
    - [Docker 方式安装](#docker-方式安装)
      - [外部挂载文件](#外部挂载文件)
        - [Nginx 配置文件](#nginx-配置文件)
          - [使用版本](#使用版本)
          - [初始化版本备份](#初始化版本备份)
        - [SSL 证书文件](#ssl-证书文件)
        - [系统维护页面文件](#系统维护页面文件)
        - [index页面文件 初始化版本备份](#index页面文件-初始化版本备份)
        - [50x页面文件 初始化版本备份](#50x页面文件-初始化版本备份)

<!-- /code_chunk_output -->

# 简介

> Nginx 是一个 HTTP Web 服务器、反向代理、 内容缓存、负载均衡器、 TCP/UDP 代理服务器、 和邮件代理服务器。

- Nginx 官网: <https://nginx.org/>

# 安装 Nginx

## CentOS 9 下

### Docker 方式安装

1. 安装 Docker
    - 参考 [《Docker 使用手册》](https://blog.climbtw.com/post/docker_manual/)
2. 进入云服务终端
    - 参考 [《云服务器购买和使用手册》](https://blog.climbtw.com/post/cloud_server_manual/)
3. 操作命令:

```shell
# 创建文件夹，用来存放 外部挂载文件
mkdir /usr/local/src/nginx && cd /usr/local/src/nginx

# 拉取 nginx 镜像
docker pull nginx:alpine-slim

# 把下面的需要 外部挂载 的文件，放到指定的 目录里: 
# ./conf/nginx.conf : 存放 Nginx 配置文件
# ./conf/certs : 存放 Nginx SSL 证书文件
# ./logs : 存放 Nginx 日志文件
# ../ : 存放 Nginx 项目源代码

# 创建并运行容器
docker run -d --restart=always -p 80:80 -p 443:443 \
-v ./conf/nginx.conf:/etc/nginx/nginx.conf \
-v ./conf/certs:/etc/nginx/certs \
-v ./logs:/var/log/nginx \
-v /usr/local/src:/etc/nginx/html \
--name nginx nginx:alpine-slim
```

#### 外部挂载文件

##### Nginx 配置文件

- 位置: /usr/local/src/conf/nginx.conf

###### 使用版本

nginx.conf

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

    server {
        listen 80;
        server_name blog.climbtw.com climbtw.com www.climbtw.com;
        # rewrite ^(.*)$ https://$server_name$1 permanent; # permanent，301 永久重定向，更新 url
        return 301 https://$server_name$request_uri; # 重定向使用 return 效率更高
    }

    # 通过 ip 访问的话，优先匹配 显式标记为 default_server 的 server，如果没有则 使用第一个 server
    # 这里设置下，通过 ip 访问的话，跳到博客容器
    server {
        listen 80 default_server;
        server_name blog.climbtw.com;
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
        # 请按照以下协议配置
        ssl_protocols TLSv1.2 TLSv1.3; 
        # 请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE; 
        ssl_prefer_server_ciphers on;

        # 系统临时维护
        # rewrite ^(.*)$ /maintainace.html break; # break，地址栏 url 不变
        # location = /maintainace.html {
        #     root /etc/nginx/html/nginx/html;
        # }

        # location / {
        #     root   /etc/nginx/html/blog/public;
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

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /etc/nginx/html/nginx/html;
        }

        # error_page 404 /404.html;
        # location = /404.html {
        #     root /etc/nginx/html/blog/public;
        # }
    }

    server {
        listen       443 ssl;
        server_name  twikoo.climbtw.com;

        ssl_certificate      /etc/nginx/certs/twikoo.climbtw.com_bundle.pem;
        ssl_certificate_key  /etc/nginx/certs/twikoo.climbtw.com.key;

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
        #     root /etc/nginx/html/nginx/html;
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

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root /etc/nginx/html/nginx/html;
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

###### 初始化版本备份

nginx.conf

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

##### SSL 证书文件

- 从 云服务商 获取:
    - 参考 [《云服务器购买和使用手册》](https://blog.climbtw.com/post/cloud_server_manual/)

##### 系统维护页面文件

- 位置: /usr/local/src/nginx/html/maintainace.html

maintainace.html

```html
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>系统维护</title>
</head>
<body>
    <h1>系统维护中</h1>
</body>
</html>
```

##### index页面文件 初始化版本备份

- 位置: /usr/local/src/nginx/html/index.html

index.html

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

```

##### 50x页面文件 初始化版本备份

- 位置: /usr/local/src/nginx/html/50x.html

50x.html

```html
<!DOCTYPE html>
<html>
<head>
<title>Error</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>An error occurred.</h1>
<p>Sorry, the page you are looking for is currently unavailable.<br/>
Please try again later.</p>
<p>If you are the system administrator of this resource then you should check
the error log for details.</p>
<p><em>Faithfully yours, nginx.</em></p>
</body>
</html>

```
