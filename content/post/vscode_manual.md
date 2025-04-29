---
layout: single
title: "Visual Studio Code 使用手册"
description: "VS Code 安装，常用插件 等。"
author: "谌中钱"
date: "2025-02-07"
image: "/img/temple_404_bg.jpg"
categories: [ "tech" ]
tags:
  - "tools"
ogurl: "https://blog.climbtw.com/post/vscode_manual"
---

<br />
<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [简介](#简介)
- [安装 VS Code](#安装-vs-code)
  - [Windows 下](#windows-下)
- [相关文件备份](#相关文件备份)
  - [VS Code 配置文件记录](#vs-code-配置文件记录)
  - [代码片段](#代码片段)
    - [Markdown](#markdown)
      - [MPE 本地](#mpe-本地)
      - [Hugo 文章模板](#hugo-文章模板)
- [常用插件](#常用插件)
  - [基础插件](#基础插件)
    - [Chinese (Simplified) (简体中文) Language](#chinese-simplified-简体中文-language)
    - [Open in Browser](#open-in-browser)
    - [vscode-pdf](#vscode-pdf)
    - [Git History](#git-history)
  - [语言支持](#语言支持)
    - [Markdown Preview Enhanced](#markdown-preview-enhanced)
      - [自定义CSS](#自定义css)
        - [图片调整大小](#图片调整大小)
    - [markdownlint](#markdownlint)
    - [markmap 思维导图](#markmap-思维导图)
      - [在 Hugo 中使用 思维导图 流程](#在-hugo-中使用-思维导图-流程)
    - [Even Better TOML](#even-better-toml)
    - [Docker](#docker)
  - [远程开发](#远程开发)
    - [Remote - SSH](#remote---ssh)

<!-- /code_chunk_output -->

# 简介

> VS Code 是一款代码编辑器。

- VS Code 官网: <https://code.visualstudio.com>

# 安装 VS Code

## Windows 下

1. 下载地址：<https://code.visualstudio.com/docs/?dv=win64user>
2. 下载安装包完成后，直接运行安装即可。

# 相关文件备份

## VS Code 配置文件记录

settings.json

```json
{
    "workbench.startupEditor": "none", // 隐藏启动提示页
    "security.workspace.trust.enabled": false, // 关闭工作区信任
    "editor.minimap.enabled": false, // 隐藏代码小地图
    "editor.detectIndentation": false, // 关闭 自动检测 缩进大小
    "git.enableSmartCommit": true, // 在没有暂存更改时，提交所有更改
    "git.confirmSync": false, // 关闭 同步 Git 存储库前确认
    "markdown-preview-enhanced.previewTheme": "atom-light.css", // MPE 预览主题
    "markdown-preview-enhanced.codeBlockTheme": "atom-light.css", // MPE 代码块主题
    "markdown-preview-enhanced.revealjsTheme": "simple.css", // MPE 幻灯片主题
    "markdown-preview-enhanced.enableExtendedTableSyntax": true, // MPE 开启 表格扩展语法
    "markdown-preview-enhanced.enableScriptExecution": true, // MPE 开启脚本运行，让 HTML 边栏目录正常显示
    "markdown-preview-enhanced.printBackground": true, // MPE 修复 Puppeteer 导出 PDF 的代码背景显示问题
    "editor.codeActionsOnSave": {
        "source.fixAll.markdownlint": "explicit", // markdownlint 自动格式化 md 文档
    },
    "markdownlint.config": { // markdownlint 格式化规则
        "MD007": false, // 允许 md 缩进为 4 个空格
        "MD024": false, // 允许 md 同名标题
        "MD025": false, // 允许 md 多个一级菜单
        "MD033": false, // 允许 md 换行 <br />
    },
}
```

## 代码片段

### Markdown

#### MPE 本地

markdown:

```markdown
---
# Puppeteer导出PDF
puppeteer:
    timeout: 3000
    displayHeaderFooter: true
    headerTemplate: '<span class="pageNumber"></span>'
    footerTemplate: '
        <div style="font-size: 10px; width: 100%; text-align: center;">
        <span class="pageNumber"></span> / 
        <span class="totalPages"></span>
        </div>
        '

# HTML边栏目录设置
toc:
    depth_from: 1
    depth_to: 6

html:
    toc: true # 边栏目录常驻
    embed_local_images: false
---

# VS Code 使用记录 {ignore=true}

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->
```

#### Hugo 文章模板

hugo:

```markdown
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
```

# 常用插件

## 基础插件

### Chinese (Simplified) (简体中文) Language

> 此中文（简体）语言包为 VS Code 提供本地化界面。

### Open in Browser

> 提供 在浏览器中打开文件 的快捷功能。

### vscode-pdf

> 在 VS Code 中打开 PDF 文件。

### Git History

> 查看 Git 提交历史。

## 语言支持

### Markdown Preview Enhanced

> Markdown 功能拓展插件。

- MPE 官方文档：<https://shd101wyy.github.io/markdown-preview-enhanced/#/zh-cn/>

#### 自定义CSS

> Ctrl-Shift-P，然后运行 `Markdown Preview Enhanced: Customize Css` 命令，打开 style.less 文件。

##### 图片调整大小

style.less

```css
.markdown-preview.markdown-preview {
    img{
        width: 60%;
        padding-left: 20%;
    }

    img[src*="#w100"] {
        width: 100%;
    }

    img[src*="#w80"] {
        width: 80%;
    }

    img[src*="#w60"] {
        width: 60%;
    }

    img[src*="#w50"] {
        width: 50%;
    }

    img[src*="#w30"] {
        width: 30%;
    }

    img[src*="#w20"] {
        width: 20%;
    }

    img[src*="#w10"] {
        width: 10%;
    }
}
```

调整图片大小 方式:

```markdown
![img.png](./img.png#w60)
```

### markdownlint

> Markdown / CommonMark linting 和 样式检查。

### markmap 思维导图

> 使用 思维导图 可视化您的 Markdown，可导出为 SVG 图形。

- markmap 官网：<https://markmap.js.org/>
- markmap 在线转换地址: <https://markmap.js.org/repl>

#### 在 Hugo 中使用 思维导图 流程

1. 通过 markmap 的 在线转换 或 **VSCode 插件** 将 Markdown 转换成 思维导图 后，导出为 SVG 图形。
2. 在 Markdown 需要使用 思维导图 的地方引入 SVG 图形即可。

### Even Better TOML

> 由 Taplo 支持的 TOML 语言支持扩展。

### Docker

> 使从 VS Code 构建、管理和部署容器化应用程序变得容易。它还提供了在容器中 Node.js、Python 和 .NET 的一键调试。

## 远程开发

### Remote - SSH

- 连接到 linux
    - `cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`
- 连接到 WSL
