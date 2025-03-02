---
layout: post
title: "VS Code 使用记录"
description: "VS Code 下载安装，常用插件 等。"
author: "谌中钱"
date: "2025-01-14"
image: "/img/temple-404-bg.png"
categories: [ "Tech" ]
tags:
  - "Tools"
---

<br />
<br />

- [简介安装](#简介安装)
  - [简介](#简介)
  - [安装](#安装)
    - [Window 环境](#window-环境)
- [配置文件 settings.json 记录](#配置文件-settingsjson-记录)
- [代码片段记录](#代码片段记录)
  - [Markdown](#markdown)
  - [Hugo博客文章模板](#hugo博客文章模板)
- [常用插件](#常用插件)
  - [基础插件](#基础插件)
  - [Markdown 插件](#markdown-插件)
    - [Markdown Preview Enhanced](#markdown-preview-enhanced)
      - [配置记录](#配置记录)
      - [TOC](#toc)
        - [内部生成目录](#内部生成目录)
        - [HTML边栏目录](#html边栏目录)
      - [断页符](#断页符)
      - [自定义CSS](#自定义css)
      - [Puppeteer导出PDF](#puppeteer导出pdf)
        - [代码背景显示问题修复](#代码背景显示问题修复)
        - [显示页码](#显示页码)
        - [图片调整大小](#图片调整大小)
      - [导出 HTML](#导出-html)
    - [markdownlint](#markdownlint)

# 简介安装

## 简介

> VS Code 是一款代码编辑器。

- 官网：<https://code.visualstudio.com/>

## 安装

### Window 环境

- 下载地址：<https://code.visualstudio.com/Download>
- 下载安装包完成后，直接运行安装即可。
- 可使用 微软，GitHub 账户登录，用于同步软件设置。

# 配置文件 settings.json 记录

```json
{
    "workbench.startupEditor": "none",
    "editor.minimap.enabled": false,
    "markdown-preview-enhanced.enableExtendedTableSyntax": true,
    "markdown-preview-enhanced.previewTheme": "atom-light.css",
    "markdown-preview-enhanced.codeBlockTheme": "atom-light.css",
    "markdown-preview-enhanced.revealjsTheme": "simple.css",
    "markdown-preview-enhanced.enableScriptExecution": true, // HTML边栏目录显示
    "markdown-preview-enhanced.printBackground": true, // Puppeteer导出PDF的代码背景显示问题修复
    "editor.codeActionsOnSave": {
        "source.fixAll.markdownlint": "explicit" // 自动格式化md文档
    },
    "markdownlint.config": {
        "MD024": false, // md允许同名标题
        "MD025": false, // md允许多个一级菜单
        "MD033": false // md允许换行 <br />
    },
}
```

# 代码片段记录

## Markdown

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

# {ignore=true}

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->
```

## Hugo博客文章模板

```markdown
---
layout: post
title: "VS Code 使用记录（实时更新）"
description: "VS Code 下载安装，常用插件 等。"
author: "谌中钱"
date: "2025-01-14"
image: "/img/temple-404-bg.png"
categories: [ "Tech" ]
tags:
  - "Tools"
---

<br />
<br />

内部目录位置...
```

# 常用插件

## 基础插件

- **Chinese (Simplified) (简体中文) Language**：此中文（简体）语言包为 VS Code 提供本地化界面。
- **Open in Browser**：提供 在浏览器中打开文件 的快捷功能。
- **vscode-pdf**：在 VS Code 中打开 PDF 文件。
- **Git History**：查看 Git 提交历史。
- **Even Better TOML**：TOML语言支持扩展。
- **Docker**：使从 VS Code 构建、管理和部署容器化应用程序变得容易。它还提供了在容器中 Node.js、Python 和 .NET 的一键调试。

## Markdown 插件

### Markdown Preview Enhanced

> Markdown 功能拓展插件。

- 官网：<https://shd101wyy.github.io/markdown-preview-enhanced/#/zh-cn/>

#### 配置记录

settings.json 配置：

```json
{
    "markdown-preview-enhanced.enableExtendedTableSyntax": true,
    "markdown-preview-enhanced.previewTheme": "atom-light.css",
    "markdown-preview-enhanced.codeBlockTheme": "atom-light.css",
    "markdown-preview-enhanced.revealjsTheme": "simple.css",
    "markdown-preview-enhanced.enableScriptExecution": true, // HTML边栏目录显示
    "markdown-preview-enhanced.printBackground": true, // Puppeteer导出PDF的代码背景显示问题修复
}
```

Front-Matter 记录：

```yaml
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

#### TOC

##### 内部生成目录

```markdown
# VS Code {ignore=true}

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->
```

##### HTML边栏目录

settings.json 配置：

```json
{
    "markdown-preview-enhanced.enableScriptExecution": true, // HTML边栏目录显示
}
```

Front-Matter 配置：

```yaml
---
# HTML边栏目录
toc:
depth_from: 1
depth_to: 6
---
```

#### 断页符

`<!-- pagebreak -->`

#### 自定义CSS

> cmd-shift-p 然后运行 `Markdown Preview Enhanced: Customize Css` 命令打开 style.less 文件。

style.less

```less
/* Please visit the URL below for more information: */
/*   https://shd101wyy.github.io/markdown-preview-enhanced/#/customize-css */

.markdown-preview.markdown-preview {
    // modify your style here
    // eg: background-color: blue;
}
```

#### Puppeteer导出PDF

Front-Matter 配置：

```yaml
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
---
```

##### 代码背景显示问题修复

settings.json 配置：

```json
{
    "markdown-preview-enhanced.printBackground": true, // Puppeteer导出PDF的代码背景显示问题修复
}
```

##### 显示页码

Front-Matter 配置

```yaml
---
puppeteer:
    displayHeaderFooter: true
    headerTemplate: '<span class="pageNumber"></span>'
    footerTemplate: '
        <div style="font-size: 10px; width: 100%; text-align: center;">
        <span class="pageNumber"></span> / 
        <span class="totalPages"></span>
        </div>
        '
---
```

##### 图片调整大小

自定义CSS style.less：

```less
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

使用：

```markdown
![img.png](./img.png#w60)
```

#### 导出 HTML

Front-Matter 配置：

```yaml
---
# HTML边栏目录设置
toc:
  depth_from: 1
  depth_to: 6

html:
    toc: true # 边栏目录常驻
    embed_local_images: false
---
```

### markdownlint

> Markdown / CommonMark linting 和 样式检查。

settings.json 配置：

```json
{
    "editor.codeActionsOnSave": {
        "source.fixAll.markdownlint": "explicit" // 自动格式化md文档
    },
    "markdownlint.config": {
        "MD024": false, // md允许同名标题
        "MD025": false, // md允许多个一级菜单
        "MD033": false // md允许换行 <br />
    },
}
```
