---
layout: post
title: "Interview 1"
description: "-"
author: "谌中钱"
date: "2025-01-01"
image: "/img/temple-404-bg.png"
categories: [ "Solutions" ]
---

<br />
<br />

- [HTML](#html)
  - [基础模板](#基础模板)
  - [H5 新增标签](#h5-新增标签)
    - [语义化标签](#语义化标签)
    - [图形标签](#图形标签)
    - [媒体标签](#媒体标签)
    - [表单标签](#表单标签)
  - [H5 API](#h5-api)
    - [拖放](#拖放)
    - [Web Workers](#web-workers)
    - [本地缓存](#本地缓存)
      - [manifest](#manifest)
      - [Service Worker 和 Cache API](#service-worker-和-cache-api)
    - [本地存储](#本地存储)
  - [常见面试题](#常见面试题)
- [CSS](#css)
  - [页面布局](#页面布局)
    - [实现两栏布局，右侧自适应](#实现两栏布局右侧自适应)
    - [三栏布局中间自适应](#三栏布局中间自适应)
  - [定位](#定位)
  - [BFC](#bfc)
  - [常见面试题](#常见面试题-1)
- [JS](#js)
  - [数据类型](#数据类型)
  - [作用域](#作用域)
  - [闭包](#闭包)
  - [原型链](#原型链)
  - [继承](#继承)
  - [DOM/BOM 操作](#dombom-操作)
  - [Ajax](#ajax)
  - [事件循环机制](#事件循环机制)
  - [模块化编程](#模块化编程)
    - [CommonJS](#commonjs)
    - [ES6模块](#es6模块)
  - [ES6+](#es6)
  - [WebSocket](#websocket)
  - [TypeScript](#typescript)
  - [常见面试题](#常见面试题-2)
    - [遍历方法](#遍历方法)
    - [深拷贝和浅拷贝](#深拷贝和浅拷贝)
    - [this/call/apply/bind](#thiscallapplybind)
- [React](#react)
  - [React UI渲染框架的底层机制](#react-ui渲染框架的底层机制)
    - [组件间通信](#组件间通信)
    - [Hooks 需要注意的问题](#hooks-需要注意的问题)
    - [常见面试题](#常见面试题-3)
- [Webpack](#webpack)
- [NodeJS](#nodejs)
- [跨域](#跨域)
- [web 常见漏洞](#web-常见漏洞)
- [Next 服务端渲染](#next-服务端渲染)

# HTML

## 基础模板

```html
<!-- 这里是注释标签... -->
<!-- HTML声明标识 -->
<!DOCTYPE html>
<!-- html容器标签，lang属性设置整个网页的语言，浏览器可识别用于触发翻译 -->
<!-- 中文：zh 英语：en 日语：ja 韩语：ko -->
<html lang="zh">
<!-- 基础信息堆放处 -->
<head>
<!-- 网页编码 -->
<meta charset="UTF-8">
<meta name="description" content="网站描述">
<meta name="keywords" content="网站关键字">
<!-- 搜索引擎搜索方式，index：网页被检索，follow：页面上的链接可以被查询 -->
<meta name="robots" content="index,follow">
<!-- viewport，适配移动端，控制视口的大小和比例 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>网站标签页上的标题</title>

<link rel="stylesheet" href="styles.css">
<!-- async 异步加载，多个script，则谁先下载完执行谁，适用于 不依赖 DOM和其他script的场景 -->
<script src="path/to/your/script.js" async></script> 
<!-- defer 延迟加载，等效于放在body尾部，多个script，等DOM加载完，按顺序执行，适用于 依赖 DOM和其他script的场景 -->
<script src="path/to/your/script.js" defer></script>
<style>
p {
    color: red;
}
</style>
<script>
console.log("Hello, world!");
</script>
</head>

<!-- 网页主体 -->
<body>
<!-- 语义化标签 -->
<header class=""></header>
<nav></nav>
<main>
    <article>
        <section></section>
    </article>
</main>
<aside></aside>
<footer class="" style="color: red;"></footer>

<script src="path/to/your/script.js"></script>
</body>
</html>
```

## H5 新增标签

### 语义化标签

- 定义：使用具有明确语义的 HTML标签 来描述网页的内容和结构，包括 `<header>`、`<footer>`、`<article>` 等。
- 优点：提升网页的可读性、增强可访问性（如屏幕阅读器）、优化搜索引擎排名 等。
- 使用：`<header>`、`<footer>` 使用较多，网页主体还是 `<div>` 为主。

### 图形标签

- `<svg>`：用于创建可缩放矢量图形，可以绘制图形、路径等。
- `<canvas>`：用于在网页中绘制图形，通过 JavaScript 绘制图形、动画等。
  - Canvas API 文档：<https://developer.mozilla.org/zh-CN/docs/Web/API/Canvas_API/Tutorial>
- **区别**：
  - SVG 是基于矢量图形的，使用 xml标签 描述形状和路径。SVG图形是一个对象，如果对象的属性发生改变，浏览器会重新绘制图形‌。
    - 不会失真
    - 不支持事件处理器，无法对单个图形或元素添加事件‌
    - 适合图像密集型的游戏和复杂的动画效果，因为其渲染性能较高‌
  - Canvas 是基于像素的位图图形，绘制完成后，浏览器不再关注它。如果图形位置发生变化，需要重新绘制‌。
    - 会失真
    - 支持事件处理器，可以对单个图形或元素添加事件，适合需要交互的复杂图形应用‌
    - 适合需要频繁重绘的复杂图形和需要保持清晰度的图形，如地图和图标等‌

### 媒体标签

- `<audio>`：用于嵌入音频文件，支持多种格式，如 MP3、OGG 等。
- `<video>`：用于嵌入视频文件，支持多种格式，如 MP4、WebM、Ogg 等。
- `<source>`：用于为 `<video>` 或 `<audio>` 指定一个或多个媒体资源。
- `<track>`：用于为 `<video>` 或 `<audio>` 添加字幕、描述等辅助内容。

### 表单标签

- 数字：`<input type="number">`
- 日期：`<input type="date">`
- 时间：`<input type="time">`
- 日期和时间：`<input type="datetime">` `<input type="datetime-local">`
- 邮件：`<input type="email">`
- URL：`<input type="url">`
- 电话号码：`<input type="tel">`
- 搜索：`<input type="search">`
- 取色器：`<input type="color">`
- 滑块：`<input type="range">`

## H5 API

### 拖放

- **draggable**：被拖放的标签上，是否允许拖放
- **ondragstart**：被拖放的标签上，开始拖放事件，可以传递被拖放标签的参数，如class
>
- **ondrop**：拖放目的标签，开始拖放，可以开始操作 被拖放标签 的移动，如 appendChild
- **ondragover**：拖放目的标签，用来被拖动的标签能够被放置到何处，默认无法被放置到其他元素中，所以需要阻止元素的这种默认的处理方式
  - `event.preventDefault()`

### Web Workers

- Web worker 是运行在后台的 JavaScript，不会影响页面的性能。实现 多线程操作。
  - `postMessage(i)`：后台js脚本中，它用于向 HTML 页面传回一段消息
  - `(new Worker("脚本.js")).onmessage = function(event){}`：来自 脚本的数据 会存储于 event.data 中
- **缺点**：Web Worker 是临时存在的，每次做的事情的结果不能被持久存下来。
  - 所以 **Service Worker 的 出现**：能不能有一个 Worker 线程是一直可以 **持久存在** 的，并且随时准备接收主线程的命令呢？就推出了 **Service Worker**， 在 Web Worker 的基础上加了 **持久离线缓存能力**，可以通过自身的 生命周期 特性保证复杂的工作只处理一次，并且持久缓存处理结果。

### 本地缓存

#### manifest

- **使用**：在 `<head>` 中设置 manifest 指向并创建 index.appcache 文件，包含 **CACHE、NETWORK 和 FALLBACK** 三个部分，用于指定需要 **缓存的文件和资源**、**哪些文件需要在线访问**、以及在 **无法访问某个资源时应使用的备用资源**。
- **更新**： `window.applicationCache.update()`：更新缓存。
- **流程**：
  - 当网络在线时，浏览器识别到 manifest属性 时，如果页面是首次加载，那么会按照该属性指向的文件中的内容进行下载，并缓存到本地。如果在加载页面时，页面已经离线存储，那么浏览器会使用离线存储的资源加载页面，然后对比新旧manifest，如果有更新，将更新后的数据重新缓存
  - 当网络离线时，浏览器直接会使用离线存储的资源加载网页
- **缺点**：维护成本太高，单纯靠配置是非常不灵活的，对动态请求无法处理。

#### Service Worker 和 Cache API

- 工作原理：
  - 注册 Service Worker，脚本.js
  - 脚本.js：
    - 在 **install** 事件的回调中通过 Cache API 缓存静态资源，如 HTML、CSS、JavaScript、图片等。
    - 在 **activate** 事件的回调中，开发者可以清理旧的缓存。
    - 在 **fetch**  事件的回调中，拦截网络请求，并提供自定义响应。这使得即使在离线状态下，也可以从缓存中返回资源。
- 参考：
  - <https://www.cnblogs.com/jaycethanks/p/16502676.html>
  - <https://blog.csdn.net/2401_86900447/article/details/141567364>
  
### 本地存储

- **localStorage**：存储没有截止日期的数据
  - 存：localStorage.lastname = "Gates";
  - 取：localStorage.lastname
- **sessionStorage**：针对一个 session 来存储数据（当关闭浏览器 标签页 时数据会丢失）
- **IndexedDB**：是一个基于 JavaScript 的面向对象数据库。localStorage 和 sessionStorage 不提供搜索功能，不能建立自定义的索引。所以，需要一种新的解决方案，这就是 IndexedDB 诞生的背景。
  - 使用：封装个 IndexDBCache 类，用于增、删、改、查 操作。
    - 参考：<https://blog.csdn.net/weiCong_Ling/article/details/131437456>
- **cookie** 和 **localStorage** 对比：
  - **存储容量**：
    - cookie 的存储容量较小，通常每个cookie的大小不能超过 **4KB** ，且每个域名下最多只能存储 **20 个**cookie。这意味着使用cookie存储大量数据是不切实际的。
    - localStorage 则提供了更大的容量，可以存储大量的数据，包括**字符串、对象和数组**等。具体来说，localStorage的存储容量一般达到 **5MB** 或者更多，这使其更适合用于存储大量数据。
  - **与服务器通信**：
    - cookie 在每次 HTTP请求时 都会自动发送到服务器，这可能会增加不必要的 网络流量，并可能导致**性能下降**。
    - localStorage 的数据则不会随每个请求发送到服务器，这减少了不必要的网络通信，**提高了应用的性能**。
  - **数据存储方式**：
    - cookie 的数据存储在浏览器的内存中，可以设置失效时间，过期后数据将被自动删除。此外，由于cookie会随请求发送到服务器，因此**需要考虑数据的传输安全性**。
    - localStorage 是持久性的，数据可以长期保存在客户端上，直到用户通过特定方式（如**清除浏览器数据**）将其删除。这提供了更稳定的数据存储解决方案。
  - **适用场景**：
    - cookie 主要用于实现 **用户会话跟踪、身份认证** 等功能。它们常用于存储少量的 用户信息 或 会话标识，以便在服务器端 识别特定用户。
    - localStorage 更适合用于存储大量的数据，如 **用户偏好设置、应用程序配置** 等。由于其大容量和持久性的特点，本地存储在这些场景下表现更为出色。

## 常见面试题

- **href 和 src 都是用来引用外部的资源，它们的区别是什么？**
  - `href`：对超文本引用，指向一些网络资源，当浏览器识别到它指向的是文件时，***会并行下载资源，不会阻塞网页的渲染***，常用在 `link`、`a` 标签上。
  - `src`：对资源的引用，它指向的资源会 嵌入 到当前标签所在的位置，如 js 脚本，当浏览器解析当该元素时，***会暂停其他资源的下载和处理，直到该资源加载，编译，执行完毕***。所以js脚本一般放在页面底部。
- **async 和 defer 在 script标签 中的区别是什么？**
  - `async`：异步加载，多个script，则谁先下载完执行谁。***适用于 不依赖 DOM和其他script的场景。***
  - `defer`：延迟加载，等效于放在body尾部，多个script，等DOM加载完，按顺序执行。***适用于 依赖 DOM和其他script的场景。***
- **img 的 alt 属性 与 title 属性 的区别是什么？**
  - alt：给搜索引擎识别，在图像无法显示时的替代文本
  - title：是关于元素的注释信息，主要是给用户解读
- **img 的 srcset 属性有何作用？**
  - 作用：为不同的屏幕分辨率或设备条件指定多种图像源。
  - 使用：为每个图片源指定一个条件，通常是宽度（w）或者像素密度（x）
    - `<img src="image-1000w.jpg" srcset="image-500w.jpg 500w, image-1000w.jpg 1000w, image-1500w.jpg 1500w">`
    - `<img src="image-1x.jpg" srcset="image-1x.jpg 1x, image-2x.jpg 2x, image-3x.jpg 3x">`
  - 参考：<https://blog.csdn.net/lph159/article/details/144210365>
- **label 标签作用及使用方法？**
  - `<label for="username">用户名：</label>`
  - 作用：
    - 提供对 表单元素 的 说明文本
    - 点击标签来聚焦表单控件
- **行内元素、块级元素和空元素分别有哪些？**
  - **行内元素**：只占据必要的宽度，不会另起一行，只能设置水平方向的 margin 和 padding
    - `<span>`，`<a>`，`<img>`，`<input>`，`<textarea>`，`<select>`，`<label>`，`<button>` 等
  - **块级元素**：默认宽度会撑满父元素的宽度，会独占一行，可以设置 width、height，margin 和 padding
    - `<h1>`，`<p>`，`<div>`，`<ul>`，`<table>`，`<form>` 等
  - **空元素**：没有内容的元素
    - `<br>`，`<hr>`，`<meta>`，`<link>`，`<img>`，`<input>` 等
- **iframe 的优点和缺点？**
  - **优点**：
    - 代码重用性高：可以在多个页面中重复使用同一段代码
    - 可以跨域访问：iframe 可以在页面中嵌入来自其他域名的内容，可以实现跨域访问。
  - **缺点**：
    - 安全性问题：由于 iframe 可以跨域访问，可能会导致安全问题，如恶意网站可能会在 iframe 中嵌入钓鱼网站等。
    - SEO 不友好：搜索引擎无法识别 iframe 中的内容
    - 难以控制样式：iframe 中的内容和父页面是独立的，很难控制 iframe 中的样式和布局。
    - 嵌套过多会影响性能：由于 iframe 可以嵌套，嵌套过多可能会导致性能问题。
- **DOCTYPE 声明的作用是什么？如何区分严格模式与混杂模式？**
  - 作用：告诉浏览器如何渲染页面。主要有两种模式：**严格模式** 和 **混杂模式**。
    - 严格模式：又称标准模式，是指浏览器按照 W3C 标准解析代码。
    - 混杂模式：又称怪异模式或兼容模式，是指浏览器用自己的方式解析代码。
  - 区分：浏览器解析时到底使用严格模式还是混杂模式，与网页中的 **文件类型定义DTD** 直接相关。
    - HTML5 没有 DTD，因此也就没有严格模式与混杂模式的区别，HTML5 有相对宽松的语法，实现时，已经尽可能大的实现了向后兼容。
- **渐进增强和优雅降级之间的区别？**
  - **渐进增强**：从最基础的版本开始，确保基本功能，然后逐步增加高级浏览器的效果和交互功能，以提升用户体验。
  - **优雅降级**：一开始就构建完整的功能，然后针对低版本浏览器进行兼容性调整。
  - 使用场景：对于需要广泛兼容的网站（如公共网站），渐进增强可能更为合适；而对于面向较新用户群体的网站（如企业内部网站 或 面向现代浏览器的应用），优雅降级可能更为合适。
- **浏览器乱码的原因是什么？**
  - ***前端文件编码格式不匹配***：
    - 检查所有文件是否都设置了正确的编码，通常都使用 UTF-8 编码。
    - 使用文本编辑器,保存文档为utf-8格式
  - ***字体文件缺失***：需要确保用户的浏览器能够访问到这些字体文件，或者通过CSS引入字体文件。
  - ***数据库编码***：确保数据库的字符集和排序规则与前端代码一致。
  - ***后台数据处理***：需要检查后台代码，确保数据在传输、存储和处理过程中编码格式正确。
  - ***清除浏览器缓存***：有时浏览器缓存中的旧数据可能导致显示问题，包括乱码。

# CSS

## 页面布局

### 实现两栏布局，右侧自适应

- float 左浮左边栏 + 使用 margin-left 撑出内容块做内容展示 + 添加BFC，防止下方元素飞到上方内容，如 overflow: hidden
- flex 弹性布局：父盒子 display: flex，左侧盒子写入宽度，右侧盒子 flex: 1占一份

### 三栏布局中间自适应

- 两边使用 float，中间使用 margin
- 使用 absolute，中间使用 margin
- **圣杯布局**，利用margin负值法：使用圣杯布局首先需要在center元素外部包含一个div，包含div需要设置float属性使其形成一个BFC，并设置宽度为百分之百，这样中间盒子独占一行，左右盒子被挤到下方，让左边的盒子上去要设置margin-left:-100%，让右边的盒子上去要设置margin-left: 负自身宽度
- 使用flex实现 将父级设置为display: flex; justify-content: space-between; 即可

## 定位

- 默认static:表示没有定位
- absolute:表示绝对定位，相对于最近的已定位的祖先元素
- relative:表示相对定位，相对于自身原有位置进行偏移，可能会覆盖其他元素
- 固定定位fixed:相对于视窗来定位。意味着即便页面滚动，它还是会停留在相同的位置

## BFC

- 定义：称为块级格式化环境，一个独立容器，它规定了内部的 块级元素 的布局方式，并且内部的布局与外部的布局互不影响‌‌。
- 特性：
  - **属于同一个BFC的两个相邻容器的上下margin会重叠**（重点）
  - **计算BFC高度时浮动元素也参于计算**（重点）
  - **BFC的区域不会与浮动容器发生重叠**（重点）
  - BFC内的容器在垂直方向依次排列
  - 元素的 margin-left 与其包含块的 border-left 相接触
  - BFC是 独立容器，容器内部元素不会影响容器外部元素
- 功能：
  - **可以利用BFC解决两个相邻元素的上下margin重叠问题**
  - **可以利用BFC解决高度塌陷问题**
  - **可以利用BFC实现多栏布局（两栏、三栏、圣杯、双飞翼等）**
- 触发条件：
  - 根元素（`<html>`）
  - float 值 非none
  - overflow 值 非visible
  - display 值为 inline-block、table-cell、table-caption、flex、inline-flex
  - position 值为 absolute、fixed

## 常见面试题

- **盒子模型的定义？标准盒模型 和 怪异盒模型 的区别？**
  - **盒子模型**：盒子包括 content、padding、border、margin。
    - **标准盒子模型**：元素的 width 和 height 仅指 content 的尺寸，不包括padding、border 和 margin。
    - **怪异盒子模型**：元素的 width 和 height 除了 content 的尺寸，还包括 padding、border，不包括 margin。
    - **设置属性**：box-sizing
      - content-box：标准盒子模型
      - border-box：怪异盒模型
  - **使用**：在实际开发中，大多数现代浏览器默认采用 **标准盒子模型**。然而，由于历史遗留问题，我们有时仍需要处理与旧版IE浏览器的兼容性问题。此时，可以通过设置 box-sizing: border-box; 来模拟怪异盒子模型的行为，从而确保布局的兼容性。
- **CSS 选择器，优先级？**
  - ID选择器（`#myid`），类选择器（`.myclass`），属性选择器（`a[rel="external"]`），伪类选择器（`a:hover，li:nth-child`），标签选择器（`div, h1,p`），兄弟选择器（`h1 + p`），子选择器（`ul > li`），后代选择器（`li a`），通配符选择器（`*`）
  - 优先级：`!important` > 内联样式 > ID选择器 > 类选择器/属性选择器/伪类选择器 > 标签选择器/伪元素选择器 > 关系选择器/通配符选择器
- **说说 em/px/rem/vh/vw 区别？**
  - **px**：绝对单位，页面按精确像素展示
  - **em**：相对单位，基准点为父节点字体的大小，如果自身定义了font-size按自身来计算，整个页面内1em不是一个固定的值
  - **rem**：相对单位，相对的只是 HTML根元素 font-size 的值
  - **vw / vh**：就是根据窗口的宽度，分成100等份，100vw 就表示满宽，同理，vh 则为窗口的高度。主要用于页面视口大小布局，在页面布局上更加方便简单。
- **css中，有哪些方式可以隐藏页面元素？区别?**
  - **`display:none`**：元素在页面上将彻底消失，导致浏览器的重排和重绘，无法响应点击事件。
  - **`visibility:hidden`**：仅仅是隐藏该元素，DOM结果均会存在，只是当时在一个不可见的状态，不会触发重排，但是会触发重绘，无法响应点击事件。
  - **`opacity:0`**：将元素的透明度设置为0后，元素也是隐藏的，不会引发重排，一般情况下也会引发重绘，可以响应点击事件
  - **设置height、width模型属性为0**：如果元素内有子元素或内容，还应该设置其overflow:hidden来隐藏其子元素，无法响应点击事件
  - **`position:absolute`**：将元素移出可视区域 `top: -9999px; left:-9999px;`，特点是 元素不可见，不影响页面布局
- **元素水平垂直居中的方法有哪些？**
  - **行内元素**可设置：text-align: center + line-height
  - **flex布局**：将父元素的display属性设为flex、justify-content和align-items属性都设为center
  - 设置父元素为 **display:table-cell**，子元素设置 display: inline-block。利用vertical和text-align可以让所有的行内块级元素水平垂直居中。
  - **利用定位 + margin:auto** ：子绝父相，设置top、left、right、bottom为0,在设置margin:auto
  - **利用定位 + margin:负值** ：子绝父相，设置left和top为50%，此时位置会偏右自身元素的宽高，再设margin-left和margin-top为自身元素宽高的负一半，实现水平垂直居中。
  - **利用定位 + transform** ：子绝父相，设置left和top为50%，此时位置会偏右自身元素的宽高，再设transform: translateX(-50px) translateY(-50px);
- **伪元素`::before`和`::after`用法**
  - 作用：在真正页面元素内部之前和之后添加新内容。
  - 特点：
    - 伪元素不属于文档，所以js无法操作它
    - 伪元素属于主元素的一部分，因此点击伪元素触发的是主元素的click事件
  - 优点：
    - 减少dom节点数
    - **让css帮助解决部分js问题，如清除浮动**
  - 缺点：
    - 不利于SEO
    - 无法审查元素，不利于调试
- **清除浮动的方式有哪几种？**
  - 添加额外标签 给父级添加 `<div style="clear:both"></div>`
  - 父级添加 overflow 属性，或者设置高度
  - 建立 **伪类选择器** 清除浮动
- **说说 flex box（弹性盒布局模型）,以及适用场景？**
  - **容器属性**：
    - flex-direction：决定主轴的方向 row | row-reverse |column | column-reverse;
    - flex-wrap：决定换行规则 nowrap | wrap |wrap-reverse;
    - flex-flow： flex-direction 属性 和 flex-wrap 属性的简写形式
    - justify-content：对其方式，水平主轴对齐方式
      - space-between：两端对齐，项目之间的间隔都相等
      - space-around：两个项目两侧间隔相等
    - align-items：对齐方式，竖直轴线方向
  - **项目的属性**：
    - flex-grow属性：定义项目的放大比例，默认为0，即使存在空间，也不会放大
    - flex-shrink属性：定义了项目的缩小比例，当空间不足的情况下会等比例的缩小，如果 定义个item 的 flow-shrink 为 0，则为不缩小
    - flex-basis属性：定义了在分配多余的空间，项目占据的空间。
    - flex：是 flex-grow 和 flex-shrink、flex-basis 的简写，默认值为 0 1 auto。
  - **flex 实现 div 左上角、中间、左下角 布局 css**：

    ```css
    display:flex;
    position:relative;
    flex-direction:row;
    justify-content:space-around;
    align-items:center;
    ```

- **CSS3新增了哪些新特性?**
  - **选择器**：主要包括属性选择器、结构伪类选择器、伪元素选择器等
  - **新样式**：border-radius，box-shadow
  - **transition 过渡**：指定为一个或多个CSS属性的过渡效果，多个属性之间用逗号进行分隔
  - **transform 转换**：允许你旋转，缩放，倾斜或平移给定元素
  - **animation 动画**
  - **渐变**：linear-gradient：线性渐变
    - `background-image:linear-gradient(direction, color-stop1, color-stop2, ...);`
  - **flex弹性布局**
- **css3 动画有哪些？**
  - **transition 过渡 实现渐变动画**，过渡简写：`transition: all 2s ease-in 500ms;`
  - **transform 转换 转变动画**
  - **animation 实现自定义动画**：通过 @keyframes 来定义关键帧
- **如果要做优化，CSS提高性能的方法有哪些？**
  - **内联首屏关键CSS**：通过内联css关键代码能够使浏览器在下载完html后就能立刻渲染
  - **资源压缩**：利用webpack等模块化工具，将css代码进行压缩，使文件变小，大大降低了浏览器的加载时间
  - **合理使用选择器**：不要嵌套使用过多复杂选择器
  - **减少使用昂贵的属性**：在页面发生重绘的时候，昂贵属性如 box-shadow / border-radius / filter / 透明度 / :nth-child 等，会降低浏览器的渲染性能
- **浏览器重绘与重排的区别?**
  - **重绘**(Repaint): 当一个元素的外观发生改变，但没有改变布局,重新把元素外观绘制出来的过程，叫做重绘。
  - **重排**/回流（Reflow）：当DOM的变化影响了元素的几何信息，浏览器需要重新计算元素的几何属性，将其安放在界面中的正确位置
  - 当浏览器完成重排之后，将会重新绘制受到此次重排影响的部分。
    - **重排的性能影响更大**，在两者无法避免的情况下，一般我们宁可选择代价更小的 重绘。
  - **避免重绘或者重排**：
    - 集中改变样式，不要一条一条地修改 DOM 的样式。
    - 为动画的 HTML 元件使用 fixed 或 absolute 的 position，那么修改他们的 CSS 是不会reflow 的。
    - 不使用 table 布局。因为可能很小的一个小改动会造成整个 table 的重新布局。
- **什么是响应式设计？响应式设计的基本原理是什么？如何做？**
  - 原理：通过 媒体查询 检测不同的设备屏幕尺寸做处理，为了处理移动端，页面头部必须有 meta 声明 viewport
  - 方式：
    - 媒体查询
    - 百分比
    - vw/vh
    - rem
  - 优点：面对不同分辨率设备灵活性强，能够快捷解决多设备显示适应问题
  - 缺点：
    - 仅适用布局、信息、框架并不复杂的部门类型网站
    - 兼容各种设备工作量大，效率低下
- **让 Chrome 支持小于 12px 的文字方式有哪些？**
  - zoom：变焦，可以改变页面上元素的尺寸，属于真实尺寸
    - zoom:0.5，表示缩小到原来的一半
  - -webkit-transform:scale()：用transform:scale()这个属性进行放缩
- **说说对Css预编语言的理解？有哪些区别?**
  - CSS 作为一门标记性语言，语法相对简单，但同时也带来一些问题。需要书写大量看似没有逻辑的代码，不方便维护及扩展，不利于复用，Css预处理器便是针对上述问题的解决方案。
  - 常见的：sass，less，stylus
  - 功能：**变量**，**嵌套**，**混入** 等。
- **如何实现单行／多行文本溢出的省略样式？**
  - 单行：

    ```css
    text-overflow: ellipsis; //规定当文本溢出时，显示省略符号来代表被修剪的文本
    white-space: nowrap：// 设置文字在一行显示，不能换行
    overflow: hidden：// 文字长度超出限定宽度，则隐藏超出的内容
    ```

  - 多行：基于行数截断

    ```css
    -webkit-line-clamp: 2：// 用来限制在一个块元素显示的文本的行数，为了实现该效果，它需要组合其他的WebKit属性）
    display: -webkit-box; // 和1结合使用，将对象作为弹性伸缩盒子模型显示
    -webkit-box-orient:vertical; // 和1结合使用 ，设置或检索伸缩盒对象的子元素的排列方式
    
    text-overflow: ellipsis; // 多行文本的情况下，用省略号“…”隐藏溢出范围的文本
    overflow:hidden; // 文本溢出限定的宽度就隐藏内容
    ```

- **如何画一条 0.5px 的线**
  - 采用transform: scale()的方式
  - 使用 boxshadow：设置 box-shadow 的第二个参数为 0.5px ，表示阴影垂直方向的偏移为 0.5px。

    ```css
    height: 1px;
    box-shadow: 0 0.5px 0 #000;
    ```

- **CSS如何画一个三角形？**

  ```css
  /*记忆口诀：盒子宽高均为零，三面边框皆透明。 */
  div:after{
      position: absolute;
      width: 0px;
      height: 0px;
      content: " ";
      border-right: 100px solid transparent;
      border-top: 100px solid #ff0;
      border-left: 100px solid transparent;
      border-bottom: 100px solid transparent;
  }
  ```

- **如何使用 CSS 完成视差滚动效果?**
  - 容器设置上 **transform-style: preserve-3d** 和 **perspective: xpx**，那么处于这个容器的子元素就将位于3D空间中，
  - 子元素设置不同的 **transform: translateZ()**，这个时候，不同元素在 3D Z轴方向距离屏幕（我们的眼睛）的距离也就不一样
  - **滚动滚动条**，由于子元素设置了不同的 transform: translateZ()，那么他们滚动的上下距离 **translateY 相对屏幕（我们的眼睛）**，也是不一样的，这就达到了滚动视差的效果

# JS

## 数据类型

- 基本类型（值类型）：Undefined、Null、Boolean、Number、String
- 复杂类型（引用类型）
  - Object、Array、Date、RegExp、Function
  - 基本包装类型：Boolean、Number、String
  - 单体内置对象：Global、Math
- es6 语法新增：Symbol、BigInt 数据类型
>
- JS 类型检测方式：
  - **typeof**：能判断所有值类型，函数。不可对 null、对象、数组进行精确判断，因为都返回 object
  - **instanceof**：主要用于检测引用类型，根据对象的原形链往上找，如果原形链上有右边函数.prototype，返回true;否则返回false
  - **Object.prototype.toString.call()**：
    - 由于原形链的检测有漏洞(原型是可以改变的)，所以会造成检测结果不准确，所以可以采用此种形式。
    - 所有原始数据类型都是能判断的，还有 Error 对象，Date 对象等。

## 作用域

- 定义：作用域就是 变量与函数 的 可访问范围，控制着 变量与函数 的 可见性 和 生命周期。
- 变量的作用域有 **全局作用域** 和 **局部作用域** 两种。
  - ES6中新增 **块级作用域**。

## 闭包

- 定义：闭包最直接的表现形式是内部函数可以访问外部函数的变量。
- 应用：实现数据封装、状态保持
- 优点：
  - 数据私有性
  - 持续状态
  - 可以在内存中维护一个变量
- 缺点：
  - 闭包会常驻内存，会增大内存使用量，导致一定程度上的内存泄露
    - 解决办法：将函数设置为 null
  - 性能开销：闭包需要保持对作用域链的引用，它在某些情况下可能会增加性能开销。
  - 调试困难

## 原型链

- 定义：对象通过隐式原型( `__proto__` )属性指向其构造函数的原型对象( prototype )，进而通过原型对象( prototype )的隐式原型( `__proto__` )属性指向更高层级的原型对象( prototype )，最终指向null而停止所形成的链条，则称其为原型链。

## 继承

- 原型链继承：让新实例的原型是另一个构造函数的实例
  - 原型链继承原型上的属性和方法
- 构造函数继承
  - 构造函数继承实例属性
- 组合继承：上面结合
- 原型式继承
- 寄生式继承
- 寄生组合式继承

## DOM/BOM 操作

- DOM:
  - 节点操作
  - DOM事件
- BO 常用对象
  - window 对象
  - Navigator 对象
  - History 对象
  - Location 对象
  
## Ajax

```js
// 创建 XMLHttpRequest 对象
let xhr = new XMLHttpRequest();

// 设置请求类型和 URL
xhr.open('GET', 'server/data.json');
// 设置响应处理函数
xhr.onreadystatechange = function() {
    if (xhr.readyState === XMLHttpRequest.DONE) {  // 请求完成
        if (xhr.status === 200) {                  // HTTP 状态码 200: 成功
            console.log(xhr.responseText);
        } else {
            console.error('Request failed');
        }
    }
};
// readyState
// 0: 请求未初始化
// 1: 服务器连接已建立
// 2: 请求已接收
// 3: 请求处理中
// 4: 请求已完成，且响应已就绪

// 发送请求
xhr.send();
```

## 事件循环机制

- 宏任务：
  - setTimeout、setInterval
  - I/O 操作（如文件读写、网络请求）
  - DOM 事件回调（如点击事件）
  - script 标签中的同步代码（整体作为一个宏任务）
  - setImmediate（Node.js 独有）
- 微任务：
  - Promise 的 then/catch/finally 回调
  - process.nextTick（Node.js 环境，优先级最高）
  - MutationObserver（浏览器环境）
- **循环顺序**：
  - **同步代码优先执行**：所有同步代码是事件循环的起点。
  - **微任务队列必须清空**：每次执行完一个宏任务后，会立即清空所有微任务。
  - **宏任务按队列顺序执行**：每次事件循环只执行一个宏任务，避免长时间阻塞。
  - 微任务可“无限嵌套”：如果在微任务中又产生了新的微任务，这些新任务会在当前循环中被执行。
- 注意：
  - 避免阻塞事件循环：
    - 避免在同步代码中执行耗时操作（如大循环），否则会阻塞后续任务。
    - 使用 Web Worker 处理 CPU 密集型任务。
  - 合理使用微任务：
    - 微任务适合处理高优先级的逻辑（如 Promise 链式调用）。
    - 避免在微任务中嵌套过多任务，导致页面渲染延迟。
  - 理解浏览器与 Node.js 的差异：
    - 浏览器中，微任务在渲染前执行；Node.js 中 process.nextTick 优先级最高。
    - Node.js 的 setImmediate 和 setTimeout 的触发顺序可能不同。

## 模块化编程

### CommonJS

- 导出：exports
- 导入：require
- 加载机制：CommonJS模块在加载时是**同步的**，这意味着在require函数调用时，程序会等待模块加载完成后再继续执行。这种机制在服务器端是可行的，但在浏览器端由于JavaScript的单线程特性，**同步加载可能会导致页面阻塞**，因此在浏览器中通常使用异步模块加载方式，如ES6模块。

### ES6模块

- 导出：export
- 导入：import
- 优点：
  - 支持静态分析和树摇（Tree Shaking），这意味着未使用的代码可以被编译器自动移除，从而减小程序的大小
  - ES6模块是异步加载的，这在浏览器环境中尤为重要，可以避免页面加载时的阻塞。

## ES6+

- var 和 let，const
  - var 存在变量提升，存在于全局作用域
  - let，const：只能在代码块中执行，存在于块作用域
- 解构赋值：
  - 字符串解构：`const [a, b, c, d, e] = "hello"`
  - 数组解构：`const [x, y] = [1, 2]`
- 字符串扩展:
  - 字符串模板：插入变量
  - 字符串遍历：通过for-of遍历字符串
  - includes()：是否存在指定字符串
  - startsWith()：是否存在字符串头部指定字符串
  - endsWith()：是否存在字符串尾部指定字符串
- 对象扩展：
  - Object.assign()：合并对象(浅拷贝)，返回原对象
  - Object.keys()
  - 链判断操作符：?.
- 数组扩展：
  - 扩展运算符(...)：[...arr]
  - includes()：是否存在指定成员
- 函数扩展：
  - 参数默认值
  - 箭头函数
    - 没有自己的this，导致内部的this就是外层代码块的this
    - 没有this，因此不能用作构造函数
- Symbol：独一无二的值，const set = Symbol(str)
  - 生成一个原始类型的值不是对象，因此Symbol()前不能使用new命令
- Set：类似于数组的数据结构，成员值都是唯一且没有重复的值
  - 去重字符串：`[...new Set(str)].join("")`
  - 去重数组：`[...new Set(arr)] 或 Array.from(new Set(arr))`
  - WeakSet：和Set结构类似，成员值只能是对象
- Map：类似于对象的数据结构，成员键是任何类型的值
  - WeakMap：和Map结构类似，成员键只能是对象
- Proxy 和 Reflect 联合使用，前者负责拦截赋值操作，后者负责完成赋值操作
- Class：构造函数语法糖
- Module：ES6 模块化编程
- Promise：包含异步操作结果的对象
  - `new Promise((resolve, reject) => {}).then((value)=>{}, (error)=>{})`
  - `Promise.resolve().then(() => {  console.log("Promise"); // 微任务});`
  - Promise.all()：返回全部实例状态变更后的结果数组（传入的 Promise 实例中只要有一个被拒绝，则该实例就会**返回被拒绝**，全部成功才返回结果数组）
  - Promise.allSettled()：返回全部实例状态变更后的结果数组（不论成功失败，都返回结果数组）
  - Promise.race()：哪个实例率先改变状态就返回哪个实例的状态
    - 其他异步任务仍然执行，但是结果不保留。
  - Promise.resolve()
  - Promise.reject()
  - finally()：指定不管最后状态如何都会执行的回调函数
- async，await：为了实现异步操作的语法糖，async标记的函数配合使用await的话会使得异步操作更接近于同步操作，但是要比同步操作更有效率。

## WebSocket

- WebSocket 是一种网络通信协议，它提供了浏览器和服务器之间的 **全双工通信渠道**。与传统的 HTTP 请求相比，WebSocket 允许 **服务器主动向客户端发送信息**，客户端也可以 **随时向服务器发送消息**，实现了真正的双向即时通信。
- 使用：
  - 创建 WebSocket 对象
    - `const socket = new WebSocket('wss://example.com/socket');`
  - 连接打开事件
    - `socket.onopen = function(event) {}`
  - 监听消息事件
    - `socket.onmessage = function(event) {}`
  - 监听错误事件
    - `socket.onerror = function(event) {}`
  - 关闭连接
    - `socket.onclose = function(event) {}`
  - `socket.send(data)`：发送数据到服务器。
  - `socket.close([code[, reason]])`：关闭连接。
  - `socket.readyState`：表示连接状态，可以是 CONNECTING (0), OPEN (1), CLOSING (2), 或 CLOSED (3)。
  - `socket.bufferedAmount`：未发送至服务器的字节数。
- 优点：
  - 较少的控制开销。连接创建后，客户端和服务器之间交换数据时，用于协议控制的数据包头部相对较小。
  - 更好的二进制支持。
  - 没有同源限制，客户端可以与任意服务器通信。
- 缺点：
  - 服务器端的逻辑比轮询复杂。
  - 代理服务器配置可能较为复杂。
- **面试题**：
  - **WebSocket 与 HTTP，TCP/IP 的主要区别是什么**？
    - TCP/IP：解决数据如何在网络中传输，三次握手，网络层，传输层
    - HTTP：如何包装数据，应用层
    - WebSocket 是全双工通信，而 HTTP 是请求/响应模式。
  - **WebSocket 如何保证数据传输的安全性**？
    - 使用 wss（WebSocket Secure）协议，它是 WebSocket 协议的加密版本，相当于 HTTPS。
  - **WebSocket 连接过程中的状态码有哪些？**
    - 接过程中的状态码包括 CONNECTING (0), OPEN (1), CLOSING (2), 和 CLOSED (3)。
  - **WebSocket 的心跳检测有什么作用？**
    - 心跳检测用于保持连接的活跃性，并检测对方是否仍然在线。
  - **WebSocket 的 bufferedAmount 属性有什么作用？**
    - 表示还未发送至服务器的字节数，可以用来控制发送速率，避免发送过快导致数据丢失。

## TypeScript

- **TypeScript 中 any 类型的作用是什么，滥用会有什么后果?**
  - 代码可读性下降
  - 潜在的运行时错误
  - 类型安全受损
- **什么是接口（interface），它的作用?**
  - 接口定义了一个契约，描述了对象的形状（属性和方法），以便在多个地方共享。
- **枚举（enum）是什么?**
  - 枚举是一种对数字值集合进行命名的方式。它们可以增加代码的可读性，并提供一种便捷的方式来使用一组有意义的常量。
- **什么是联合类型和交叉类型?**
  - 联合类型表示一个值可以是多种类型中的一种，而交叉类型表示一个新类型，它包含了多个类型的特性。
- **什么是类型断言?**
  - 类型断言允许程序员手动指定一个值的类型。这在需要明确告诉编译器某个值的类型时非常有用。
  - `let strLength: number = (someValue as string).length;`
- **常用内置类型工具**
  - Partial：可选
  - Required：必选
  - Readonly：只读
  - `Record<Keys, Type>`：构造一个对象类型，其属性键为Keys，属性值为Type。

## 常见面试题

### 遍历方法

- **forEach()**：用于调用数组的每个元素，并将元素传递给回调函数。数组中的每个值都会调用回调函数。
- **map()**：会返回一个新数组，数组中的元素为原始数组元素调用函数处理后的值。该方法按照原始数组元素顺序依次处理元素。
- **filter()**：用于过滤数组，满足条件的元素会被返回。
- **some()**：只要有一个元素符合条件，就返回true，且剩余的元素不会再进行检测，否则就返回false。
- **every()**：只有所有元素都符合条件时，才返回true，如果数组中检测到有一个元素不满足，则整个表达式返回 false。
- **reduce()**：上一次调用回调返回的值传到下一次遍历
- **reduceRight()**：从右到左
- **find()**：通过函数内判断的数组的第一个元素的值。当数组中的元素在测试条件时返回 true 时， find() 返回符合条件的元素，之后的值不会再调用执行函数。如果没有符合条件的元素返回 undefined。 ​
- **findIndex**：符合条件的数组第一个元素位置（索引）

### 深拷贝和浅拷贝

- **浅拷贝**：
  - **Object.assign()**

    ```js
    const original = { a: 1, b: { c: 2 } };
    const copy = Object.assign({}, original);
    ```

  - **展开运算符**

    ```js
    const original = { a: 1, b: { c: 2 } };
    const copy = { ...original };
    ```

  - **Array.prototype.slice()**

    ```js
    const original = [1, [2, 3]];
    const copy = original.slice();
    ```

  - **自定义浅拷贝函数**

    ```js
    function shallowCopy(obj) {
      if (typeof obj !== 'object' || obj === null) return obj;
      const newObj = Array.isArray(obj) ? [] : {};
      for (let key in obj) {
        if (obj.hasOwnProperty(key)) {
          newObj[key] = obj[key];
        }
      }
      return newObj;
    }
    ```

- **深拷贝**：
  - **JSON.parse(JSON.stringify())**
    - 局限性：不能处理函数、循环引用、Symbol等特殊情况。

    ```js
    const original = { a: 1, b: { c: 2 } };
    const copy = JSON.parse(JSON.stringify(original));
    ```

  - **递归实现**：

    ```js
    function deepCopy(obj, hash = new WeakMap()) {
      if (obj === null || typeof obj !== 'object') return obj;
      if (obj instanceof Date) return new Date(obj);
      if (obj instanceof RegExp) return new RegExp(obj);
      
      if (hash.has(obj)) return hash.get(obj);
      
      const newObj = Array.isArray(obj) ? [] : {};
      hash.set(obj, newObj);
      
      for (let key in obj) {
        if (obj.hasOwnProperty(key)) {
          newObj[key] = deepCopy(obj[key], hash);
        }
      }
      
      return newObj;
    }
    ```

  - 使用第三方库
    - Lodash: **`_.cloneDeep()`**
    - jQuery: **`$.extend(true, {}, obj)`**
- **在React中，如何正确地复制状态对象？为什么不应该直接修改状态？**
  - 在 React 中，应该使用 **浅拷贝 来复制状态对象**，因为React使用 **浅比较** 来决定是否重新渲染组件。直接修改状态可能导致组件不更新。可能导致难以追踪的bug。影响性能优化（如 PureComponent 和 React.memo）

### this/call/apply/bind

- **call**：改变this的指向，并**立即执行函数**
  - 第一个是this要指向的对象，第二个参数是 **参数列表**
  - **只会临时改变this一次**
  - 手写

    ```js
    Function.prototype.myCall = function (context) {
        // context就是要指向的对象
        // 我们给context添加一个fn属性，值为this，这里的this就是调用myCall的函数
        // 1.将函数设置为对象的属性
        context.fn = this;
        // 2.执行该函数
        context.fn();
        // 3.删除该函数
        delete context.fn;
    }
    ```

- **apply**：同 call，但 apply 接受的是一个**数组**
  - 手写：

    ```js
    Function.prototype.myApply = function (context, args) {
        // context就是要指向的对象
        // 这里需要做一个判断
        context = context || window;
        // 我们给context添加一个fn属性，值为this，这里的this就是调用myCall的函数
        // 1.将函数设置为对象的属性
        // 用Symbol替换掉fn
        const fnSymbol = Symbol();
        context[fnSymbol] = this;
        // 2.执行该函数, 并传递参数
        const res = context[fnSymbol](args);
        // 3.删除该函数
        delete context.fn;

        return res;
    }
    ```

- **bind**：改变this指向后 **不会立即执行**，而是会返回一个永久改变this指向的函数。第二个参数是 **参数列表**
  - 手写：

    ```js
    Function.prototype.myBind = function (context) {

        // 当调用myBind不是函数的时候，提示错误
        if (typeof this !== 'function') {
            throw new Error('TypeError')
        }

        //这里的this是调用myBind的函数，即bar
        // 将this保存起来
        let self = this

        // 获取传入的参数，除了第一个参数
        // 因为arguments是类数组，它不存在slice方法，所以这里我们可以将数组原型上的slice指向arguments，这样arguments就拥有了slice方法
        let args = Array.prototype.slice.call(arguments, 1)

        // 创建一个空函数
        let fnTemp = function () { };

        // bind会返回一个函数
        let fnBind = function () {
            // 将this指向context
            // 因为bind返回的函数可能被调用多次，所以这里需要将参数进行合并

            // 判断是否是new调用，如果是new调用，this 会指向实例，将绑定函数的this指向该实例，可以让实例获得绑定函数的值
            if (this instanceof fnBind) {
                // 如果是new调用，this指向实例对象
                self.apply(this, [...args, ...arguments])
            } else {
                // 如果不是new调用，this指向context
                self.apply(context, [...args, ...arguments])
            }
        }

        // 让fnBind继承fnTemp的原型
        fnTemp.prototype = this.prototype
        fnBind.prototype = new fnTemp()

        return fnBind;
    }
    ```

# React

## React UI渲染框架的底层机制

- **虚拟 DOM**
  - 当状态或属性发生变化时，React 会重新计算虚拟 DOM 树。
  - 通过比较新旧虚拟 DOM 树的差异（Diffing），找出需要更新的部分
  - 最后，将这些变化批量应用到实际 DOM 上，减少不必要的重绘和回流，提高性能。
- **组件化**
  - JSX：一种 JavaScript 语法扩展，允许在 JavaScript 中编写类似 HTML 的结构。
  - Props：组件的输入参数，父组件通过 props 向子组件传递数据。
  - State：组件的内部状态，用于管理组件的数据和行为。
  - 生命周期方法：React 组件有一系列生命周期方法，如 componentDidMount、shouldComponentUpdate、render 等，用于处理组件的不同阶段
- **单向数据流**：React 采用单向数据流（也称为 Flux 架构），数据从父组件流向子组件。
  - 优点：
    - 数据流动方向明确，易于理解和调试。
    - 有助于避免复杂的状态管理问题。
- **Hooks**：Hooks 是 React 16.8 引入的新特性，允许你在不编写类的情况下使用状态和其他 React 特性。
  - 常见 Hooks：
    - **useState**：添加状态到函数组件。
    - **useEffect**：执行副作用操作，如数据获取、订阅或手动更改 DOM。
    - **useContext**：访问 React 的 Context 对象，用于全局状态管理。
    - **useReducer**：更复杂的状态逻辑，通常与 **context** 一起使用。

### 组件间通信

- 父组件向子组件通信：父组件通过 props 向子组件传递需要的信息。
- 子组件向父组件通信：: props + **回调的方式**。
- 跨级组件的通信方式：
  - Context API：创建一个Context对象，并使用 **`<MyContext.Provider>`**在组件树中的某个位置提供数据。然后，任何子组件（无论多深）都可以使用 **`<MyContext.Consumer>`** 或 **useContext Hook** 来访问这些数据。
  - **Redux**
  - **事件总线**（Event Bus）
- hook 的跨级组件的通信方式：
  - 顶层组件创建 createContext 包裹组件，子组件使用 useContext
  - useContext + useReducer
  - 事件总线（Event Bus）

### Hooks 需要注意的问题

- 不要在循环，条件或嵌套函数中调用 Hook，必须始终在 React函数的顶层使用Hook
  - React 依赖于 **Hooks 的调用顺序** 来管理状态和生命周期。如果违反这条规则，会导致 Hooks 的调用顺序不一致，从而引发难以调试的 bug。
- 使用 useState 时候，使用 push，pop，splice 等直接更改 数组对象 的坑
- useState 设置状态的时候，只有第一次生效，后期需要更新状态，必须通过 useEffect
- 善用 useCallback

### 常见面试题

- **React 生命周期**
  - 类组件生命周期方法
    - 初始化：constructor(props)
    - 挂载前：static getDerivedStateFromProps(props, state)
    - 更新：render()
    - 挂载后：componentDidMount()
    - 更新前：static getSnapshotBeforeUpdate(prevProps, prevState)
    - 更新：render()
    - 更新后：componentDidUpdate(prevProps, prevState, snapshot)
    - 卸载前：componentWillUnmount()
  - 函数组件生命周期钩子
    - 初始化：useState ()
    - 更新后，卸载前：useEffect (fn, deps)
    - 记忆化计算结果：useMemo (() => result, deps)
    - 记忆化函数引用：useCallback (fn, deps)
- **React 性能优化的手段**
  - **组件优化**
    - 使用PureComponent 或 React.memo：对于仅根据props和state改变才重新渲染的组件，使用React.PureComponent或者对其包装一层React.memo，它们都能通过浅比较props来避免不必要的重新渲染。
      - React.PureComponent 适用于类组件，而 React.memo 适用于函数组件，它们通过浅比较来决定组件是否需要重新渲染，从而达到性能优化的目的。但请注意，这两种方式都不适用于含有深层嵌套数据结构或依赖内部状态变更的组件优化。在这种情况下，应手动进行深比较或者使用更高级别的优化手段。
    - shouldComponentUpdate/React Hooks中的useMemo/useCallback：在类组件中实现shouldComponentUpdate生命周期方法来手动控制是否更新组件。在函数组件中，使用useMemo缓存计算结果，useCallback缓存回调函数，防止因依赖项不变而引起的无效渲染。
  - **状态管理与变更**
    - 减少不必要的setState调用：合并多次对同一状态的修改，例如使用useState hook时，可以利用函数式的setState来一次性更新多个状态值。
  - **Virtual DOM与Diff算法优化：**
    - 合理构建组件层级：保持组件树扁平化，减少不必要的嵌套层次，使React的diff算法更高效。
    - 利用key属性：为列表元素提供稳定的唯一key，帮助React识别并最小化DOM变动。
  - **懒加载**
    - 动态导入：使用React.lazy和Suspense来按需加载组件，减轻初始加载负担，提高首屏加载速度。
  - **工具辅助**
    - 利用React DevTools的Profiler面板分析组件渲染性能瓶颈。
  - **前端通用性能优化**
    - 静态资源压缩与HTTP缓存：优化CSS、JavaScript文件大小，合理设置HTTP缓存策略。
    - 服务端渲染(SSR)：针对SEO友好和首屏加载速度，结合Next.js等框架进行服务器端渲染。
- **对 Fiber 架构的理解：即是React新的调度算法**
  - Fiber 来将一次任务拆解成单元，以划分时间片的方式，按照Fiber的自己的调度方法，根据任务单元优先级，分批处理或吊起任务，将一次更新分散在多次时间片中，另外, 在浏览器空闲的时候, 也可以继续去执行未完成的任务, 充分利用浏览器每一帧的工作特性。
- **Redux原理**：解决react组件间通信和组件间状态共享而提出的一种解决方案，主要包括3个部分，（store + action + reducer）。
  - **store**：用来存储当前react状态机（state）的对象
  - **State**: store对象包含的所有数据
  - **action**: 用于接受state的改变命令，是改变state的唯一途径和入口。一般使用时在当前组件里面调用相关的action方法，通常把和后端的通信(ajax)函数放在这里
  - **reducer**: action的处理器，用于修改store中state的值，返回一个新的state值
  - **Dispatch**: view发出action的唯一方法
- **React refs 的理解：**
  - ref 是一种在组件之间直接访问 DOM 节点或在函数组件中访问类组件实例的能力
  - 使用：React.createRef()（适用于类组件）、useRef() Hook（适用于函数组件）
  - React 内部对 Ref 的处理：
    - 当 React 渲染组件时，它会注意到带有 ref 属性的元素，并将 ref 的 .current 属性指向相应的 DOM 节点或组件实例。
- **setState 到页面重新渲染经历了什么？**
  - **状态合并**：当调用 setState 时，React 不会立即改变组件的状态，而是将传入的新状态对象与当前状态进行合并。合并通常是浅层合并，这意味着如果新状态包含深层次的对象属性更改，那么只有第一层属性会合并，深层对象的更改可能不会生效，除非显式替换整个深层对象。
  - **异步处理**：React 将 setState 操作视为异步的，特别是当在事件处理器或生命周期方法中调用时。这意味着调用 setState 并不会立即导致重新渲染。实际上，React 可能会把多个连续的 setState 调用合并成一个，以减少不必要的渲染次数。
  - **批处理**：React 有一个批处理过程，它可以收集在一个事件循环 tick 内的多个 setState 调用，然后一次性去更新状态。这样有助于在高并发更新时优化性能。
  - **状态更新调度**：React 会在微任务队列中安排状态更新的任务，这通常发生在事件处理结束、生命周期钩子调用之后，或者在某些异步操作（如网络请求完成）之后。
  - **组件生命周期方法**：getDerivedStateFromProps + shouldComponentUpdate
  - **重新渲染决策**：如果根据新的 props 或 state，React 确定组件需要重新渲染，它会进入 render 方法来生成新的虚拟 DOM 树。
  - **虚拟 DOM 比较**
  - **DOM 更新**
  - **生命周期方法调用**：componentDidUpdate
- **useEffect 与 useLayoutEffect 的区别？**
  - useEffect：在所有的 DOM 变更已经完成并同步到浏览器界面之后，浏览器的事件循环下一次迭代中**异步执行**。这意味着在 useEffect 里的代码运行时，用户已经可以看到渲染的结果。
  - useLayoutEffect：在所有的 DOM 变更完成后立即**同步执行**，紧接在 DOM 更新之前。这意味着 useLayoutEffect 内部的代码更改会影响到当前帧的渲染结果，因此在它执行期间，浏览器会暂停布局和绘制工作，等待同步代码执行完毕。
- **useMome 和react.memo区别？**
  - useMemo： **是Hook,用于记忆化计算结果**，以避免在每次渲染时都重新计算某个值。它可以缓存计算结果，只有在依赖项发生变化时才重新计算。
  - react.memo：**是高阶组件，用于优化函数组件**，通过记忆（缓存）组件的渲染结果，当组件的 props 没有发生变化时，避免不必要的重新渲染。

# Webpack

- **webpack配置文件五大核心概念：**
  - **entry** 入口： webpack 以哪个文件为入口起点开始打包，分析构建内部依赖图
  - **output** :指示 webpack 打包后的资源 bundles 如何命名、输出到哪里去.
  - **module** :会配置一些loader让webpack能够处理哪些非JS的文件，比如样式文件，图片文件
  - **plugins** :插件的范围包括，从打包优化和压缩，一直到重新定义环境中的变量等
  - **mode** : webpack使用相应模式的配置（生产或开发模式）
- **使用场景**：
  - 压缩合并 CSS 和 JavaScript代码
  - 压缩图片，
  - 对小图生成base64编码，对大图进行压缩，
  - 使用 Babel把 EMAScript 6编译成 EMAScript 5，
  - 热重载，
  - 局部刷新等
- **Webpack 做过哪些优化手段？**
  - **优化 loader 文件搜索范围**，可以指定哪些文件不通过 loader 处理，哪些文件通过 loader 处理，像node_modules 代码是编译过的，完全没必要在处理一遍，可以只处理 src 中的文件
  - **对图片进行压缩和优化**：**image-webpack-loader** 这个 loader 可以对打包后的图片进行压缩和优化，例如降低图片分辨率，压缩图片体积等。
- **loader 和 plugin 的区别？**
  - Loader: **是一个函数**，该函数中对接收到的内容进行转换，返回转换后的结果。
  - Plugin 是插件，可以 **扩展** Webpack 的功能
  - **Loader** 在 **module.rules** 中配置，作为模块的解析规则，类型为数组。每一项都是一个 Object，内部包含了 test (类型文件)、loader、options (参数)等属性。
  - **Plugin** 在 **plugins** 中单独配置，类型为数组，每一项是一个 Plugin 的实例，参数都通过**构造函数**传入
- **常见 loader：**
  - source-map-loader：加载额外的 Source Map 文件，以方便断点调试
  - **image-loader**：加载并且压缩图片文件
  - **babel-loader**：把 ES6 转换成 ES5
  - **ts-loader**: 将 TypeScript 转换成 JavaScript
  - **sass-loader**：将SCSS/SASS代码转换成CSS
  - **css-loader**：加载 CSS，支持模块化、压缩、文件导入等特性
  - **style-loader**：把 CSS 代码注入到 JavaScript 中，通过 DOM 操作去加载 CSS
- **常见 plugin：**
  - define-plugin：定义环境变量 (Webpack4 之后指定 mode 会自动配置)
  - **ignore-plugin**：忽略部分文件
  - html-webpack-plugin：简化 HTML 文件创建 (依赖于 html-loader)
  - web-webpack-plugin：可方便地为单页应用输出 HTML，比 html-webpack-plugin 好用
  - **clean-webpack-plugin**: 目录清理（保持项目结构整洁‌，节省硬盘空间）
  - **webpack-parallel-uglify-plugin**: 多进程执行 **代码压缩**，提升构建速度,减少构建时间
  - serviceworker-webpack-plugin：为网页应用增加离线缓存功能
- **webpack4 新增了哪些东西？需要注意些什么？**
  - **mode属性**‌：webpack4 引入了 mode 属性，用于区分 开发模式 和 生产模式。**开发模式下默认不压缩代码**，**开启代码调试**；生产模式下则进行代码压缩，不开启代码调试‌  
  - 确保Node.js的版本 **`>= 8.9.4`**
  - 性能优化‌：webpack4 内置了 代码压缩 功能，但在 生产模式 下需要确保启用压缩选项

# NodeJS

搭服务:

```js
const express = require('express');
const app = express();
const port = 3000;
 
// 中间件：解析 JSON 请求体
app.use(express.json());
 
// 路由：根路径
app.get('/', (req, res) => {
    res.send('Hello, World!');
});
 
// 示例路由：获取用户信息
app.get('/users', (req, res) => {
    const users = [
        { id: 1, name: 'Alice' },
        { id: 2, name: 'Bob' }
    ];
    res.json(users);
});
 
// 示例路由：创建新用户
app.post('/users', (req, res) => {
    const newUser = req.body;
    // 在这里可以添加逻辑来保存用户
    res.status(200).json({ code: 200, message: 'User created', user: newUser });
});
 
// 启动服务器
app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
```

# 跨域

- 跨域：Ajax 只能同源使用的限制，如果缺少了同源策略，浏览器很容易受到XSS、CSFR等攻击。
  - 所谓同源是指 " 协议 + 域名 + 端口" 三者相同
- 解决办法：
  - **JSONP 跨域**：利用 `<script>` 标签没有跨域限制，通过 `<script>` 标签src属性，发送带有callback参数的GET请求，服务端将接口返回数据拼凑到callback函数中，返回给浏览器，浏览器解析执行，从而前端拿到callback函数返回的数据。
    - 缺点：
      - 只能处理get请求
      - 通过URL携带参数容易被劫持，不安全
  - **CORS 跨域资源共享 （前端不需要做任何改变）**
    - 缺点：
      - 设置具体地址，有局限性
      - 设置多源（*）就不能允许携带cookie了
  - **nginx代理**：实质和 CORS 跨域原理一样，通过配置文件设置请求响应头Access-Control-Allow-Origin…等字段。
  - **nginx反向代理**：同源策略仅是针对浏览器的安全策略。服务器端调用HTTP接口只是使用HTTP协议，不需要同源策略，也就不存在跨域问题。
  - **WebSocket 协议跨域**：WebSocket protocol是HTML5一种新的协议。它实现了浏览器与服务器全双工通信，同时允许跨域通讯，是server push技术的一种很好的实现。

# web 常见漏洞

- SQL注入漏洞
  - 对进入数据库的特殊字符（’”<>&\*;等）进行转义处理，或编码转换。
  - 数据长度应该严格规定，能在一定程度上防止比较长的SQL注入语句无法正确执行。  
- 跨站脚本漏洞 XSS
  - 不仅要验证数据的类型，还要验证其格式、长度、范围和内容。
  - 不要仅仅在客户端做数据的验证与过滤，关键的过滤步骤在服务端进行。
- 跨站请求伪造 CSRF
  - 验证码
  - Token

# Next 服务端渲染

- 创建页面组件并在其中使用 **getServerSideProps** 函数来获取数据。
- 自定义 _app.js 文件来添加全局布局和样式。
- 自定义 _document.js 文件来生成 HTML 文档结构。
- 运行开发服务器或构建生产环境版本。
