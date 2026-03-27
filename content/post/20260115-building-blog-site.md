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

- 环境依赖
  - 访问 GitHub 可能需要梯子：参考 <a href="https://templechann.com/post/20260126-vpn-manual" target="_blank">《梯子使用手册》</a>
  - Git：参考 <a href="https://templechann.com/post/20260312-git-manual" target="_blank">《Git 使用手册》</a>

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
baseURL = 'https://templechann.com/' 
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
description: 涉及 Hugo 静态框架，评论服务，搜索服务，SEO，自动化部署 等。
author: 谌中钱
date: 2026-01-14
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
  date: 2026-01-14
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

## 2.4 自动化部署

> 实现推送代码到 Github 上的 main 分支时，会自动部署到 云服务器。

### 2.4.1 云服务器 SSH 配置

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

### 2.4.2 编写脚本

> - ***.github/workflows/blog_deploy.yml***：工作流文件，用来连接云服务器，执行云服务器的部署脚本
> - ***./deploy.sh***：云服务器的部署脚本
> - ***./Dockfile***：镜像构建文件

- .github/workflows/blog_deploy.yml：

```

```

- ./deploy.sh：

```

```

- ./Dockfile：

```

```


## 2.5 评论服务

## 2.6 SEO



