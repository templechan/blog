---
layout: post
title: "Blog 网站搭建"
description: "Hugo 静态网站框架的使用，部署 Twikoo 评论系统，静态资源 CDN，自动化部署，SEO 等。"
author: "谌中钱"
date: "2025-01-19"
image: "/img/temple-404-bg.png"
categories: [ "Solutions" ]
---

<br />
<br />

- [Hugo 静态网站框架](#hugo-静态网站框架)
  - [简介](#简介)
  - [搭建](#搭建)
    - [配置文件 hugo.toml 初始备份](#配置文件-hugotoml-初始备份)
    - [主题](#主题)
      - [hugo-theme-cleanwhite](#hugo-theme-cleanwhite)
        - [主题配置文件 hugo.toml 使用记录](#主题配置文件-hugotoml-使用记录)
    - [使用 Docker 搭建](#使用-docker-搭建)
      - [Dockerfile 文件](#dockerfile-文件)
      - [构建命令](#构建命令)
      - [评论系统 Twikoo 部署](#评论系统-twikoo-部署)
        - [云函数部署](#云函数部署)
          - [构建命令](#构建命令-1)
        - [hugo.toml 前端配置](#hugotoml-前端配置)
      - [静态资源 CDN](#静态资源-cdn)
      - [自动化部署](#自动化部署)
        - [在腾讯云服务器上生成SSH密钥](#在腾讯云服务器上生成ssh密钥)
        - [编写 GitHub Actions 工作流](#编写-github-actions-工作流)
        - [腾讯云服务器上的部署脚本](#腾讯云服务器上的部署脚本)
      - [SEO](#seo)
        - [搜索引擎收录](#搜索引擎收录)

# Hugo 静态网站框架

## 简介

> Hugo 是一个用 Go 编写的静态站点生成器，针对速度进行了优化，并专为灵活性而设计。

- 官网：<https://gohugo.io/>
  - 配置文档：<https://gohugo.io/getting-started/configuration/>

## 搭建

### 配置文件 hugo.toml 初始备份

```toml
baseURL = 'https://example.org/'
languageCode = 'en-us'
title = 'My New Hugo Site'
```

### 主题

#### hugo-theme-cleanwhite

- 主题地址：<https://themes.gohugo.io/themes/hugo-theme-cleanwhite/>
- 下载后存放到 ./themes 文件夹，后面进行挂载。
  - 如果有不合适的地方，可以自行调试修改内部文件。

##### 主题配置文件 hugo.toml 使用记录

```toml
baseURL = "https://blog.climbtw.com/"
# languageCode = "en-us"
languageCode = "zh-cn"
title = "Temple Blog"

theme = "hugo-theme-cleanwhite"

cleanDestinationDir = true
buildDrafts = true
buildFuture = true

hasCJKLanguage = true

[pagination]
  pagerSize = 5 # frontpage pagination

[markup]
  [markup.tableOfContents] 
    startLevel = 1 # 文章目录层级
    endLevel = 2
  [markup.highlight]
    style = "nord" # 代码块高亮，https://xyproto.github.io/splash/docs/all.html
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true # markdown 中使用 html

[[params.addtional_menus]]
title =  "READING"
href =  "/reading/"
[[params.addtional_menus]]
title =  "LIFE"
href =  "/life/"
[[params.addtional_menus]]
title =  "ARCHIVE"
href =  "/archive/"
[[params.addtional_menus]]
title =  "ABOUT"
href =  "/about/"

[params]
  header_image = "img/temple-home-bg.png"
  slogan = "山高自有客行路，水深自有渡船人"
  SEOTitle = "谌中钱的博客 | Temple Blog"
  description = ""
  keyword = ""

  image_404 = "img/temple-404-bg.png"
  title_404 = "页面不存在"

  upstreamAttribution = false # 显示主题作者信息
  omit_categories = false # 隐藏分类菜单

  # Sidebar settings
  sidebar_avatar = "img/temple.png"      # use absolute URL, seeing it's used in both `/` and `/about/`
  sidebar_about_description = "谌中钱（言戈，Temple Chan），男，汉族，中共团员，1996年1月14日出生于湖北省武汉市黄陂区，祖籍河南洛阳一带，始祖春秋时期郑国大夫裨谌。理学学士学位，主修物联网工程，中国内地不知名程序员，Coupang、腾讯、阿里高级搬砖人，爬界科技 创始人、首席执行官。"
  
  about_me = true
  bookmarks = true
  featured_tags = true 
  featured_condition_size = 0
  friends = true
  
  # Twikoo comments
  # Follow https://twikoo.js.org/ to set up your own env_id
  twikoo_env_id = "https://twikoo.climbtw.com/"



  # algolia site search
  algolia_search = false
  algolia_appId = ""
  algolia_indexName = ""
  algolia_apiKey = ""

  # Artalk comments
  # Follow https://artalk.js.org/ to set up your own server
  artalk_enable = false
  artalk_server = "https://xxx.xxx.com"
  artalk_site = "xxx blog"

  # We need a proxy to access Disqus api in China
  # Follow https://github.com/zhaohuabing/disqus-php-api to set up your own disqus proxy
  disqus_proxy = ""
  disqus_site = ""

  # leancloud storage for page view counter
  page_view_counter = false
  leancloud_app_id = ""
  leancloud_app_key = ""

  # Baidu Analytics
  ba_track_id = ""

  #Enable wechat pay & alipay to allow readers send reward money if they like the articles 
  reward = false 
  # reward_guide = "如果这篇文章对你有用,请随意打赏" 

  # Include any custom CSS and/or JS files, url or relative to /static folder
  #custom_css = ["css/lightbox.css", "https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css", "css/main.css"]
  #custom_js = ["js/lightbox.js", "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js", "js/main.js"]



  [params.social]
  rss            = true 
  # email          = "youremail@gmail.com"
  # facebook      = "full profile url in facebook"
  # googleplus    = "full profile url in googleplus"
  # twitter       = "full profile url in twitter"
  # linkedin       = "https://www.linkedin.com/in/yourlinkedinid"
  # stackoverflow  = "https://stackoverflow.com/users/yourstackoverflowid"
  # instagram     = "full profile url in instagram"
  # github         = "https://github.com/yourgithub"
  # wechat         = "your wechat qr code image"
  # medium        = "full profile url in medium"
  # slack         = "full workspace url in slack"
  # pinterest     = "full profile url in pinterest"
  # reddit        = "full profile url in reddit"
  # gitlab        = "full profile url in gitlab"
  # mastodon      = "full profile url in mastodon"
  # keybase       = "full profile url in keybase"
  # xing          = "https://www.xing.com/profile/yourxingid"
  # git           = "full profile url for git user"

  [[params.bookmark_link]]
  title =  "Martin Fowler"
  href =  "https://martinfowler.com"
  [[params.bookmark_link]]
  title = "ServiceMesher"
  href =  "http://www.servicemesher.com"
  [[params.bookmark_link]]
  title =  "Pxhere"
  href = "https://pxhere.com"
  [[params.bookmark_link]]
  title = "unsplash"
  href = "https://unsplash.com"

  [[params.friend_link]]
  title = "Linda的博客"
  href =  "https://zhaozhihan.com"

[services]
  # Enable comments by entering your Disqus shortname
  [services.disqus]
    shortname = ""
  [services.googleAnalytics]
    id = ""

[outputs]
# home = ["HTML", "RSS", "Algolia"]
home = ["HTML", "RSS"]

[outputFormats.Algolia]
baseName = "algolia"
isPlainText = true
mediaType = "application/json"
notAlternative = true

[params.algolia]
vars = ["title", "summary", "date", "publishdate", "expirydate", "permalink"]
params = ["categories", "tags"] 
```

### 使用 Docker 搭建

> Docker 是用来生成 网站构建结果，然后使用 Nginx 转发到 网站构建结果 `./public` 的地址 进行访问。

#### Dockerfile 文件

```dockerfile
FROM hugomods/hugo
RUN hugo new site blog
WORKDIR /blog
# 不适用于Docker部署
# CMD ["hugo", "server", "--bind", "0.0.0.0", "-b", "http://212.64.16.86", "-p", "81"] 
# 功能性容器
CMD ["hugo"]
```

#### 构建命令

准备好 **外部挂载** 文件和文件夹：

- `./themes`：主题文件夹
- `./hugo.toml`：配置文件
- `./content`：md文件存放文件夹
- `./static`：静态资源文件夹
- `./public`：网站构建结果文件夹

```shell
# 构建镜像
docker build -t blog .

# 手动压缩图片资源（会覆盖源文件，注意保留源文件，同一个文件多次压缩会严重失真）
# 也可指定具体文件名压缩
dnf install -y ImageMagick
mogrify -resize 20% -quality 70 ./static/img/*.{png}

# 创建并运行容器
# 不适用于Docker部署
# docker run -d --restart=always -p 80:81 -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static --name blog blog
# 功能性容器
docker run -d -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static -v ./public:/blog/public --name blog blog 
```

#### 评论系统 Twikoo 部署

- 官网：<https://twikoo.js.org/>

##### 云函数部署

###### 构建命令

```shell
# 拉取镜像
docker pull imaegoo/twikoo
# 创建并运行容器
docker run -d --restart=always -p 82:8080 -e TWIKOO_THROTTLE=1000  -v ./data:/app/data --name twikoo imaegoo/twikoo
```

##### hugo.toml 前端配置

```toml
[params]
# Twikoo comments
# Follow https://twikoo.js.org/ to set up your own env_id
twikoo_env_id = "" # 云函数部署的地址
```

#### 静态资源 CDN

> 目前图片采用命令压缩，CDN 需要时再研究。

#### 自动化部署

##### 在腾讯云服务器上生成SSH密钥

```shell
# 在云服务器上生成私钥和公钥
ssh-keygen -t rsa -b 4096 -C "templechan@126.com"
# 将公钥（id_rsa.pub）添加到云服务器的 ~/.ssh/authorized_keys 文件中
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# 查看私钥
cat ~/.ssh/id_rsa
# 将私钥（id_rsa）内容添加到 GitHub Actions 的 Secrets 中
# 在 GitHub 仓库的 Settings -> Secrets -> Actions -> New repository secret 中添加：
# Name: CTW_SSH_PRIVATE_KEY
# Value: 你的私钥内容（注意不要添加换行符，可以直接从文件复制）
```

##### 编写 GitHub Actions 工作流

去Github的自己仓库点击Actions，新建一个workflow工作流，会自动创建 `.github/workflows/deploy.yml`，进行编写：

```yaml
name: Deploy to Server

on:
  push:
    branches:
      - main
 
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v2
 
    - name: Install SSH key
      uses: webfactory/ssh-agent@v0.5.3
      with:
        ssh-private-key: ${{ secrets.CTW_SSH_PRIVATE_KEY }}
 
    - name: Adding Known Hosts
      run: ssh-keyscan ${{ secrets.CTW_SERVER_IP }} >> ~/.ssh/known_hosts
 
    - name: Deploy to Server
      run: ssh ${{ secrets.CTW_USER }}@${{ secrets.CTW_SERVER_IP }} 'bash -s' < /usr/local/src/blog/deploy.sh
```

##### 腾讯云服务器上的部署脚本

`/usr/local/src/blog/deploy.sh`

```shell
cd /usr/local/src
rm -rf /usr/local/src/blog
dnf install -y git
git config --global user.email "templechan@126.com"
git config --global user.name "templechan"
# 使用 ssh 克隆会快一些
git clone -b main git@github.com:templechan/blog.git

cd /usr/local/src/blog
# 手动压缩图片资源（会覆盖源文件，注意保留源文件，同一个文件多次压缩会严重失真）
# 也可指定具体文件名压缩
dnf install -y ImageMagick
mogrify -resize 20% -quality 70 ./static/img/*.{png}

# 删除容器
docker stop blog && docker rm blog
# 删除镜像
docker rmi blog
# 构建镜像
docker build -t blog .
# 创建并运行容器
# 不适用于Docker部署
# docker run -d --restart=always -p 80:81 -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static --name blog blog
# 功能性容器
docker run -d -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static -v ./public:/blog/public --name blog blog 

# Nginx 如果配置好了，可直接访问网站查看部署更新
```

#### SEO

##### 搜索引擎收录

- 百度收录官网：<https://ziyuan.baidu.com/linksubmit/index>
- 必应收录官网：<https://www.bing.com/webmasters/sitemaps>
- 谷歌收录官网：<https://search.google.com/search-console/sitemaps>
