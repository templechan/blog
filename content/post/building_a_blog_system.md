---
layout: single
title: "构建博客系统"
description: "Hugo 框架的使用，全格式图片批量动态压缩，Twikoo 评论系统部署，站点自动化部署，SEO 等。"
author: "谌中钱"
date: "2025-01-15"
image: "/img/temple_404_bg.jpg"
categories: [ "solutions" ]
tags:
  - "solutions"
weight: 2
ogurl: "https://blog.climbtw.com/post/building_a_blog_system"
---

<br />
<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [使用 Hugo 框架](#使用-hugo-框架)
  - [安装 Hugo](#安装-hugo)
    - [配置 Hugo 主题](#配置-hugo-主题)
      - [使用 hugo-theme-cleanwhite 主题](#使用-hugo-theme-cleanwhite-主题)
        - [站点配置 (参考主题演示站点)](#站点配置-参考主题演示站点)
          - [主题默认版本](#主题默认版本)
          - [初始化版本备份](#初始化版本备份)
        - [主题bug修复](#主题bug修复)
    - [Hugo 的 Front matter 模板](#hugo-的-front-matter-模板)
      - [文章 Front matter](#文章-front-matter)
      - [页面 Front matter](#页面-front-matter)
    - [Window 11 下](#window-11-下)
      - [包管理器 方式安装](#包管理器-方式安装)
    - [CentOS 9 下](#centos-9-下)
      - [图片批量动态压缩](#图片批量动态压缩)
      - [Docker 方式安装](#docker-方式安装)
  - [使用 Twikoo 评论系统](#使用-twikoo-评论系统)
    - [云函数部署](#云函数部署)
      - [Docker 方式](#docker-方式)
    - [在 hugo-theme-cleanwhite 主题中使用](#在-hugo-theme-cleanwhite-主题中使用)
      - [修改站点配置启用](#修改站点配置启用)
      - [Twikoo 设置](#twikoo-设置)
        - [使用自定义头像](#使用自定义头像)
          - [使用 Weavatar 服务](#使用-weavatar-服务)
        - [使用 Server酱 (ServerChan) 评论推送](#使用-server酱-serverchan-评论推送)
  - [使用 Algolia 站点搜索](#使用-algolia-站点搜索)
    - [在 hugo-theme-cleanwhite 主题中使用](#在-hugo-theme-cleanwhite-主题中使用-1)
      - [开启 Algolia](#开启-algolia)
      - [本地生成索引文件](#本地生成索引文件)
      - [推送搜索引到 Algolia](#推送搜索引到-algolia)
    - [访问索引的配置](#访问索引的配置)
  - [嵌入视频](#嵌入视频)
    - [哔哩哔哩](#哔哩哔哩)
    - [Vimeo (需要梯子)](#vimeo-需要梯子)
    - [YouTube (需要梯子)](#youtube-需要梯子)
- [自动化部署](#自动化部署)
  - [在部署服务器上生成SSH密钥](#在部署服务器上生成ssh密钥)
  - [编写 GitHub Action 工作流](#编写-github-action-工作流)
  - [站点仓库的部署脚本](#站点仓库的部署脚本)
- [SEO](#seo)
  - [搜索引擎收录](#搜索引擎收录)
  - [修复站点地图](#修复站点地图)

<!-- /code_chunk_output -->

# 使用 Hugo 框架

> Hugo 是最流行的开源静态站点生成器之一。凭借其惊人的速度和灵活性，Hugo 让搭建网站再次变得有趣。

- Hugo 官网: <https://gohugo.io>
    - Hugo 中文网: <https://gohugo.cn>
- Hugo 文档: <https://gohugo.io/installation>
    - Hugo 命令手册: <https://gohugo.io/commands/hugo>
    - Hugo Docker 第三方开源镜像: <https://docker.hugomods.com/zh-hans/docs/tags/#std-base>

## 安装 Hugo

### 配置 Hugo 主题

- Hugo 主题列表: <https://themes.gohugo.io>
- 配置方法:
    - 下载 主题源代码 放到 站点 的 ./themes 文件夹下
    - 然后修改 根目录 下的 站点配置 hugo.toml
    - 启动站点
- 注意：
    - 如果没有配置主题:
        - 新建的站点会找不到页面文件，导致报错。
        - blog 容器无法成功启动，nginx 容器会报 服务器内部错误。

#### 使用 hugo-theme-cleanwhite 主题

- hugo-theme-cleanwhite 主题地址:
    - Hugo: <https://themes.gohugo.io/themes/hugo-theme-cleanwhite>
    - Github: <https://github.com/zhaohuabing/hugo-theme-cleanwhite>
- 演示站点: <https://www.zhaohuabing.com>
    - 演示站点代码地址: <https://github.com/zhaohuabing/hugo-theme-cleanwhite/tree/master/exampleSite>
        - 演示站点的站点配置 hugo.toml: <https://github.com/zhaohuabing/hugo-theme-cleanwhite/blob/master/exampleSite/hugo.toml>
        - 演示站点的静态资源:
            - content 文件夹（存放 文章 和 页面 文件）: <https://github.com/zhaohuabing/hugo-theme-cleanwhite/tree/master/exampleSite/content>
            - static 文件夹（存放 静态资源）: <https://github.com/zhaohuabing/hugo-theme-cleanwhite/tree/master/exampleSite/static/img>

##### 站点配置 (参考主题演示站点)

- 站点配置 是参考 主题演示站点的站点配置 进行修改或复制。
- 注意：
    - 根目录下的 content 文件夹是用来存放 文章 或 页面 文件：可参考 主题演示站点 的 写法
    - 根目录下的 static 文件夹是用来存放 静态资源

###### 主题默认版本

- 默认版本存在错误：
    - 120行：add 后面的 空格 需要删除，否则启动会报错: unmarshal failed: toml: expected character ]
    - 130行：add 后面的 空格 需要删除，否则启动会报错: unmarshal failed: toml: expected character ]

hugo.toml

```toml
baseurl = "https://zhaohuabing.com"
title = "Huabing Blog"
theme = "hugo-theme-cleanwhite"
languageCode = "en-us"
preserveTaxonomyNames = true
hasCJKLanguage = true

[services]
  # Enable comments by entering your Disqus shortname
  [services.disqus]
    shortname = ""
  [services.googleAnalytics]
    id = ""

[pagination]
  pagerSize = 5 # frontpage pagination

[outputs]
home = ["HTML", "RSS", "Algolia"]

[params]
  header_image = "img/home-bg-jeep.jpg"
  SEOTitle = "赵化冰的博客 | Zhaohuabing Blog"
  description = "赵化冰，程序员, 开源爱好者，生活探险家 | 这里是 赵化冰 的博客，与你一起发现更大的世界。"
  keyword = "赵化冰, zhaohuabing, Zhaohuabing, , 赵化冰的网络日志, 赵化冰的博客, Zhaohuabing Blog, 博客, 个人网站, 互联网, Web, 云原生, PaaS, Istio, Kubernetes, 微服务, Microservice"
  slogan = "路在脚下，心向远方"
  upstreamAttribution = true

  image_404 = "img/404-bg.jpg"
  title_404 = "你来到了没有知识的荒原 :("
  omit_categories = false

  # leancloud storage for page view counter
  page_view_counter = false
  leancloud_app_id = ""
  leancloud_app_key = ""

  # algolia site search
  algolia_search = true
  algolia_appId = ""
  algolia_indexName = ""
  algolia_apiKey = ""

  # Sidebar settings
  sidebar_about_description = "Software Developer, Open Source Enthusiast and Life Adventurer"
  #sidebar_avatar = "img/avatar-zhaohuabing.jpg"      # use absolute URL, seeing it's used in both `/` and `/about/`
  sidebar_avatar = "img/zhaohuabing.png"      # use absolute URL, seeing it's used in both `/` and `/about/`

  featured_tags = true 
  featured_condition_size = 1 

  # Baidu Analytics
  ba_track_id = ""
  
  # We need a proxy to access Disqus api in China
  # Follow https://github.com/zhaohuabing/disqus-php-api to set up your own disqus proxy
  disqus_proxy = ""
  disqus_site = ""

  # Twikoo comments
  # Follow https://twikoo.js.org/ to set up your own env_id
  twikoo_env_id = ""

  # Artalk comments
  # Follow https://artalk.js.org/ to set up your own server
  artalk_enable = true
  artalk_server = "https://xxx.xxx.com"
  artalk_site = "xxx blog"

  #Enable wechat pay & alipay to allow readers send reward money if they like the articles 
  reward = true 
  # reward_guide = "如果这篇文章对你有用,请随意打赏" 

  friends = true
  bookmarks = false
  about_me = true

  # Include any custom CSS and/or JS files, url or relative to /static folder
  #custom_css = ["css/lightbox.css", "https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css", "css/main.css"]
  #custom_js = ["js/lightbox.js", "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js", "js/main.js"]

  [params.social]
  rss            = true 
  email          = "youremail@gmail.com"
  #facebook      = "full profile url in facebook"
  #googleplus    = "full profile url in googleplus"
  #twitter       = "full profile url in twitter"
  linkedin       = "https://www.linkedin.com/in/yourlinkedinid"
  stackoverflow  = "https://stackoverflow.com/users/yourstackoverflowid"
  #instagram     = "full profile url in instagram"
  github         = "https://github.com/yourgithub"
  wechat         = "your wechat qr code image"
  #medium        = "full profile url in medium"
  #slack         = "full workspace url in slack"
  #pinterest     = "full profile url in pinterest"
  #reddit        = "full profile url in reddit"
  #gitlab        = "full profile url in gitlab"
  #mastodon      = "full profile url in mastodon"
  #keybase       = "full profile url in keybase"
  #xing          = "https://www.xing.com/profile/yourxingid"
  #git           = "full profile url for git user"
  
  [[params.friend_link]]
  title = "Linda的博客"
  href =  "https://zhaozhihan.com"

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
  
  [[params.add itional_menus]]
  title =  "ARCHIVE"
  href =  "/archive/"
  [[params.add itional_menus]]
  title =  "NOTES"
  href =  "/notes/"
  [[params.additional_menus]]
  title =  "ABOUT"
  href =  "/about/"

[outputFormats.Algolia]
baseName = "algolia"
isPlainText = true
mediaType = "application/json"
notAlternative = true

[params.algolia]
vars = ["title", "summary", "date", "publishdate", "expirydate", "permalink"]
params = ["categories", "tags"] 

[markup]
  [markup.tableOfContents]
    endLevel = 2
    startLevel = 1
  [markup.highlight]
    style = "dracula"
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true
```

###### 初始化版本备份

hugo.toml

```toml
baseURL = 'https://example.org/'
languageCode = 'en-us'
title = 'My New Hugo Site'
```

##### 主题bug修复

- .\themes\hugo-theme-cleanwhite\layouts\partials\sidebar.html:
    - 289 行: /tags/ 前面的 空格 要删除，否则生成的 tag 链接会出错，无法正确跳转。
- .\themes\hugo-theme-cleanwhite\layouts\partials\footer.html:
    - fastClick.js cdn 大陆无法访问，它的作用是 消除移动设备上的300毫秒点击延迟，这里我们直接 下载，本地导入

```html
<!--fastClick.js -->
<script>
    // loadAsync("https://cdn.jsdelivr.net/npm/fastclick@1.0.6/lib/fastclick.min.js", function () {
    //     var $nav = document.querySelector("nav");
    //     if ($nav) FastClick.attach($nav);
    // })
    loadAsync('{{ "js/fastclick.min.js" | relURL }}', function () {
        var $nav = document.querySelector("nav");
        if ($nav) FastClick.attach($nav);
    })
</script>
```

### Hugo 的 Front matter 模板

#### 文章 Front matter

```yaml
---
layout: single
title: "Visual Studio Code 使用手册"
description: "VS Code 下载安装，常用插件 等。"
author: "谌中钱"
date: "2025-01-14"
image: "/img/temple_404_bg.jpg" # banner 背景图
categories: [ "tech" ]
tags:
  - "tools"
weight: 1 # 置顶，数值越小，权重越大
---
```

#### 页面 Front matter

```yaml
---
layout: page
title: "关于我"
description: "Hi，我是谌中钱，本科主修计算机科学，全栈高级开发工程师，曾在 阿里云，腾讯，Coupang 从事开发工作。常用技术栈以 React，Node 等技术为主。"
author: "谌中钱"
date: "2025-01-14"
---
```

### Window 11 下

#### 包管理器 方式安装

1. Win + R 打开 运行 窗口，输入 cmd 打开 命令终端
2. 操作命令:
   参考 [《Git 使用手册》](https://blog.climbtw.com/post/git_manual/)

```shell
# 查看本地是否安装 Hugo
winget list | findstr Hugo
# 更新包索引，确保包都是最新的
winget update
# 查询一下 Hugo 包列表
winget search Hugo
# 名称                  ID                    版本     匹配          源
# --------------------------------------------------------------------------
# HuGO - Hygiene und GO 9NCDTRC8TX5J          Unknown                msstore
# Remember Passwords    9NXJM8NGHDG6          Unknown                msstore
# Hugo                  Hugo.Hugo             0.146.7                winget
# Hugo (Deploy)         Hugo.Hugo.Deploy      0.145.0  Command: hugo winget
# Hugo (Extended)       Hugo.Hugo.Extended    0.146.7                winget
# 希沃集控              Seewo.SeewoHugo       1.4.5.57               winget
# 掌上看班              Seewo.SeewoHugoKanban 1.4.5.68               winget

# 安装 Hugo 标准版
winget install Hugo.Hugo
# 更新 Hugo 版本，有时候版本会有 bug，需要更新
# winget upgrade --name Hugo --version 0.146.7
# 卸载 Hugo
# winget uninstall Hugo

# 查看 Hugo 版本
hugo version

# 创建新站点，指定路径，命名为 blog
hugo new site D:\workspace\blog && cd /d D:\workspace\blog

# 下载主题 hugo-theme-cleanwhite
# 记得删除 ./themes/hugo-theme-cleanwhite 下的 .git 文件夹，不然后续提交会报错
git clone https://github.com/zhaohuabing/hugo-theme-cleanwhite.git ./themes/hugo-theme-cleanwhite

# 复制 主题演示站点 的 站点配置文件 hugo.toml，content 文件夹，static 文件夹 到 新站点 下
# 注意修改 hugo.toml 的错误，上面有描述
copy /Y ".\themes\hugo-theme-cleanwhite\exampleSite\hugo.toml" "."
xcopy ".\themes\hugo-theme-cleanwhite\exampleSite\content" ".\content" /E /Y
xcopy ".\themes\hugo-theme-cleanwhite\exampleSite\static" ".\static" /E /Y

# 启动测试服务器，访问站点 http://localhost:1313
# --bind 0.0.0.0 是为了监听 IPv4 所有网络地址，让 手机 等设备可以通过 局域网 (同一 WiFi 下) 访问 电脑 的站点，进行移动端测试
hugo server --bind 0.0.0.0
```

### CentOS 9 下

#### 图片批量动态压缩

- 采用 ImageMagick、bc、parallel 包 批量动态压缩图片资源，提高站点访问速度，会在 Docker 方式安装 时用到，操作命令如下：

```shell
# 手动压缩图片资源（会覆盖源文件，注意保留源文件）
# 压缩规则: 
# 1. 超过 500KB 的图片才会压缩
# 2. 根据 图片大小 动态控制压缩比例，最后都控制在 300KB 左右
# 3. 可压缩 PNG,JPG,JPEG,WEBP 的图片

# 安装工具包
dnf install -y ImageMagick-7.1.1.26-2.oc9 bc parallel
# 配置ImageMagick策略文件
vim /etc/ImageMagick-7/policy.xml

# 按 i 键进入 插入模式
# 复制下面的 配置内容 到里面：

# <!-- 允许读写图片格式 -->
# <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />
# <!-- 提升资源限制 -->
# <policy domain="resource" name="memory" value="1GiB"/>
# <policy domain="resource" name="disk" value="4GiB"/>
# <policy domain="resource" name="width" value="32KP"/>
# <policy domain="resource" name="height" value="32KP"/>

# 按 ESC 键退出 插入模式，输入 :wq 并按 Enter 来保存（write）并退出（quit）
# 查看当前生效策略
convert -list policy

# 将脚本合成为一条命令
find ./static/img/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 4 --bar 'f="{}";s=$(stat -c%s "$f");if [ $s -gt 512000 ];then q=$(echo "scale=0;60-30*l($s/512000)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<10?10:q>75?75:q));case "${f##*.}" in png) p="-quality $((q-25)) -define png:compression-level=9 -colors 128" ;; jpg|jpeg) p="-quality $((q-10)) -sampling-factor 4:2:0" ;; webp) p="-quality $((q-20)) -define webp:method=6" ;; esac;mogrify $p "$f";fi'
```

- 下面是命令展开的脚本，用于分析：

```bash
find ./static/img/ \( -name "*.png" -o ... \) -type f -print0 | 
parallel -0 -j4 --bar '
f="{}";
s=$(stat -c%s "$f");
if [ $s -gt 512000 ];then
  # 质量计算
  q=$(echo "scale=0;60-30*l($s/512000)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");
  q=$((q<10?10:q>75?75:q));
  
  # 格式处理分支
  case "${f##*.}" in
    png)  p="-quality $((q-25)) -define png:compression-level=9 -colors 128";;
    jpg|jpeg) p="-quality $((q-10)) -sampling-factor 4:2:0";;
    webp) p="-quality $((q-20)) -define webp:method=6";;
  esac;
  
  # 执行压缩
  mogrify $p "$f";
fi'
```

#### Docker 方式安装

1. 安装 Docker
    - 参考 [《Docker 使用手册》](https://blog.climbtw.com/post/docker_manual/)
2. 进入云服务终端
    - 参考 [《云服务器购买和使用手册》](https://blog.climbtw.com/post/cloud_server_manual/)
3. 安装 blog 容器:

```shell
# 创建文件夹
mkdir /usr/local/src/blog && cd /usr/local/src/blog
# 新建 Dockerfile 文件
vim Dockerfile

# 按 i 键进入 插入模式
# 复制下面的 Dockfile 文件 内容到里面
# 按 ESC 键退出 插入模式，输入 :wq 并按 Enter 来保存（write）并退出（quit）

# 构建镜像
docker build -t blog .

# 把需要 外部挂载 的文件，放到指定的 目录里: 
# ./themes : 存放 主题源代码
# ./hugo.toml : 存放 主题站点配置
# ./content : 存放 文章 和 页面 的 md 文件
# ./static : 存放 静态资源
# ./public : 存放 站点构建结果

# 下载主题 hugo-theme-cleanwhite
# 记得删除 ./themes/hugo-theme-cleanwhite 下的 .git 文件夹，不然后续提交会报错
git clone https://github.com/zhaohuabing/hugo-theme-cleanwhite.git ./themes/hugo-theme-cleanwhite
# 复制 主题演示站点 的 站点配置文件 hugo.toml，content 文件夹，static 文件夹 到 新站点 下
# 注意用 vim 修改 hugo.toml 的错误，上面有描述
cp -f ./themes/hugo-theme-cleanwhite/exampleSite/hugo.toml .
cp -rf ./themes/hugo-theme-cleanwhite/exampleSite/content/* ./content/
cp -rf ./themes/hugo-theme-cleanwhite/exampleSite/static/* ./static/


# 手动压缩图片资源（会覆盖源文件，注意保留源文件）
# 压缩规则: 
# 1. 超过 500KB 的图片才会压缩
# 2. 根据 图片大小 动态控制压缩比例，最后都控制在 300KB 左右
# 3. 可压缩 PNG,JPG,JPEG,WEBP 的图片

# 安装工具包
dnf install -y ImageMagick-7.1.1.26-2.oc9 bc parallel
# 配置ImageMagick策略文件
sed -i '/<policy domain="coder" rights="read|write"/!b;n;c\ \ <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />' /etc/ImageMagick-7/policy.xml
sed -i '/<policy domain="resource" name="memory"/s/value=".*"/value="1GiB"/' /etc/ImageMagick-7/policy.xml
sed -i '/<policy domain="resource" name="disk"/s/value=".*"/value="4GiB"/' /etc/ImageMagick-7/policy.xml
sed -i '/<policy domain="resource" name="width"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
sed -i '/<policy domain="resource" name="height"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
# 查看当前生效策略
convert -list policy

# 将脚本合成为一条命令
find ./static/img/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 4 --bar 'f="{}";s=$(stat -c%s "$f");if [ $s -gt 512000 ];then q=$(echo "scale=0;60-30*l($s/512000)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<10?10:q>75?75:q));case "${f##*.}" in png) p="-quality $((q-25)) -define png:compression-level=9 -colors 128" ;; jpg|jpeg) p="-quality $((q-10)) -sampling-factor 4:2:0" ;; webp) p="-quality $((q-20)) -define webp:method=6" ;; esac;mogrify $p "$f";fi'


# 创建并运行容器
docker run -d --restart=always -p 81:80 \
-v ./themes:/blog/themes \
-v ./hugo.toml:/blog/hugo.toml \
-v ./content:/blog/content \
-v ./static:/blog/static \
-v ./public:/blog/public \
--name blog blog

# 等待 5 秒，确保容器已启动
sleep 5
# 修复 RSS
sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/index.xml
sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/sitemap.xml
# 修复站点的动态链接
sed -i 's#http://212\.64\.16\.86:80#https://blog.climbtw.com#g' \
./public/index.html \
./public/categories/solutions/index.html \
./public/categories/tech/index.html

# 推送索引到 Algolia，下面的 使用 Algolia 会详细介绍
# npm install atomic-algolia
# npx atomic-algolia
```

- Dockfile 文件:

```dockerfile
# 注意更新 Hugo 版本，有时候版本会有 bug，需要更新
FROM hugomods/hugo:std-base-0.146.7
RUN hugo new site blog
WORKDIR /blog

# 创建索引文件
RUN hugo

# 212.64.16.86 为 云服务器 的 公网IP
# 这里不能使用域名，否则 Hugo 生成的 动态链接 会变成 https://域名:80，导致 端口 重复，文章跳转会出错
# --disableLiveReload：在生产环境中部署网站，不希望浏览器频繁刷新
CMD ["hugo", "server", "--disableLiveReload", "--baseURL", "http://212.64.16.86", "-p", "80"]
```

4. 搭建 Nginx 服务器 容器
    - 参考 [《Nginx 使用手册》](https://blog.climbtw.com/post/nginx_manual/)

5. 修改 nginx.conf 配置:
    - 二级域名的生成 参考 [《云服务器购买和使用手册》](https://blog.climbtw.com/post/cloud_server_manual/)

```shell
# 修改 nginx.conf 配置，让 二级域名 blog.climbtw.com 反向代理到 blog 容器映射的 宿主机端口 81:
# 即 复制下面的 nginx.conf 文件 到 nginx 容器 配置文件的 挂载目录 /usr/local/src/nginx/conf/nginx.conf 里

# 重启 nginx 容器
docker restart nginx

# 可以通过 二级域名 blog.climbtw.com 访问站点
```

- nginx.conf 文件:

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

## 使用 Twikoo 评论系统

> 一个简洁、安全、免费的静态网站评论系统。

- Twikoo 官网：<https://twikoo.js.org>
- GitHub: <https://github.com/twikoojs/twikoo/releases>
    - 前端引用 twikoo.js 版本需要与 云函数版本 保持一致

### 云函数部署

#### Docker 方式

1. 进入云服务终端
2. 操作命令:

```shell
# 创建文件夹，用来存放 数据文件
mkdir /usr/local/src/twikoo && cd /usr/local/src/twikoo

# 拉取 twikoo 镜像
docker pull imaegoo/twikoo:1.6.42

# 创建并运行容器
docker run -d --restart=always -p 82:8080 -e TWIKOO_THROTTLE=1000  -v ./data:/app/data --name twikoo imaegoo/twikoo:1.6.42

# 修改 nginx.conf 配置，让 二级域名 twikoo.climbtw.com 反向代理到 twikoo 容器映射的 宿主机端口 82，重启 nginx 容器
```

### 在 hugo-theme-cleanwhite 主题中使用

#### 修改站点配置启用

1. 修改 站点配置文件 hugo.toml

```toml
# Twikoo comments
# Follow https://twikoo.js.org/ to set up your own env_id
twikoo_env_id = "https://twikoo.climbtw.com/" # 云函数部署的地址
```

2. 修改 主题 源码

- 修改 前端引用的 twikoo.js，与 云函数版本 保持一致，这里用的 1.6.42：
    - 静态引入的话，可以去上面 GitHub 地址 里下载 对应版本（注意 twikoo.all.min.js 中存在很多敏感信息，无法提交到 git）

.\themes\hugo-theme-cleanwhite\layouts\partials\comments.html

```html
<script src="https://registry.npmmirror.com/twikoo/1.6.42/files/dist/twikoo.all.min.js"></script>

<!-- <script src='{{ "js/twikoo.all.min.js" | relURL }}'></script> -->
```

- 主题 的 bootstrap.min.css 对 上传图像 样式有覆盖，修改一下:

.\themes\hugo-theme-cleanwhite\static\css\bootstrap.min.css

```html
<style>
.twikoo .tk-input-image {
    display: none;
}
</style>
<div id="twikoo-tcomment"></div>
```

#### Twikoo 设置

> 在 站点文章 下方会有 Twikoo 评论组件，组件右下侧有 设置 按钮，第一次打开 设置 需要 配置密码。

##### 使用自定义头像

###### 使用 Weavatar 服务

> Weavatar，多端多元化的统一头像服务。

- Weavatar 官网: <https://weavatar.com/>
- 配置方法:
    - 去 Weavatar 官网 用 邮箱 注册 和 上传 自定义头像。
    - 在 Twikoo 设置 -> 配置管理 -> 通用，按如下配置:

```
GRAVATAR_CDN: weavatar.com
```

- 主题 hugo-theme-cleanwhite 的样式对 头像 div 有覆盖，需要修改:

.\themes\hugo-theme-cleanwhite\layouts\partials\comments.html

```html
<style>
.twikoo img {
    margin: 0;
}
</style>
<div id="twikoo-tcomment"></div>
```

##### 使用 Server酱 (ServerChan) 评论推送

> Server酱，英文名 ServerChan，是一款 手机 和 服务器、智能设备 之间的通信软件。

- Server酱 官网: <https://sct.ftqq.com>
- 配置方法:
    - 去 Server酱 官网 注册，获取 SendKey，然后在 通道配置 里面设置 通知方式，我使用的 方糖的微信服务号。
    - 在 Twikoo 设置 -> 配置管理 -> 即时通知，按如下配置:

```
PUSHOO_CHANNEL: serverchan
PUSHOO_TOKEN: 填写获取的 SendKey
SC_MAIL_NOTIFY: false
```

- 注意:
    - ServerChan 目前由于用户量比较大，免费的通知额度只有 5 条。
    - 自己发布的评论 (按邮箱判断)，不会通知。

## 使用 Algolia 站点搜索

> Algolia 是为你的 APP 或者网站添加搜索的最佳方式。

- Algolia 官网：<https://www.algolia.com>

### 在 hugo-theme-cleanwhite 主题中使用

#### 开启 Algolia

- 修改 站点配置文件 hugo.toml

```toml
# algolia site search
algolia_search = true
algolia_appId = "***"
algolia_apiKey = "***"
algolia_indexName = "hugo-blog"

[outputs]
home = ["HTML", "RSS", "Algolia"]

[outputFormats.Algolia]
baseName = "algolia"
isPlainText = true
mediaType = "application/json"
notAlternative = true

[params.algolia]
vars = ["title", "summary", "date", "publishdate", "expirydate", "permalink"]
params = ["categories", "tags"]
```

#### 本地生成索引文件

- 在站点项目下执行构建命令：`hugo`，会在 public 目录下新建一个名为 algolia.json 的索引文件，它的地址即 **`ALGOLIA_INDEX_FILE`**。

#### 推送搜索引到 Algolia

1. 去 Algolia 官网 注册一个账号，获取 **`Application ID`**、**`Write API Key`**。
2. 然后点击左侧的 Search 按钮，创建一个新的索引，自定义取名，比如 "hugo-blog"，即 **`ALGOLIA_INDEX_NAME`**。
3. 在站点根目录下创建一个 `.env` 文件，写入上面获取到的 **`ALGOLIA_INDEX_FILE`**、**`Application ID`**、**`Write API Key`**、**`ALGOLIA_INDEX_NAME`**

**`.env`**：

```env
ALGOLIA_INDEX_FILE=/public/algolia.json
ALGOLIA_APP_ID=***
ALGOLIA_ADMIN_KEY=***
ALGOLIA_INDEX_NAME=hugo-blog
```

4. 安装推送工具包 `atomic-algolia`，推送索引到 Algolia

```shell
npm install atomic-algolia
npx atomic-algolia
```

### 访问索引的配置

- 即在上面的 站点配置 hugo.toml 中，填入 Algolia 官网中的 `Application ID`，`Search API Key`, 以及 `ALGOLIA_INDEX_NAME`
- 创建 搜索页面文件，即在 content 创建一个文件夹 search，构建一个空文件，命令 `placeholder.md`，即可。

## 嵌入视频

### 哔哩哔哩

> 使用方式：`{ {< bilibili BV1kZ4y137gv >}}`

- 优点：不需要梯子。
- 缺点：站内只能观看 360P 内容。

{{< bilibili BV12s411j71t >}}

### Vimeo (需要梯子)

> 使用方式：`{ {< vimeo 146022717 >}}`

- 优点：可在 站内 直接观看 1080p 内容。
- 缺点：需要梯子。
- 参考: [《梯子使用手册》](https://blog.climbtw.com/post/vpn_manual/)

{{< vimeo 146022717 >}}

### YouTube (需要梯子)

> 使用方式：`{ {< youtube cllc1ZGlhsQ >}}`

- 优点:
    - 可在 站内 直接观看 1080p 内容。
    - 月活跃用户 26亿+（全球第一）
- 缺点：
    - 需要梯子。
    - 站内 不能全屏观看。
- 参考: [《梯子使用手册》](https://blog.climbtw.com/post/vpn_manual/)

{{< youtube _Y2hW6cqt1Y >}}

# 自动化部署

> 实现推送代码到 github 上的 main 分支时，会自动部署到 部署服务器。

- 自动化部署流程：
    - 在 Github 站点仓库上，通过 Github Action，新建一个 Workflow 工作流，创建 .github/workflows/**deploy.yml**，在里面监听 代码上传，合并 等操作，触发 连接部署服务器 的动作，并在 部署服务器 上执行 站点仓库里的 部署脚本 **./deploy.sh**
        - 要连接部署服务器，需要先把 部署服务器 的 **SSH公钥** id_rsa.pub 添加到其 ~/.ssh/**authorized_keys** 里，然后把 部署服务器 的 **SSH私钥** 设置到 **GitHub Action** 上，取个名字。
            - 在 .github/workflows/**deploy.yml** 中使用 **SSH私钥** 去连接 部署服务器。
        - 参考：
            - [《Git 使用手册》](https://blog.climbtw.com/post/git_manual/)
            - [《GitHub Action 使用手册》](https://blog.climbtw.com/post/git_action_manual/)
    - 部署脚本 **./deploy.sh** 里面，会拉取最新的代码，完成网站更新。

## 在部署服务器上生成SSH密钥

```shell
# 在云服务器上生成 公钥（id_rsa.pub） 和 私钥（id_rsa）
ssh-keygen -t rsa -b 4096 -C "templechan@126.com"
# 将 公钥 添加到云服务器的 ~/.ssh/authorized_keys 文件中
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# 查看 私钥
cat ~/.ssh/id_rsa
# 登录 GitHub -> 站点下的 Settings -> Secrets and variables -> Actions -> New repository secret 中添加 3 个常量：
# Name: CTW_SSH_PRIVATE_KEY
# Value: 你的私钥内容（注意不要添加换行符，可以直接从文件复制）

# Name: CTW_SERVER_IP
# Value: 部署服务器的 IP

# Name: CTW_USER
# Value: 部署服务器的 user


# 私钥 CTW_SSH_PRIVATE_KEY 会在 .github/workflows/deploy.yml 的 Secrets 中被用来连接 部署服务器
```

## 编写 GitHub Action 工作流

.github/workflows/**deploy.yml**：

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
      run: ssh ${{ secrets.CTW_USER }}@${{ secrets.CTW_SERVER_IP }} 'bash -s' < ./deploy.sh
```

## 站点仓库的部署脚本

./deploy.sh：

```shell
cd /usr/local/src
rm -rf /usr/local/src/blog

if [ ! "$(command -v git)" ]; then
    dnf install -y git
    git config --global user.email "templechan@126.com"
    git config --global user.name "templechan"
    # 设置 GitHub 国内镜像源
    git config --global url."https://bgithub.xyz/".insteadOf https://github.com/
fi

# 如果失效，则删除旧的，设置的新的
# git config --global --unset url."https://bgithub.xyz/".insteadOf https://github.com/
# git config --global url."https://kkgithub.com/".insteadOf https://github.com/
git clone -b main https://github.com/templechan/blog.git

if [ -d /usr/local/src/blog ]; then
    cd /usr/local/src/blog
    if [ ! "$(command -v mogrify)" ]; then
        # 安装图片压缩包 ImageMagick
        dnf install -y ImageMagick-7.1.1.26-2.oc9 bc parallel
        # 配置ImageMagick策略文件
        sed -i '/<policy domain="coder" rights="read|write"/!b;n;c\ \ <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="memory"/s/value=".*"/value="1GiB"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="disk"/s/value=".*"/value="4GiB"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="width"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="height"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
    fi

    # 手动压缩图片资源（会覆盖源文件，注意保留源文件）
    # 压缩规则: 
    # 1. 超过 500KB 的图片才会压缩
    # 2. 根据 图片大小 动态控制压缩比例，最后都控制在 300KB 左右
    # 3. 可压缩 PNG,JPG,JPEG,WEBP 的图片
    find ./static/img/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 4 --bar 'f="{}";s=$(stat -c%s "$f");if [ $s -gt 512000 ];then q=$(echo "scale=0;60-30*l($s/512000)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<10?10:q>75?75:q));case "${f##*.}" in png) p="-quality $((q-25)) -define png:compression-level=9 -colors 128" ;; jpg|jpeg) p="-quality $((q-10)) -sampling-factor 4:2:0" ;; webp) p="-quality $((q-20)) -define webp:method=6" ;; esac;mogrify $p "$f";fi'

    if [ ! "$(docker ps -a -f "name=blog" --quiet)" ]; then
        if [ ! "$(docker images -q blog)" ]; then
            # 构建镜像
            docker build -t blog .
        fi
        # 创建并运行容器
        docker run -d --restart=always -p 81:80 -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static -v ./public:/blog/public --name blog blog
    else
        docker restart blog
    fi
        
    # 等待 5 秒，确保容器已启动
    sleep 5
    # 修复 RSS
    sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/index.xml
    sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/sitemap.xml
    # 修复站点的动态链接
    sed -i 's#http://212\.64\.16\.86:80#https://blog.climbtw.com#g' \
    ./public/index.html \
    ./public/categories/solutions/index.html \
    ./public/categories/tech/index.html

    # 推送索引到 Algolia
    if [ ! "$(command -v atomic-algolia)" ]; then
        npm install atomic-algolia
    fi
    npx atomic-algolia

    # Nginx 如果配置好了，可直接访问网站查看部署更新
fi
```

# SEO

## 搜索引擎收录

- 百度收录官网：<https://ziyuan.baidu.com/linksubmit/index>
    - 百度的 sitemap 提交权限需要和客服去申请。
- 必应收录官网：<https://www.bing.com/webmasters/sitemaps>
- 谷歌收录官网：<https://search.google.com/search-console/sitemaps>

## 修复站点地图

- 本文使用 `hugo server --disableLiveReload --baseURL http://212.64.16.86 -p 80` 的方式 部署服务器站点， 这样 Hugo 生成的 动态链接 的头部会变成 `https://212.64.16.86:80`，导致在生成 站点地图 **index.xml** 和 **sitmap.xml** 时，谷歌会判定 非域名 的链接 无效。
    - 解决方案：
        - 用 VSCode 手动批量替换 ip 为 域名 的 站点地图文件 **index.xml** 和 **sitmap.xml**：
            - 比如：`http://212.64.16.86:80` 替换为 `https://blog.climbtw.com`
        - 可以在 启动站点容器 的命令结束后，通过 命令 替换 站点地图文件中的 `https://212.64.16.86:80` 为 `https://blog.climbtw.com`
            - 同时也修复下站点的动态链接
            - 修复命令：

```shell
# 等待 5 秒，确保容器已启动
sleep 5
# 修复 RSS
sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/index.xml
sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/sitemap.xml
# 修复站点的动态链接
sed -i 's#http://212\.64\.16\.86:80#https://blog.climbtw.com#g' \
./public/index.html \
./public/categories/solutions/index.html \
./public/categories/tech/index.html
```
