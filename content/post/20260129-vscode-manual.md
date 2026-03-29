---
layout: post
title: Visual Studio Code 使用手册
subtitle: 
description: 涉及 VSCode 常用插件，配置 等。
author: 谌中钱
date: 2026-01-29
lastMod: 
image: img/post-bg-default.png
categories: 
- tool
tags: 
- IDE
slug: vscode-manual
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 简介安装](#1-简介安装)
- [2 常用插件](#2-常用插件)
  - [2.1 Chinese (Simplified) (简体中文) Language Pack for Visual Studio Code](#21-chinese-simplified-简体中文-language-pack-for-visual-studio-code)
  - [2.2 Comment Translate](#22-comment-translate)
  - [2.3 Markdown Preview Enhanced](#23-markdown-preview-enhanced)
  - [2.4 markmap](#24-markmap)
- [3 插件配置同步](#3-插件配置同步)

<!-- /code_chunk_output -->


## 1 简介安装

> VSCode 是一款代码编辑器。

- 官网: <a href="https://code.visualstudio.com" target="_blank">`https://code.visualstudio.com`</a>
- 安装：在官网直接下载安装即可使用。

## 2 常用插件

### 2.1 Chinese (Simplified) (简体中文) Language Pack for Visual Studio Code

> 此中文（简体）语言包为 VS Code 提供本地化界面。

### 2.2 Comment Translate

> 提供 悬浮，划词 翻译等功能。

- 插件中文文档：<a href="https://github.com/intellism/vscode-comment-translate/blob/HEAD/doc/README_ZH.md" target="_blank">`https://github.com/intellism/vscode-comment-translate/blob/HEAD/doc/README_ZH.md`</a>
- 作者插件配置 settings.json：

```json
{
    "commentTranslate.targetLanguage": "zh-CN",
    "commentTranslate.source": "Bing",
    "commentTranslate.maxTranslationLength": 1000
}
```

### 2.3 Markdown Preview Enhanced

> Markdown 功能拓展插件，可提供 目录 自动生成 等功能。

- 插件中文文档：<a href="https://shd101wyy.github.io/markdown-preview-enhanced/#/zh-cn/" target="_blank">`https://shd101wyy.github.io/markdown-preview-enhanced/#/zh-cn/`</a>


### 2.4 markmap 

> 使用 思维导图 可视化您的 Markdown，可导出为 SVG 图形。

- 插件中文文档：<a href="https://markmap.js.org/docs/markmap" target="_blank">`https://markmap.js.org/docs/markmap`</a>


## 3 插件配置同步

> 可以登录 Microsoft 账号 或者 GitHub 账号，同步 插件 和 配置 到云端。

- 需要注意的是：
    - Microsoft 账号在 开启梯子 的时候，无法登录。
    - GitHub 账号在 没有开启梯子 的时候，登录不稳定。