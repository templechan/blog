---
layout: post
title: "Markdown 指南"
description: "Markdown 语法简记。"
author: "谌中钱"
date: "2025-01-16"
image: "/img/temple-404-bg.png"
categories: [ "Tech" ]
tags:
  - "Front-end"
---

<br />
<br />

- [简介](#简介)
- [常用语法](#常用语法)

# 简介

> Markdown 是一种轻量级 标记语言，它允许人们使用易读易写的纯文本格式编写文档，Markdown 文件的后缀名便是 ".md"。

- 参考教程：<https://markdown.com.cn/>
- 通用规范：<https://commonmark.org/>

# 常用语法

|元素|Markdown 语法|备注|
|---|---|---|
|标题|`# H1`<br />`## H2`<br />`###### H6`|1. 标题ID，可用于链接定位：<br />`# H1 {#headid}`|
|粗体|`**text**`|-|
|斜体|`*text*`|-|
|换行|`<br />`|-|
|分隔线|`---`|-|
|删除线|`~~The world is flat.~~`|-|
|转义字符|`\`|-|
|标记|`==marked==` => ==marked==|-|
|引用块|`> text`|-|
|缩略词|`The HTML specification`<br />`*[HTML]: Hyper Text Markup Language`|-|
|上下标|上标：`30^th^` => 30^th^<br />下标：`H~2~O` => H~2~O|-|
|脚注|`Here's a sentence with a footnote. [^1]`<br />`[^1]: This is the footnote.`|-|
|链接|`[text](https://www.example.com#headid "title")`<br />`[text](#headid "title")`|1. 引用类型：<br />`[hobbit-hole][1]`<br />`[1]: https://www.example.com "title"`<br /><br />2. 网址，Email地址：<br /> `<https://markdown.com.cn>`<br />`<fake@example.com>`|
|图片|`![alt text](/assets/img/image.jpg "title")`<br />`[![alt text](/assets/img/image.jpg "title")](https://www.example.com#headid)`|-|
|列表|有序列表：<br />`1. First item`<br />`2. Second item`<br />无序列表<br />`- First item`<br />`- Second item`|在列表中嵌套其他元素：<br />缩进一个制表符，上下各空一行<br /><br />1. 引用块：<br />`* Here's the second list item.`<br /><br />`> A blockquote would look great below the second list item.`<br /><br />`* And here's the third list item.`<br /><br />2. 代码块：<br />`* Here's the second list item.`<br /><br />`` ```json``<br />`{}`<br />`` ``` ``<br /><br />`* And here's the third list item.`|
|表格|`\|Syntax\|Description\|`<br />`\|---:\|:---:\|`<br />`\|>\|Title\|`<br />`\|Header\|Title\|`<br />`\|^\|Title\|`|-|
|代码|代码行：`` ` code ` `` 或 ` `` code `` `<br />代码块：<br />` ```json `<br />`code`<br />` ``` `|-|
|任务列表|`- [x] Write the press release`<br />`- [] Write the press release`<br />`- [] Write the press release`|-|
|使用 Emoji 表情|1. 复制和粘贴表情符号：`❤️`<br />2. 使用表情符号简码：`:cupid:` => :cupid:|1. 表情符号仓库：<https://emojipedia.org/zh><br />2. 表情符号简码列表：<https://gist.github.com/rxaviers/7360908><br />|
