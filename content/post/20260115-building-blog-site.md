---
layout: post
title: 构建博客网站
subtitle: 
description: 涉及 Hugo 静态框架，自动化部署，评论服务，SEO 等。
author: 谌中钱
date: 2026-01-15
lastMod: 
image: img/post-bg-default.png
categories: 
- programming
tags: 
- 解决方案
slug: building-blog-site
metadata:
- text: Hugo
  link: https://gohugo.io
weight: 2
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 技术选型](#1-技术选型)
- [2 使用 Hugo 静态框架](#2-使用-hugo-静态框架)
  - [2.1 本地化开发](#21-本地化开发)
    - [2.1.1 Window 11 环境](#211-window-11-环境)
    - [2.1.2 macOS 环境](#212-macos-环境)
  - [2.2 目录结构](#22-目录结构)
  - [2.3 项目配置](#23-项目配置)
    - [2.3.1 配置文件](#231-配置文件)
    - [2.3.2 内容元数据配置](#232-内容元数据配置)
    - [2.3.3 命令新建文章模板](#233-命令新建文章模板)
  - [2.4 自动化部署](#24-自动化部署)
    - [2.4.1 云服务器 SSH 配置](#241-云服务器-ssh-配置)
    - [2.4.2 编写脚本](#242-编写脚本)
      - [2.4.2.1 工作流文件](#2421-工作流文件)
      - [2.4.2.2 部署脚本](#2422-部署脚本)
      - [2.4.2.3 镜像构建文件](#2423-镜像构建文件)
      - [2.4.2.4 容器构建启动文件](#2424-容器构建启动文件)
  - [2.5 评论服务](#25-评论服务)
  - [2.6 SEO](#26-seo)

<!-- /code_chunk_output -->


## 1 技术选型

> 由于博客网站主要用来记录博主的文章和日常，这里选择使用静态框架 Hugo 进行搭建, 访问速度更快, 维护成本更低。

- 静态框架：Hugo
  - 框架主题：Clean White
- 部署方式：Docker + Nginx + GitHub Actions

## 2 使用 Hugo 静态框架

> Hugo 是最受欢迎的开源静态网站生成器之一。凭借其惊人的速度和灵活性，Hugo 让搭建网站重新变得有趣。

- Hugo 官网：<a href="https://gohugo.io" target="_blank">`https://gohugo.io`</a>
- Hugo 主题仓库：<a href="https://themes.gohugo.io" target="_blank">`https://themes.gohugo.io`</a>
  - Clean White 主题：<a href="https://themes.gohugo.io/themes/hugo-theme-cleanwhite" target="_blank">`https://themes.gohugo.io/themes/hugo-theme-cleanwhite`</a>
- Hugo 配置文档：<a href="https://gohugo.io/documentation" target="_blank">`https://gohugo.io/documentation`</a>
  - 快速开始：<a href="https://gohugo.io/getting-started/quick-start" target="_blank">`https://gohugo.io/getting-started/quick-start`</a>
  - 命令文档：<a href="https://gohugo.io/commands/hugo" target="_blank">`https://gohugo.io/commands/hugo`</a>
  - 目录结构：<a href="https://gohugo.io/getting-started/directory-structure" target="_blank">`https://gohugo.io/getting-started/directory-structure`</a>
    - 布局模板：<a href="https://gohugo.io/templates" target="_blank">`https://gohugo.io/templates`</a>
  - 项目配置：<a href="https://gohugo.io/configuration" target="_blank">`https://gohugo.io/configuration`</a>
    - 内容元数据配置：<a href="https://gohugo.io/content-management/front-matter" target="_blank">`https://gohugo.io/content-management/front-matter`</a>

### 2.1 本地化开发

#### 2.1.1 Window 11 环境

- 环境依赖：
  - 访问 GitHub 可能需要梯子：参考 <a href="https://templechann.com/post/vpn-manual" target="_blank">《梯子使用手册》</a>
  - Git：参考 <a href="https://templechann.com/post/git-manual" target="_blank">《Git 使用手册》</a>

```shell
# 1 安装 Hugo

# 查询本地是否已经安装
winget list | findstr Hugo
# Hugo   Hugo.Hugo   0.153.0   0.159.0   winget

# 搜索远程仓库 Hugo 最新版本
winget search Hugo
# Name            Id                    Version  Match         Source
# -------------------------------------------------------------------
# Hugo            Hugo.Hugo             0.159.0                winget
# Hugo (Deploy)   Hugo.Hugo.Deploy      0.150.0  Command: hugo winget
# Hugo (Extended) Hugo.Hugo.Extended    0.159.0                winget
# 希沃集控        Seewo.SeewoHugo       1.4.5.57               winget
# 掌上看班        Seewo.SeewoHugoKanban 1.4.5.68               winget

# 安装/更新指定版本 Hugo
winget install --id Hugo.Hugo --version 0.159.0

# 查询认证一下
winget list | findstr Hugo
# Hugo   Hugo.Hugo   0.159.0   winget
hugo version
# hugo v0.159.0-2ed7d193cfdfcf11808fb2a921a9429423b0ebe9 windows/amd64 BuildDate=2026-03-23T18:16:59Z VendorInfo=gohugoio



# 2 使用 Hugo 创建站点

# 创建站点
hugo new project D:\dev\workspace\blog && cd /d D:\dev\workspace\blog

# 下载主题 hugo-theme-cleanwhite
git clone --depth 1 https://github.com/zhaohuabing/hugo-theme-cleanwhite.git themes/hugo-theme-cleanwhite
# 删除主题 git 相关信息
cd themes\hugo-theme-cleanwhite && rd /s /q .git & del /f /q .gitignore
# 修改站点主题为 hugo-theme-cleanwhite
cd ..\.. && echo theme = 'hugo-theme-cleanwhite' >> hugo.toml



# 3 启动站点的服务器测试模式
# --bind 0.0.0.0 是为了监听 IPv4 所有网络地址，让 手机 等设备可以通过 局域网 (同一 WiFi 下) 访问 电脑 的站点，进行移动端测试
hugo server --bind 0.0.0.0
```

#### 2.1.2 macOS 环境

- 官方教程：<a href="https://gohugo.io/installation/macos" target="_blank">`https://gohugo.io/installation/macos`</a>

### 2.2 目录结构

- **archetypes**：存放新内容的模板（优先级高于主题的模版）
  - default.md：命令新建 新内容 的默认模板（`hugo new test.md`）
  - post.md：命令新建 文章 的模板（`hugo new post/20260115-building-blog-site.md`）
- assets：存放需要 Hugo 处理压缩的文件，需要通过代码管道调用
- **content**：存放构成网站内容的文章、页面等文件（可 手动 或 命令 创建）
  - post：存放文章文件
  - 其他目录：存放页面文件
- data：存放数据文件
- i18n：存放多语言网站的翻译表
- **layouts**：存放新内容的各种布局模板（优先级高于主题的模版，主题二次开发的文件一般放这里）
  - baseof.html：所有内容基础结构模板
    - _partials
      - head.html：元数据、脚本等信息模版
      - nav.html：头部导航模板
      - footer.html：尾部信息模板
  - home.html：首页模板
    - _partials：
      - portfolio.html：首页内容容器模板
        - posts.html：文章列表容器模板
          - post_list.html：文章列表模板
          - pagination.html：文章分页模板
          - sidebar.html：右侧信息模板
  - post.html：文章内容模板
    - _partials：
      - reward.html：赞赏模板
      - comments.html：评论模板
  - taxonomy：
    - category.html：分类页面模板
    - tag.html：标签页面模板
    - _partials：
      - category.html：分类，标签列表模板
      - posts.html：文章列表容器模板
        - post_list.html：文章列表模板
        - pagination.html：文章分页模板
        - sidebar.html：右侧信息模板
  - archive.html：归档模板
    - _partials：
      - sidebar.html：右侧信息模板
  - about.html：关于我模板
    - _partials：
      - comments.html：评论模板
      - sidebar.html：右侧信息模板
  - search/list.html：搜索结果模板
    - _partials：
      - search-algolia.html：Algolia 搜索结果模板
      - search-pagefind.html：Pagefind 搜索结果模板
      - sidebar.html：右侧信息模板
- **public**：存放项目构建结果文件
- **static**：存放项目构建时将被复制到 public 目录的静态文件
  - img：存放图片资源
- **theme**：存放主题文件
  - hugo-theme-cleanwhite
    - exampleSite：主题作者提供的参考站点，可以参考配置
- **hugo.toml**：项目配置文件

### 2.3 项目配置

#### 2.3.1 配置文件

- 作者配置 hugo.toml：

```toml
# 生产构建时，生成所有正式链接的唯一基础地址
# sitemap.xml（网站地图）、robots.txt（爬虫协议）、页面 canonical 标签 等 SEO 核心文件必依赖它
baseURL = 'https://templechann.com'
# locale = 'en-us'
locale = 'zh-cn'
title = 'Temple Blog'
theme = 'hugo-theme-cleanwhite'

buildFuture = true # 构建包含未来日期的文章
hasCJKLanguage = true # 自动处理中日韩文字，解决默认配置下的排版、摘要、字数统计 BUG
enableRobotsTXT = true # 自动在你的网站根目录生成 robots.txt 文件
cleanDestinationDir = true # 构建时清空历史文件

[markup]
  [markup.highlight]
    style = "nord" # 代码块高亮，https://xyproto.github.io/splash/docs/all.html
    lineNos = true # 显示行号
    lineNumbersInTable = false
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true # markdown 中使用 html
    [markup.goldmark.extensions]
      [markup.goldmark.extensions.passthrough]
        enable = true
        [markup.goldmark.extensions.passthrough.delimiters]
          block = [['\[', '\]'], ['$$', '$$']]
          inline = [['\(', '\)']]

[pagination]
  pagerSize = 10 # frontpage pagination

[mediaTypes]
  [mediaTypes.'font/woff']
    suffixes = ['woff']
  [mediaTypes.'font/woff2']
    suffixes = ['woff2']

[outputs]
# home = ["HTML", "RSS", "Algolia"]
home = ["HTML", "RSS"]

[services]
  # Enable comments by entering your Disqus shortname
  [services.disqus]
    shortname = ""
  [services.googleAnalytics]
    id = ""

[outputFormats.Algolia]
# baseName = "algolia"
# isPlainText = true
# mediaType = "application/json"
# notAlternative = true

[params]
  header_image = "img/home-bg.png"
  slogan = "山高自有客行路，水深自有渡船人"
  SEOTitle = "谌中钱的博客 | Temple Blog"
  description = "谌中钱（言戈，Temple Chan），男，29岁，179cm，65kg，摩羯座，ESTJ，汉族，中共团员，1996年1月14日出生于湖北省武汉市黄陂区，祖籍河南洛阳一带，始祖春秋时期郑国大夫裨谌。理学学士学位，主修计算机科学，中国内地不知名程序员，腾讯、Coupang、阿里云 前搬砖人，爬界科技 创始人、首席执行官。"
  keyword = "谌中钱, 言戈, 在下言戈, Temple Chan, Temple, templechan, templechann, templechannn, 谌中钱的博客, 博客网站, 博客, 编程技术"
  
  image_404 = "img/post-bg-404.png"
  title_404 = "你页面不存在"
  omit_categories = false # 隐藏分类菜单
  upstreamAttribution = false # 显示主题作者信息
  dark_mode_toggle = false # 是否开启暗黑模式
  isSearch = false # 是否显示搜索图标

  # 备案信息
  isBeian = true # 是否显示备案信息
  icp = "鄂ICP备2025165689号-1"
  gongan = "鄂公网安备42018502008405号"
  gongan_num = "42018502008405"
  
  # Sidebar settings
  sidebar_avatar = "img/templechan.jpg"      # use absolute URL, seeing it's used in both `/` and `/about/`
  sidebar_about_description = "谌中钱（言戈，Temple Chan），男，29岁，179cm，65kg，摩羯座，ESTJ，汉族，中共团员，1996年1月14日出生于湖北省武汉市黄陂区，祖籍河南洛阳一带，始祖春秋时期郑国大夫裨谌。理学学士学位，主修计算机科学，中国内地不知名程序员，腾讯、Coupang、阿里云 前搬砖人，爬界科技 创始人、首席执行官。"
  about_me = true
  bookmarks = true
  featured_tags = true 
  featured_condition_size = 0
  friends = true

  # Last posts
  last_posts = true
  #last_posts_title = "LAST POSTS"
  #last_posts_count = 5

  #Enable wechat pay & alipay to allow readers send reward money if they like the articles 
  reward = false 
  reward_guide = "您的咖啡能让我写出少 Bug 的代码 ☕️ ~" 

  # Twikoo comments
  # Follow https://twikoo.js.org/ to set up your own env_id
  twikoo_env_id = ""

  # Artalk comments
  # Follow https://artalk.js.org/ to set up your own server
  artalk_enable = false
  artalk_server = "https://xxx.xxx.com"
  artalk_site = "xxx blog"

  # We need a proxy to access Disqus api in China
  # Follow https://github.com/zhaohuabing/disqus-php-api to set up your own disqus proxy
  disqus_proxy = ""
  disqus_site = ""

  # algolia site search
  algolia_search = false
  algolia_appId = ""
  algolia_indexName = ""
  algolia_apiKey = ""

  # leancloud storage for page view counter
  page_view_counter = false
  leancloud_app_id = ""
  leancloud_app_key = ""

  # Baidu Analytics
  ba_track_id = ""

  # Include any custom CSS and/or JS files, url or relative to /static folder
  #custom_css = ["css/lightbox.css", "https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css", "css/main.css"]
  #custom_js = ["js/lightbox.js", "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js", "js/main.js"]
  
  [params.algolia]
  vars = ["title", "summary", "date", "publishdate", "expirydate", "permalink"]
  params = ["categories", "tags"] 

  [params.social]
  rss                    = true

  email                  = "templechan@126.com"
  github                 = "https://github.com/templechan"
#   linkedin               = "https://www.linkedin.com/in/templechan"
  wechat                 = "img/social/social-wechat.png"
  qq                     = "img/social/social-qq.png"
  whatsapp               = "img/social/social-whatsapp.jpg"
  messenger              = "img/social/social-messenger.jpg"
  telegram               = "img/social/social-telegram.jpg"
  line                   = "img/social/social-line.jpg"
  kakaotalk              = "img/social/social-kakaotalk.png"
  zalo                   = "img/social/social-zalo.jpg"

  tiktok                 = "https://www.douyin.com/user/MS4wLjABAAAA84o70K2c9LEZXJ9fHp0deVyvxMudni7rQgAahjtoWIX34SCg61Gbf6H4HYKneZsW"
  wechatChannels         = "img/social/social-wechat-channels.jpg"
  bilibili               = "https://space.bilibili.com/3546602247555636"
  rednote                = "https://www.xiaohongshu.com/user/profile/658fc18d0000000022017e5a"
  wechatPublicPlatform   = "img/social/social-wechat-public-platform.jpg"
  csdn                   = "https://blog.csdn.net/2301_82344373"
  juejin                 = "https://juejin.cn/user/3617844579024624"
  zhihu                  = "https://www.zhihu.com/people/templechan"
  weibo                  = "https://weibo.com/templechan1024"
  facebook               = "https://www.facebook.com/templechann"
  instagram              = "https://www.instagram.com/templechann"
  tiktokInternational    = "https://www.tiktok.com/@templechan"
  x                      = "https://x.com/templechann"
  snapchat               = "https://www.snapchat.com/@templechann"
  vk                     = "https://vk.com/templechan"
  youtube                = "https://www.youtube.com/@templechann"
  threads                = "https://www.threads.com/@templechann"

  [[params.bookmark_link]]
  title =  "爬界科技"
  href =  "https://climbtw.com"

  [[params.friend_link]]
  title = "赵华冰的博客"
  href =  "https://www.zhaohuabing.com"
  [[params.friend_link]]
  title = "Beyond the Void"
  href =  "https://byvoid.com/zhs"

  [[params.additional_menus]]
  title =  "ARCHIVE"
  href =  "/archive"
  [[params.additional_menus]]
  title =  "ABOUT"
  href =  "/about"
```

#### 2.3.2 内容元数据配置

> 配置于 Markdown 文件头部。

作者配置：

```md
---
layout: post
title: 构建博客网站
subtitle: 
description: 涉及 Hugo 静态框架，自动化部署，评论服务，SEO 等。
author: 谌中钱
date: 2026-01-15
lastMod: 
image: img/post-bg-default.png
categories: 
- programming
tags: 
- 解决方案
slug: building-blog-site
metadata:
- text: Hugo
  link: https://gohugo.io
weight: 2
showtoc: true
draft: false
---
```

#### 2.3.3 命令新建文章模板

- 命令：`hugo new post/20260115-building-blog-site.md`
- 作者文章模版 archetypes/post.md：

  ```md
  ---
  layout: post
  title: 
  subtitle: 
  description: 涉及  等。
  author: 谌中钱
  date: 2026-01-15
  lastMod: 
  image: img/post-bg-default.png
  categories: 
  - 
  tags: 
  - 
  slug: 
  metadata:
  - text: 
    link: 
  weight: 2
  showtoc: true
  draft: false
  ---

  <br />

  <!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->
  ```

### 2.4 自动化部署

> 实现推送代码到 Github 上的 main 分支时，会自动部署到 云服务器。

- 环境依赖：
  - 云服务器：参考 <a href="https://templechann.com/post/cloud-server-manual" target="_blank">《云服务器购买和使用手册》</a>
  - Docker：参考 <a href="https://templechann.com/post/docker-manual" target="_blank">《Docker 使用手册》</a>
  - Nginx：参考 <a href="https://templechann.com/post/nginx-manual" target="_blank">《Nginx 使用手册》</a>

#### 2.4.1 云服务器 SSH 配置

> 让 Github 可以用 云服务器的私钥 去连接 云服务器。

```shell
# 云服务器上生成 公钥（id_ed25519.pub） 和 私钥（id_ed25519）
ssh-keygen -t ed25519 -C "templechan@126.com"
# 将 公钥（id_ed25519.pub） 添加到云服务器的 ~/.ssh/authorized_keys 文件中
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys

# 查看 私钥
cat ~/.ssh/id_ed25519
# 登录 GitHub -> 站点仓库下的 Settings -> Secrets and variables -> Actions -> New repository secret 中添加 3 个常量：

# Name: BLOG_SSH_PRIVATE_KEY
# Value: 你的私钥内容（注意不要添加换行符，可以直接从文件复制）

# Name: BLOG_SERVER_IP
# Value: 部署服务器的 IP

# Name: BLOG_USER
# Value: 部署服务器的 user
```

#### 2.4.2 编写脚本

> - ***.github/workflows/blog_deploy.yml***：工作流文件，用来连接云服务器，执行云服务器的部署脚本
> - ***./deploy.sh***：云服务器的部署脚本
> - ***./Dockfile***：镜像构建文件
> - ***./docker-compose.yml***：容器构建文件

##### 2.4.2.1 工作流文件

- .github/workflows/blog_deploy.yml：

```yml
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
        ssh-private-key: ${{ secrets.BLOG_SSH_PRIVATE_KEY }}
 
    - name: Adding Known Hosts
      run: ssh-keyscan ${{ secrets.BLOG_SERVER_IP }} >> ~/.ssh/known_hosts
 
    - name: Deploy to Server
      run: ssh ${{ secrets.BLOG_USER }}@${{ secrets.BLOG_SERVER_IP }} 'bash -s' < ./deploy.sh
```

##### 2.4.2.2 部署脚本

- ./deploy.sh：

```sh
cd /usr/local/src
rm -rf /usr/local/src/blog

if ! command -v git &> /dev/null; then
    dnf install -y git
    git config --global user.email "templechan@126.com"
    git config --global user.name "templechan"
fi

# 设置 GitHub 国内镜像源
git config --global url."https://bgithub.xyz/".insteadOf https://github.com/
# 如果失效，则删除旧的，设置的新的，记得先测试下是否有效
# git config --global --unset url."https://bgithub.xyz/".insteadOf https://github.com/
# git config --global url."https://kkgithub.com/".insteadOf https://github.com/
git clone -b main https://github.com/templechan/blog.git

if [ -d /usr/local/src/blog ] && [ -n "$(ls -A /usr/local/src/blog)" ]; then
    cd /usr/local/src/blog
    if ! command -v mogrify &> /dev/null; then
        # 安装图片压缩包 ImageMagick
        dnf install -y ImageMagick bc parallel
        # 配置ImageMagick策略文件
        sed -i '/<policy domain="coder" rights=".*" pattern="PNG,JPG,JPEG,WEBP"/d;/<policymap>/a \  <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />;s/<policy domain="resource" name="memory" value="[^"]*"/<policy domain="resource" name="memory" value="256MiB"/;s/<policy domain="resource" name="disk" value="[^"]*"/<policy domain="resource" name="disk" value="1GiB"/;s/<policy domain="resource" name="width" value="[^"]*"/<policy domain="resource" name="width" value="8KP"/;s/<policy domain="resource" name="height" value="[^"]*"/<policy domain="resource" name="height" value="8KP"/;s/<policy domain="resource" name="thread" value="[^"]*"/<policy domain="resource" name="thread" value="2"/;s/<policy domain="resource" name="throttle" value="[^"]*"/<policy domain="resource" name="throttle" value="1"/;s/<policy domain="resource" name="map" value="[^"]*"/<policy domain="resource" name="map" value="256MiB"/' /etc/ImageMagick-7/policy.xml
    fi

    # 手动压缩图片资源（会覆盖源文件，注意保留源文件）
    # 1 图片大小判断 >100KB 才压缩
    # 2 动态质量计算算法 75 - 20*l(...)
    # 3 质量限制 15~60
    # 4 PNG / JPG / WebP 压缩参数
    # 5 统计节省空间算法
    # 6 并行数 -j 2
    
    # 进度交互版
    # start=$SECONDS; find ./static/img/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 2 --bar 'f="{}";old_size=$(stat -c %s "$f");if [ $old_size -gt 102400 ]; then q=$(echo "scale=0;80-40*l($old_size/102400)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<15?15:q>60?60:q));ext="${f##*.}";case "$ext" in png) mogrify -strip -quality $q -define png:compression-level=9 -colors 128 "$f" 2>/dev/null ;; jpg|jpeg) mogrify -strip -quality $q -sampling-factor 4:2:0 -density 72x72 "$f" 2>/dev/null ;; webp) mogrify -strip -quality $((q-5)) -define webp:method=6 "$f" 2>/dev/null ;; esac;new_size=$(stat -c %s "$f");save=$((old_size-new_size));echo "$save" >> /tmp/img_save.txt;fi'; total_save=$(awk '{sum+=$1}END{print sum}' /tmp/img_save.txt 2>/dev/null||0); count=$(wc -l </tmp/img_save.txt 2>/dev/null||0); rm -f /tmp/img_save.txt; cost=$((SECONDS - start)); min=$((cost / 60)); sec=$((cost % 60)); echo -e "\n\033[1;32m=== 压缩完成 ===\033[0m"; echo "✅ 压缩数量：$count 张"; echo "✅ 节省空间：$((total_save/1024)) KB ($((total_save/1024/1024)) MB)"; echo -e "✅ 耗时：${min}分${sec}秒"; echo -e "\033[1;32m================\033[0m"
    # GitHub Actions 不支持交互专用
    start=$SECONDS; find ./static/img/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 2 'f="{}";old_size=$(stat -c %s "$f");if [ $old_size -gt 102400 ]; then q=$(echo "scale=0;80-40*l($old_size/102400)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<15?15:q>60?60:q));ext="${f##*.}";case "$ext" in png) mogrify -strip -quality $q -define png:compression-level=9 -colors 128 "$f" 2>/dev/null ;; jpg|jpeg) mogrify -strip -quality $q -sampling-factor 4:2:0 -density 72x72 "$f" 2>/dev/null ;; webp) mogrify -strip -quality $((q-5)) -define webp:method=6 "$f" 2>/dev/null ;; esac;new_size=$(stat -c %s "$f");save=$((old_size-new_size));echo "$save" >> /tmp/img_save.txt;fi' 2>/dev/null; total_save=$(awk '{sum+=$1}END{print sum}' /tmp/img_save.txt 2>/dev/null||0); count=$(wc -l </tmp/img_save.txt 2>/dev/null||0); rm -f /tmp/img_save.txt; cost=$((SECONDS-start)); min=$((cost/60)); sec=$((cost%60)); echo -e "\n=== 图片压缩完成 ==="; echo "压缩数量：$count 张"; echo "节省空间：$((total_save/1024)) KB ($((total_save/1024/1024)) MB)"; echo "耗时：${min}分${sec}秒"; echo "===================="

    if ! command -v docker &> /dev/null; then
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

        # 启动 Docker
        systemctl start docker
        # 设置 Docker 自启
        systemctl enable docker
    fi
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

    docker rm -f blog >/dev/null 2>&1
    docker rmi -f blog >/dev/null 2>&1

    docker compose up -d --build
fi
```

##### 2.4.2.3 镜像构建文件

- ./Dockfile：

```docker
# 阶段1：Hugo 构建环境（临时镜像，用完丢弃）
FROM hugomods/hugo:std-base-0.159.0 AS builder
WORKDIR /src
COPY . .
RUN hugo --minify

# 阶段2：生产运行环境（仅保留静态文件 + Nginx，超小体积）
FROM nginx:alpine
COPY --from=builder /src/public/ /usr/share/nginx/html/
EXPOSE 80
```

##### 2.4.2.4 容器构建启动文件

- ./docker-compose.yml：

```yml
version: '3.8'

services:
  blog:
    # 等价于 docker build -t blog . （自动构建当前目录的Dockerfile）
    build: .
    # 容器名称
    container_name: blog
    # 端口映射 主机80 → 容器80
    ports:
      - "80:80"
    # 开机/崩溃自动重启
    restart: always
```

### 2.5 评论服务

### 2.6 SEO



