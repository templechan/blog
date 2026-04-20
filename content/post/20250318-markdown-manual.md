---
layout: post
title: Markdown 使用手册
subtitle: 
description: 涉及 Markdown 常用语法 等。
author: 谌中钱
date: 2025-03-18
lastMod: 
image: img/post-bg-default.png
categories: 
- tool
tags: 
- 编程语言
slug: markdown-manual
weight:
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [Markdown 使用手册](#markdown-使用手册)
  - [1 简介](#1-简介)
  - [2 常用语法](#2-常用语法)

<!-- /code_chunk_output -->


# Markdown 使用手册

## 1 简介

> Markdown 是一种轻量级 标记语言，它允许人们使用易读易写的纯文本格式编写文档，Markdown 文件的后缀名便是 ".md"。

- 参考教程：<a href="https://markdown.com.cn/" target="_blank">`https://markdown.com.cn`</a>
- 通用规范：<a href="https://commonmark.org/" target="_blank">`https://commonmark.org`</a>

## 2 常用语法

||Markdown 语法|备注|
|:-:|:-|:-|
|标题|`# H1`<br />`## H2`<br />`###### H6`|1 标题ID，可用于链接直接定位到标题：<br />`# H1 {#headid}`|
|斜体|`*text*`|-|
|粗体|`**text**`|-|
|删除线|`~~The world is flat.~~`|-|
|换行|`<br />`|-|
|分隔线|`---`|-|
|转义字符|`\`|-|
|引用块|`> text`|-|
|链接|`[text](https://www.example.com#headid "title")`<br />`[text](#headid "title")`|1 引用类型：<br />`[hobbit-hole][1]`<br />`[1]: https://www.example.com "title"`<br /><br />2 网址，Email地址：<br /> `<https://markdown.com.cn>`<br />`<fake@example.com>`|
|图片|`![alt text](/assets/img/image.jpg "title")`|-|
|图片链接|`[![alt text](/assets/img/image.jpg "title")](https://www.example.com#headid)`|-|
|列表|有序列表：<br />`1. First item`<br />`2. Second item`<br />无序列表：<br />`- First item`<br />`- Second item`|在列表中嵌套其他元素：<br />缩进一个制表符，上下各空一行<br /><br />1 引用块：<br />`* Here's the second list item.`<br /><br />`> A blockquote would look great below the second list item.`<br /><br />`* And here's the third list item.`<br /><br />2 代码块：<br />`* Here's the second list item.`<br /><br />`` ```json``<br />`{}`<br />`` ``` ``<br /><br />`* And here's the third list item.`|
|表格|`\|Syntax\|Description\|`<br />`\|-:\|:-:\|`<br />`\|>\|Title\|`<br />`\|Header\|Title\|`<br />`\|^\|Title\|`|1 单元格合并：<br />`>`：左右合并<br />`^`：上下合并|
|代码|1 代码行：\`code\`<br />2 代码块：<br />` ```json `<br />`code`<br />` ``` `|-|
|使用 Emoji 表情|1. 复制和粘贴表情符号：`❤️`<br />2. 使用表情符号简码：`:cupid:` => :cupid:|1. 表情符号仓库：<a href="https://emojipedia.org/zh" target="_blank">`https://emojipedia.org/zh`</a><br />2. 表情符号简码列表：<a href="https://gist.github.com/rxaviers/7360908" target="_blank">`https://gist.github.com/rxaviers/7360908`</a><br />|