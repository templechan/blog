---
layout: post
title: "Interview 3"
description: "-"
author: "谌中钱"
date: "2025-01-03"
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
  - [常见面试题](#常见面试题)
- [CSS](#css)
  - [页面布局](#页面布局)
    - [两栏布局](#两栏布局)
    - [三栏布局](#三栏布局)
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
- [函数式编程](#函数式编程)
- [Webpack](#webpack)
- [React](#react)
  - [生命周期](#生命周期)
  - [虚拟DOM是如何工作的](#虚拟dom是如何工作的)
  - [Diff算法有哪些优化策略](#diff算法有哪些优化策略)
  - [Fiber带来了哪些改进？](#fiber带来了哪些改进)
  - [Fiber 与 传统React渲染机制 有哪些区别？](#fiber-与-传统react渲染机制-有哪些区别)
  - [React 事件机制](#react-事件机制)
    - [setState 流程](#setstate-流程)
  - [Redux](#redux)
    - [三大原则](#三大原则)
    - [redux中间件](#redux中间件)
- [Nextjs](#nextjs)
- [微前端架构](#微前端架构)
- [高频交易场景的技术](#高频交易场景的技术)
- [性能优化](#性能优化)
  - [代码层面](#代码层面)
    - [常规](#常规)
    - [React](#react-1)
  - [WebWorker](#webworker)
  - [缓存控制](#缓存控制)
    - [HTTP缓存](#http缓存)
    - [浏览器存储](#浏览器存储)
    - [应用缓存 Service Worker](#应用缓存-service-worker)
    - [CDN 缓存](#cdn-缓存)
  - [度量方法](#度量方法)
    - [监控日志](#监控日志)
    - [自动化测试](#自动化测试)
- [网络和安全](#网络和安全)
- [文件上传](#文件上传)
- [React 开发常见陷阱](#react-开发常见陷阱)

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

### 两栏布局

- float 左浮左边栏 + 使用 margin-left 撑出内容块做内容展示 + 添加BFC，防止下方元素飞到上方内容，如 overflow: hidden
- flex 弹性布局：父盒子 display: flex，左侧盒子写入宽度，右侧盒子 flex: 1占一份

### 三栏布局

- 两边使用 float，中间使用 margin
- 使用 absolute，中间使用 margin
- **圣杯布局**，利用margin负值法：使用圣杯布局首先需要在center元素外部包含一个div，包含div需要设置float属性使其形成一个BFC，并设置宽度为百分之百，这样中间盒子独占一行，左右盒子被挤到下方，让左边的盒子上去要设置margin-left:-100%，让右边的盒子上去要设置margin-left: 负自身宽度
- **使用 flex 实现**: 将父级设置为display: flex; justify-content: space-between; 即可

## 定位

- static: 表示没有定位
- absolute: 表示绝对定位，相对于最近的已定位的祖先元素
- relative: 表示相对定位，相对于自身原有位置进行偏移，可能会覆盖其他元素
- fixed: 相对于视窗来定位。意味着即便页面滚动，它还是会停留在相同的位置

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
- React 中闭包：
  - useState 和 useEffect：在 React 中，由于函数组件没有自己的实例，所以在使用 useState 和 useEffect 等 Hook 时，也会用到闭包的概念来保存组件内部的状态。

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

# 函数式编程

> 函数式编程 是一种 编程范式，就是如何编写程序。
> 特性：闭包，高阶函数，惰性计算，递归 等。

# Webpack

- **webpack配置文件五大核心概念：**
  - **entry** 入口： webpack 以哪个文件为入口起点开始打包，分析构建内部依赖图
  - **output** :指示 webpack 打包后的资源 bundles 如何命名、输出到哪里去.
  - **module** :会配置一些loader让webpack能够处理哪些非JS的文件，比如样式文件，图片文件
  - **plugins** :插件的范围包括，从打包优化和压缩，一直到重新定义环境中的变量等
  - **mode** : webpack使用相应模式的配置（生产或开发模式）
- **作用**：
  - 编译代码能力，提高效率，解决浏览器兼容问题
  - 模块整合能力，提高性能，可维护性，解决浏览器频繁请求文件的问题
  - 万物皆可模块能力，项目维护性增强，支持不同种类的前端模块类型，统一的模块化方案，所有资源文件的加载都可以通过代码控制。
- **构建流程**：
  - **初始化阶段**：从配置文件和 Shell 语句中读取与合并参数，并初始化需要使用的插件和配置插件等执行环境所需要的参数。
  - **编译构建阶段**：从 Entry 发出，针对每个 Module 串行调用对应的 Loader 去翻译文件内容，再找到该 Module 依赖的 Module，递归地进行编译处理。
  - **输出阶段**：对编译后的 Module 组合成 Chunk，把 Chunk 转换成文件，输出到文件系统。
- Loader 和 Plugin 的区别？
  - Loader：本质就是一个函数，在该函数中对接收到的内容进行转换，返回转换后的结果。
  - Plugin：扩展 Webpack 的功能，基于事件流框架Tapable，插件可以扩展 Webpack 的功能，在 Webpack 运行的生命周期中会广播出许多事件，Plugin 可以监听这些事件，在合适的时机通过 Webpack 提供的 API 改变输出结果。
- 常用 Loader：
  - style-loader：将css添加到DOM的内联样式标签style里，然后通过 dom 操作去加载 css。
  - css-loader :允许将css文件通过require的方式引入，并返回css代码。
  - less-loader: 处理less，将less代码转换成css。
  - sass-loader: 处理sass，将scss/sass代码转换成css。
  - postcss-loader：用postcss来处理css。
  - autoprefixer-loader: 处理css3属性前缀，已被弃用，建议直接使用postcss。
  - file-loader: 分发文件到output目录并返回相对路径。
  - url-loader: 和file-loader类似，但是当文件小于设定的limit时可以返回一个Data Url。
  - html-minify-loader: 压缩HTML
  - babel-loader :用babel来转换ES6文件到ES。
  - awesome-typescript-loader：将 TypeScript 转换成 JavaScript，性能优于 ts-loader。
  - eslint-loader：通过 ESLint 检查 JavaScript 代码。
  - tslint-loader：通过 TSLint检查 TypeScript 代码。 - cache-loader: 可以在一些性能开销较大的 Loader 之前添加，目的是将结果缓存到磁盘里
- 常用 Plugin：
  - define-plugin：定义环境变量 (Webpack4 之后指定 mode 会自动配置)
  - ignore-plugin：忽略部分文件
  - html-webpack-plugin：简化 HTML 文件创建 (依赖于 html-loader)
  - web-webpack-plugin：可方便地为单页应用输出 HTML，比 html-webpack-plugin 好用
  - uglifyjs-webpack-plugin：不支持 ES6 压缩 (Webpack4 以前)
  - terser-webpack-plugin: 支持压缩 ES6 (Webpack4)
  - webpack-parallel-uglify-plugin: 多进程执行代码压缩，提升构建速度
  - mini-css-extract-plugin: 分离样式文件，CSS 提取为独立文件，支持按需加载 (替代extract-text-webpack-plugin)
  - serviceworker-webpack-plugin：为网页应用增加离线缓存功能
  - clean-webpack-plugin: 目录清理
  - ModuleConcatenationPlugin: 开启 Scope Hoisting
  - speed-measure-webpack-plugin: 可以看到每个 Loader 和 Plugin 执行耗时 (整个打包耗时、每个 Plugin 和 Loader 耗时)
  - webpack-bundle-analyzer: 可视化 Webpack 输出文件的体积 (业务组件、依赖第三方模块)

# React

## 生命周期

- 类组件生命周期：
  - 挂载阶段：
    - constructor：初始化组件的 state，给事件处理方法绑定 this
    - getDerivedStateFromProps：会返回一个对象用来更新当前的 state 对象，如果不需要更新可以返回 null。
    - render
    - componentDidMount：执行依赖于DOM的操作，发送网络请求，添加订阅消息
  - 更新阶段：
    - getDerivedStateFromProps
    - shouldComponentUpdate：决定组件是否需要重新渲染。它接收新的props和新的state作为参数，如果返回true，则组件会重新渲染
      - 在函数组件中，可以使用 React.memo 来实现类似功能
    - render
    - getSnapshotBeforeUpdate
    - componentDidUpdate
  - 卸载阶段：
    - componentWillUnmount：清除 timer，取消网络请求或清除，取消在 componentDidMount 中创建的订阅等

- 函数组件生命周期钩子：
  - useState()：管理组件的状态，类似于类组件中的this.state和this.setState。
  - useEffect()：类似于 componentDidMount 和 componentDidUpdate 的合并，以及 componentWillUnmount 功能，通过返回一个清理函数可以在组件卸载时执行一些操作

## 虚拟DOM是如何工作的

- 当组件的状态发生变化时，React首先会在内存中创建一个新的 **虚拟DOM树** 来表示更新后的UI结构。
- 然后，React会将这个 新的虚拟DOM树 与 旧的虚拟DOM树 进行比较（这个过程称为 Diff算法）。
- Diff算法 会找出两个虚拟DOM树之间的 **差异**，例如 哪些节点被添加、删除或者修改了。
- 最后，React 根据这些差异计算出 **最小的DOM操作集合**，只将这些必要的操作应用到实际的DOM上，从而提高性能，避免了直接操作真实DOM带来的大量 重绘和回流。

## Diff算法有哪些优化策略

- **同一层级的节点进行比较**：React只在同一层级的节点之间进行比较，不会跨层级去查找差异。这样可以大大减少比较的复杂度。
- **组件类型比较**：如果两个节点的组件类型不同（例如一个是<div>，一个是<span>），React会直接认为这是一个 **全新的节点**，会销毁旧节点及其子节点，并创建新节点及其子节点，而不会深入比较子节点。
- **列表渲染优化**：当渲染列表时，如果给每个列表项设置了唯一的key属性，React可以根据key来更高效地识别哪些列表项是新增、删除或者移动的。

## Fiber带来了哪些改进？

- React Fiber是React 16引入的一种新的协调引擎。
- 它的主要改进包括：
  - **可中断 和 可恢复 的渲染**：React Fiber可以将渲染工作分解成多个小任务，并且可以根据优先级暂停和恢复这些任务。这使得浏览器有更多的机会进行其他操作，如响应用户交互，提高了用户体验。
  - **更好的调度能力**：能够更合理地安排不同类型任务的执行顺序，例如先执行高优先级的更新（如用户交互触发的更新），再执行低优先级的更新（如数据获取后的更新）。
  - **支持并发模式**：允许 React 同时处理多个任务，例如在渲染新内容的同时还能响应用户的输入操作。

## Fiber 与 传统React渲染机制 有哪些区别？

- 传统React渲染是基于递归调用的，一旦开始渲染就会一直进行下去直到完成。
- React Fiber采用了基于链表的数据结构来表示组件树，并且可以将渲染任务分解成多个小的任务单元（Fiber节点）。
- 在任务调度方面，传统React没有很好的中断和恢复机制，而React Fiber可以根据优先级灵活地中断和恢复渲染任务。
- 在并发模式下，传统React只能顺序执行任务，而React Fiber可以同时处理多个任务，提高了资源利用率和响应速度。

## React 事件机制

- React基于浏览器的事件机制自身实现了一套事件机制，包括事件注册、事件的合成、事件冒泡、事件派发等，在React中这套事件机制被称之为合成事件。
- 合成事件：实际并不会把事件代理函数直接绑定到真实的节点上，而是把所有的事件绑定到结构的最外层，使用一个统一的事件去监听。当组件挂载或卸载时，只是在这个统一的事件监听器上插入或删除一些对象。简化了事件处理和回收机制，效率也有很大提升。
- React合成事件与原生事件执行顺序：
  - React 所有事件都挂载在 document 对象上
  - 当真实 DOM 元素触发事件，会冒泡到 document 对象后，再处理 React 事件
  - 所以会先执行原生事件，然后处理 React 事件
  - 最后真正执行 document 上挂载的事件
- 总结：
  - React 上注册的事件最终会绑定在document这个 DOM 上，而不是 React 组件对应的 DOM(减少内存开销就是因为所有的事件都绑定在 document 上，其他节点没有绑定事件)
  - React 自身实现了一套事件冒泡机制，所以这也就是为什么我们 event.stopPropagation() 无效的原因。
  - React 通过队列的形式，从触发的组件向父组件回溯，然后调用他们 JSX 中定义的 callback
  - React 有一套自己的合成事件 SyntheticEvent

### setState 流程

- **状态合并**：当调用 setState 时，React 不会立即改变组件的状态，而是将传入的新状态对象与当前状态进行合并。合并通常是浅层合并，这意味着如果新状态包含深层次的对象属性更改，那么只有第一层属性会合并，深层对象的更改可能不会生效，除非显式替换整个深层对象。
- **异步处理**：React 将 setState 操作视为异步的，特别是当在事件处理器或生命周期方法中调用时。这意味着调用 setState 并不会立即导致重新渲染。实际上，React 可能会把多个连续的 setState 调用合并成一个，以减少不必要的渲染次数。
- **批处理**：React 有一个批处理过程，它可以收集在一个事件循环 tick 内的多个 setState 调用，然后一次性去更新状态。这样有助于在高并发更新时优化性能。
- **状态更新调度**：React 会在微任务队列中安排状态更新的任务，这通常发生在事件处理结束、生命周期钩子调用之后，或者在某些异步操作（如网络请求完成）之后。
- **组件生命周期方法**：getDerivedStateFromProps + shouldComponentUpdate
- **重新渲染决策**：如果根据新的 props 或 state，React 确定组件需要重新渲染，它会进入 render 方法来生成新的虚拟 DOM 树。
- **虚拟 DOM 比较**
- **DOM 更新**
- **生命周期方法调用**：componentDidUpdate

## Redux

### 三大原则

- **单一数据源**：整个应用的state被存储在reducer中，并且这个reducer只存在于唯一一个store
- **state是只读的**：唯一能改变 state 的就是 action, action是一个用于描述已发生事件的对象,通过 store 中的 dispatch方法 来发送 action，store.dispatch(action)
- **使用纯函数（reducer）来执行修改**: reducer是一个纯函数，它接受老的state，action，并且返回一个新的state
>
- 缺点：一个组件所需要的数据，必须由父组件传过来，而不能像flux中直接从store取。 当一个组件相关数据更新时，即使父组件不需要用到这个组件，父组件还是会重新render，可能会有效率影响，或者需要写复杂的shouldComponentUpdate进行判断。

### redux中间件

- 为什么需要redux中间件？
  - 默认情况下，redux只能处理同步数据流。但是实际项目开发中，状态的更新、获取、通常是使用异步操作来实现的。
- 常用的redux中间件？
  - redux-thunk：处理异步操作，主要作用就是可以使action可以变成函数形式，接收两个参数dispatch、getState
  - redux-promise： 处理异步操作
  - redux-logger：打印日志，主要作用在控制台打印输出新老state等信息

# Nextjs

- **什么是 Next.js，它与 React 有何不同？**
  - Next.js 是一个基于 React 的开源框架，可帮助开发人员构建服务器端呈现的 React 应用程序。
  - React和 Next.js 之间的主要区别在于它们处理路由的方式。 React 使用客户端路由，这意味着页面转换完全在客户端使用 JavaScript 处理。
  - 相比之下，Next.js 提供服务器端路由，这意味着服务器处理路由并将预渲染的页面发送给客户端，从而实现更快的页面加载和更好的 SEO。
    Next.js 还提供其他功能，如自动代码拆分、静态站点生成和动态导入。
- **使用 Next.js 比 React 有什么优势？**
  - Next.js 提供了几个优于 React 的优势，包括服务器端渲染、自动代码拆分、静态站点生成、动态导入、优化的性能和易于部署。此外，Next.js 支持内置的 SEO 和分析，可以更轻松地针对搜索引擎优化您的应用程序并跟踪用户参与度。
- **如何创建新的 Next.js 应用程序？**
  - 要创建新的 Next.js 应用程序，您可以使用create-next-app命令。例如，您可以在终端中运行以下命令： npx create-next-app my-app 。这将创建一个名为my-app新 Next.js 应用程序。
- **什么是服务器端渲染，为什么它很重要？**
  - 服务器端呈现 (SSR) 是在将网页发送到客户端浏览器之前在服务器上呈现网页的过程。 SSR 很重要，因为它允许搜索引擎抓取和索引您网站的内容，这可以改善您网站的 SEO。此外，SSR 可以缩短初始页面加载时间，并改善互联网连接或设备较慢的用户的用户体验。
- **什么是客户端渲染，它与服务器端渲染有何不同？**
  - 客户端呈现 (CSR) 是在从服务器接收到初始 HTML、CSS 和 JavaScript 后，使用JavaScript在客户端浏览器上呈现网页的过程。 SSR 和 CSR 之间的主要区别在于，SSR 向客户端浏览器发送一个完全呈现的 HTML 页面，而 CSR 发送一个由 JavaScript 填充的空 HTML 页面。
- **如何在 Next.js 应用程序中配置路由？**
  - Next.js 使用基于文件的路由，这意味着您可以通过在具有相应 URL 路径的pages目录中创建新文件来创建页面。例如，要创建一个 URL 路径为/about页面，您可以在pages目录中创建一个名为about.js的文件。
- **Next.js 中getStaticProps函数的用途是什么？**
  - getStaticProps函数用于在构建时获取数据以生成静态站点。此函数在构建过程中调用，可用于从外部 API 或数据库中获取数据。然后将getStaticProps返回的数据作为 props 传递给页面组件。
- **在 Next.js 应用程序中如何在页面之间传递数据？**
  - Next.js 提供了多种在 Next.js 应用程序的页面之间传递数据的方法，包括 URL 查询参数、 Router API 和状态管理库，如 Redux 或 React Context。您还可以使用getServerSideProps函数在服务器上获取数据并将其作为 props 传递给页面组件。
- **如何部署 Next.js 应用程序？**
  - Next.js 应用程序可以部署到各种平台，包括 AWS、 Google Cloud Platform和 Microsoft Azure 等云服务，以及 Vercel 和 Netlify 等平台。要部署 Next.js 应用程序，您可以使用next export命令导出 SSG 的静态文件或使用平台特定的部署工具，如 Vercel 的 CLI 或 AWS Elastic Beanstalk。
>
- **什么是无服务器架构，它与 Next.js 有什么关系？**
  - 无服务器架构是一种云计算模型，其中云提供商管理基础架构并根据需求自动扩展资源。通过将应用程序部署到 AWS Lambda 或 Google Cloud Functions 等无服务器平台，Next.js 可以与无服务器架构一起使用。
- **Next.js 中的getServerSideProps和getStaticProps函数有什么区别？**
  - getServerSideProps函数用于在运行时在服务器上获取数据以进行服务器端渲染
  - 而getStaticProps函数用于在构建时获取数据以生成静态站点。
- **Next.js 中getStaticPaths函数的用途是什么？**
  - getStaticPaths 函数用于为具有动态数据的页面生成动态路径。此函数在构建过程中调用，可用于生成动态数据的可能值列表。然后使用getStaticPaths返回的数据为每个可能的值生成静态文件。
- **如何在 Next.js 应用程序中配置动态路由？**
  - Next.js 使用方括号[]表示 URL 路径中的动态段。例如，要为 URL 路径为/blog/[slug]的博客帖子创建动态路由，您可以在pages/blog目录中创建一个名为[slug].js的文件。
- **Next.js 如何处理代码拆分，为什么它很重要？**
  - Next.js 会自动将您的代码分成更小的块，当用户导航到新页面时，这些块可以按需加载。这有助于减少初始页面加载时间并提高应用程序的性能。
- **Next.js 中_app.js文件的用途是什么？**
  - _app.js文件用于包装整个应用程序并提供全局样式、布局组件和上下文提供程序。该文件在每次页面请求时都会被调用，可用于向您的应用程序添加常用功能。
- **如何在 Next.js 应用程序中实现身份验证？**
  - Next.js 提供了多个用于实现身份验证的选项，包括 JSON Web Tokens (JWT)、OAuth 和第三方库，如 NextAuth.js。您还可以使用服务器端呈现和会话管理来实现服务器端身份验证。
- **容器组件和展示组件有什么区别？**
  - 容器组件负责管理组件的状态和逻辑，而展示组件负责根据从容器组件传递下来的 props 呈现 UI。
- **React 中useEffect钩子的用途是什么，它与 Next.js 有什么关系？**
  - useEffect钩子用于在功能组件中执行副作用，例如从 API 获取数据或更新文档标题。在 Next.js 中， useEffect钩子可以用来 使用fetch API 或第三方库（如 Axios 或 SWR）执行客户端数据获取。
- **如何处理 Next.js 应用程序中的错误？**
  - Next.js 提供了多种错误处理选项，包括自定义错误页面、使用getInitialProps服务器端错误处理以及使用 React 错误边界的客户端错误处理。您还可以使用第三方库（如 Sentry 或 Rollbar）进行错误监控和报告。
>
- **如何在 Next.js 应用程序中实现国际化 (i18n)？**
  - Next.js 通过next-i18next库为 i18n 提供内置支持。您可以使用此库为您的应用程序创建翻译，并根据用户的偏好或浏览器设置在语言之间切换。
- **Next.js 中getServerSideProps 函数的用途是什么，它与getInitialProps函数有什么关系？**
  - getServerSideProps函数用于在运行时在服务器上取数据，用于服务器端渲染，
  - getInitialProps 函数用于在运行时在客户端或服务器上取数据。
  - 在 Next.js 9.3 及更高版本中，不推荐getInitialProps函数，取而代之的是getServerSideProps 。
- **如何在 Next.js 应用程序中实现服务器端缓存？**
  - Next.js 通过Cache-Control标头为服务器端缓存提供内置支持。您可以使用getServerSideProps函数或通过在页面组件中设置cacheControl属性来设置每个页面的缓存持续时间。
  - 我们还可以使用 Redis 或 Memcached 等缓存库来缓存 API 响应或数据库查询。还可以实施 CDN 缓存或边缘缓存等选项，以提高静态资产的性能并减少服务器上的负载。
- **如何优化 Next.js 应用程序的性能？**
  - 代码拆分、延迟加载、图像优化、服务器端缓存和 CDN 缓存。
  - 您还可以使用 Lighthouse 或 WebPageTest 等性能监控工具来确定需要改进的地方。
- **如何在 Next.js 应用程序中实现无服务器功能？**
  - Next.js 通过API Routes功能为无服务器功能提供内置支持。您可以通过在pages/api目录中创建一个具有所需端点名称的文件并实现服务器端逻辑来创建无服务器函数。
- **如何使用 Next.js 实现无头 CMS？**
  - 您可以使用第三方 CMS（如 Contentful、Strapi 或 Sanity）使用 Next.js 实现无头 CMS。这些 CMS 平台提供用于获取和更新内容的 API，可以使用getStaticProps或getServerSideProps函数将其与 Next.js 集成
- **你如何处理复杂数据模型或嵌套数据结构的 SSR？**
  - 我们可以使用 GraphQL 或 REST API 从服务器获取数据并将其作为 props 传递给组件。像swr或react-query这样的库也可以用来处理数据获取和缓存。
- **如何在 Next.js 应用程序中实施 A/B 测试？**
  - 我们可以使用 Google Optimize 或 Optimizely 等第三方工具来创建实验和跟踪用户行为。
  - 我们还可以使用功能标志或条件渲染等自定义解决方案来测试应用程序的不同变体。
- **如何处理 Next.js 应用程序中的实时更新？**
  - 要在 Next.js 应用程序中处理实时更新，您可以使用服务器发送的事件、Web 套接字或第三方库（如 Socket.io）在客户端和服务器之间建立实时连接。您还可以使用像react-use或redux这样的库来处理应用程序中的实时数据更新。
- **如何在 Next.js 应用程序中实施测试和持续集成？**
  - 可以使用 Jest 或 Cypress 等测试框架来编写和运行测试。
  - 使用 CircleCI 或 Travis CI 等持续集成服务来自动化测试和部署过程。
  - 使用 ESLint 或 Prettier 等代码质量工具来确保代码的一致性和可维护性。

# 微前端架构

- **什么是微前端？为什么要使用微前端架构？**
  - 微前端是一种架构模式，通过将前端应用划分为多个独立的微应用，每个微应用可以单独开发、部署和运行。微前端架构的目标是将大型单体前端应用解耦为多个独立的模块，使其具备微服务的灵活性与独立性。
  - 使用微前端的主要原因包括：
    - 分工协作：多个团队可以在相对独立的环境中开发，减少代码冲突。
    - 技术栈自由：各个微应用可以选择不同的技术栈（如 Vue、React 等），提高了技术灵活性。
    - 逐步迁移：便于逐步升级或迁移老旧系统，不必进行大规模重构。
- **微前端有哪些核心概念？**
  - 独立性：每个微应用可以独立开发、测试、部署，互不影响。
  - 路由管理：通过主应用统一管理路由，加载不同的微应用。
  - 共享资源：微应用间可能需要共享公共组件、状态和资源。
  - 通信机制：为保证各微应用间的解耦，通常采用全局状态管理（如 Redux、Vuex）或事件总线实现跨应用通信。
- **微前端架构有哪些实现方式？各自的优缺点是什么？**
  - iframe：
    - 优点：隔离性强，安全性高。
    - 缺点：通信复杂，性能较差，SEO 不友好。
    - 适用场景：仅在一些简单集成的场景下使用。
  - 基于 JavaScript 的动态加载
    - 优点：灵活性高，微应用可以动态加载。
    - 缺点：如果管理不当，容易产生资源冲突。
    - 适用场景：现代化前端项目中普遍采用的方式。
  - Web Component：
    - 优点：与框架无关，可以被任意 JavaScript 框架使用。
    - 缺点：浏览器兼容性稍差。
    - 适用场景：跨团队、跨框架的项目协作中较为常用。
  - 基于框架的解决方案（如 qiankun、single-spa）：
    - 优点：已有成熟的开源方案，适合快速上手。
    - 缺点：有一定学习成本，需要关注性能优化。
    - 适用场景：大型微前端项目。
- **如何在微前端项目中实现路由的管理？**
  - 路由管理通常采用 主应用 统一管理的方式，主应用控制 微应用的加载和切换。
    - qiankun 会根据 URL 路径来加载对应的微应用 app1 或 app2，从而实现主应用对微应用的路由控制。
- **微前端如何实现跨应用通信？**
  - 全局状态管理工具：在主应用中使用 Redux、Vuex 等状态管理工具，通过上下文来共享数据。
  - 事件总线：通过事件总线在微应用间传递事件和数据。
  - URL 参数传递：通过 URL 参数传递信息。
  - 全局变量：在主应用中定义全局变量，子应用可以访问和修改这些变量。
- **微前端架构的优缺点是什么？**
  - 优点：
    - 提升开发效率，方便独立开发与部署。
    - 代码更易维护，减少单体应用的代码量。
    - 团队协作更加灵活，各个团队可以自由选择技术栈。
  - 缺点：
    - 资源加载和性能问题需要优化。
    - 跨应用的共享和通信复杂度较高。
    - 架构和部署复杂，学习成本较高。
- **如何在项目中实践微前端架构？**
  - 拆分应用：将单体应用拆分成多个独立的功能模块。
  - 选择微前端框架：选择合适的微前端框架（如 qiankun）。
  - 路由管理：配置主应用的路由管理，加载各微应用。
  - 通信机制：实现主应用与微应用的通信机制。
  - 资源优化：通过懒加载、缓存等手段优化资源加载。
- **微前端架构如何管理共享依赖？如何避免依赖冲突？**
  - 主应用统一管理依赖：在主应用中定义和加载所有通用的依赖包，如 React 或 Vue，然后在微应用中直接引用，避免重复加载。
  - 使用模块联邦（Module Federation）：通过 Webpack 5 的模块联邦功能，使多个微应用可以共享同一个依赖包，减少加载重复依赖。
  - 版本隔离：如果微应用需要特定版本的依赖，可以通过 namespace 隔离不同版本，防止冲突。
- **微前端如何实现子应用的独立部署？部署时需要注意哪些问题？**
  - 独立构建与发布：每个微应用需要拥有独立的构建配置和部署流程，如通过 CI/CD 工具进行自动化部署。
  - 主应用动态加载：主应用通过动态 URL 配置，加载各个微应用的资源。在部署时，只需更新对应微应用的 URL，无需修改主应用代码。
  - 跨域配置：不同微应用通常会部署在不同域名下，跨域访问时需要在服务器上配置 CORS 或通过代理解决跨域问题。
  - 注意事项：
    - 确保版本一致性，避免不同版本的依赖出现冲突。
    - 部署过程中若需要重新编译，需要确保各微应用的路由路径配置不冲突。
    - 关注加载速度和缓存策略，尽可能减少对用户的影响。
- **在微前端架构中如何保证样式的隔离？**
  - CSS Modules：在组件级别启用 CSS Modules，限制样式的作用域。
  - Scoped CSS：通过 Vue 或 React 的 Scoped CSS 或内联样式确保样式不影响其他微应用。
  - Shadow DOM：使用 Web Component 和 Shadow DOM，形成独立的样式作用域，确保隔离效果（需考虑浏览器兼容性）。
  - 命名空间：给每个微应用添加独特的类前缀或命名空间，防止样式冲突。
- **如何在微前端架构中处理公共状态的共享？有哪些常用方案？**
  - 全局状态管理工具：如 Redux 或 Vuex，将公共状态放置在主应用中，通过上下文或事件传递给各个微应用。
  - 基于事件的通信：使用 EventEmitter、postMessage 或 CustomEvent 传递数据，实现微应用间的状态共享和同步。
  - 自定义的通信协议：使用 WebSocket、localStorage 等实现更复杂的跨应用通信和数据同步。
- **微前端的性能优化有哪些手段？**
  - 懒加载微应用：仅在需要时才加载微应用，减少初始加载的资源占用。
  - 缓存资源：对静态资源进行缓存或使用 Service Worker 缓存，提升加载效率。
  - 树状结构的路由加载：通过按需加载子模块，减少无用代码的加载。
  - CDN 加速：将微应用资源部署到 CDN，加快资源加载速度。

# 高频交易场景的技术

- 多线程
  - 多线程数据下载
  - 多线程数据清洗
  - 多线程并行回测多个策略
  - 同时监控多个市场的实时行情
  - 数据分片和合并结果

# 性能优化

## 代码层面

### 常规

- 压缩
- 按需导入
- 减少 http 请求数量：防抖、节流
- 懒加载，预加载
- 虚拟列表

### React

- 缓存组件：React.memo，通过浅比较 props 发生变化时才会重新渲染
- 缓存大量的计算：useMemo
- 缓存函数：useCallback
- 延迟加载：React.lazy 和 React.Suspense 完成延迟加载

## WebWorker

- 创建 Worker 文件
  - 通过 self.postMessage 发送结果回主线程
  - 监听 message 事件
    - 在里面执行执行计算密集型任务
    - 通过 event.data 接收主线程发来的消息
- 在主线程中实例化 Worker
  - 通过 new Worker("worker.js") 实例化 Worker
  - 通过 worker.postMessage 发送结果给 Worker
  - 监听 message 事件
    - 通过 event.data 接收主线程发来的消息
- 卸载 Web Workers
  - 内部终止：self.close()
  - 主线程终止：worker.terminate()

## 缓存控制
>
> 通过减少对 原始数据源 的 访问次数，降低 系统负载，来提高系统的 响应速度 和 吞吐量。
> ‌前端缓存控制策略主要包括：**HTTP缓存、浏览器存储、应用缓存 和 CDN缓存** 等几种类型。
>
### HTTP缓存
>
>通过设置 HTTP响应头 来实现。

- **强缓存**：如果存在且未过期缓存，则直接使用，不向服务器发送请求
  - **Cache-Control**：优先级高于 Expires，是一个相对时间
    - public：全部缓存
    - private：只能被单个用户的浏览器缓存存储
    - no-cache：每次请求时都必须向服务器验证资源的有效性
    - no-store：不缓存
    - max-age：指定资源在缓存中的最大有效时间
  - **Expires**：是绝对时间
- **协商缓存**：浏览器在缓存过期后，会向服务器发送请求，携带响应头，如果资源未修改，服务器返回 304 状态码，表示使用缓存资源‌
  - Last-Modified (**If-Modified-Since**)：基于时间戳
  - ETag (**If-None-Match**)：基于内容哈希值，能更准确地判断资源是否发生变化

### 浏览器存储

- **localStorage**：存储没有截止日期的数据
- **sessionStorage**：当关闭浏览器 **标签页** 时数据会丢失
- **IndexedDB**：HTML5提供的本地数据库存储方案，适用于 大量数据的存储和复杂查询操作‌。
  - 使用：封装个 IndexDBCache 类，用于增、删、改、查 操作。
    - 参考：<https://blog.csdn.net/weiCong_Ling/article/details/131437456>
- cookie 和 浏览器存储 使用场景 对比：
  - cookie 主要用于实现 **用户会话跟踪、身份认证** 等功能。它们常用于存储少量的 用户信息 或 会话标识，以便在服务器端 识别特定用户。
  - 浏览器存储 更适合用于存储大量的数据，如 **用户偏好设置、应用程序配置** 等。由于其大容量和持久性的特点，本地存储在这些场景下表现更为出色。

### 应用缓存 Service Worker

- **离线缓存**：
  - 创建 Service Worker 文件
    - Service Worker 的生命周期包括 安装、激活、运行 和 卸载 四个事件阶段，监听它们 实现各种功能
      - **安装阶段 install**：通过 event.waitUntil，caches.open，cache.addAll 来创建和添加缓存
      - **激活阶段 activate**：通过 event.waitUntil，caches.keys().then 来清理旧的缓存
      - 运行阶段 active：可以接收 fetch 和 message 事件。
      - 卸载阶段 uninstall：卸载过程通常是隐式的
    - **监听 fetch 事件**：拦截网络请求，通过 event.respondWith caches.match，判断优先从缓存中提供资源，如果没有找到，则尝试从网络获取
  - 在主线程注册 Service Worker
    - 通过 navigator.serviceWorker.register('service-worker.js') 来注册 Service Worker
  - 卸载 Service Worker：
    - 在主线程中：使用 navigator.serviceWorker.getRegistration() 获取特定的注册对象，然后调用 unregister() 方法
    - 更新新版本的 Service Worker
- 推送通知：支持通过 Push API 实现推送通知。
>
- **优化建议**：使用 **Workbox**：Google 提供的库，简化 Service Worker 开发，提供缓存策略、路由管理和自动更新等功能。

### CDN 缓存
>
> 通过将内容部署在多个节点上，使用户能够从最近的节点获取内容，从而加快加载速度。
> CDN 可以缓存静态资源如图片、CSS、JavaScript文件 等，减少网络延迟和提高用户体验‌。

## 度量方法

### 监控日志

- 使用Console日志
- 使用第三方库
  - Log4js
  - Pino
- 在React组件中集成日志系统
  - 在React组件中，你可以将日志系统集成到生命周期方法或事件处理函数中。例如，使用componentDidMount来记录组件加载信息。
- 使用React DevTools进行调试和监控
  - React DevTools是一个浏览器扩展，可以帮助你检查组件树、状态和属性等，非常适合开发和调试阶段使用。

### 自动化测试

- Jest
  - Jest是一个流行的JavaScript测试框架，它为React提供了很好的支持。它可以轻松地与Babel集成，使得在React项目中编写测试变得非常简单。
  - 编写测试用例

# 网络和安全

- 浏览器地址到页面流程：
  - **DNS 解析**：得到 IP 地址。
  - **建立 TCP 连接**：
    - 第 1 次握手：**客户端** 发送一个 SYN 报文段到 服务器，并进入 **SYN_SENT 状态**。
    - 第 2 次握手：**服务器** 收到客户端的 SYN 报文段后，发送一个 SYN-ACK 报文段作为响应，同时进入 **SYN_RECV 状态**。
  - 第 3 次握手：**客户端** 收到服务器的 SYN-ACK 报文段后，再发送一个 ACK 报文段给服务器，**确认连接建立**，客户端和服务器都进入 ESTABLISHED 状态。
  - **发送 HTTP 请求**：浏览器通过已建立的 TCP 连接发送 HTTP 或 HTTPS 请求到服务器。请求中包含 请求方法、URL、HTTP 版本、请求头 等信息。
  - **服务器处理请求**：
    - 根据请求的内容进行处理。这可能包括读取文件、执行脚本、查询数据库等操作。
    - 服务器生成响应，响应中包含状态码、响应头和响应体（通常是 HTML 文档）。
  - **浏览器接收响应**：如果响应是 HTTP 200 OK，表示请求成功，浏览器开始解析响应体中的 HTML 内容。
  - **解析 HTML**：
    - 解析 HTML：浏览器解析 HTML 文档，构建 DOM 树（文档对象模型）。
    - 解析 CSS 和 JavaScript：浏览器解析 HTML 中引用的 CSS 和 JavaScript 文件，构建 CSSOM 树（CSS 对象模型）和 JavaScript 对象。
  - **渲染页面**：
    - 构建渲染树：浏览器将 DOM 树和 CSSOM 树合并，构建渲染树。渲染树包含所有可见的节点及其样式信息。
    - 布局计算：浏览器计算每个节点在页面上的位置和大小。
    - 绘制：浏览器将渲染树绘制到屏幕上，显示最终的页面。
  - **加载资源**：浏览器继续加载页面中引用的其他资源，如图片、字体、视频等。
    - 这些资源的加载过程类似于初始的 HTML 文档加载过程，包括 DNS 解析、建立 TCP 连接、发送 HTTP 请求、接收响应等。
  - **交互**：页面加载完成后，用户可以与页面进行交互，如点击链接、填写表单、滚动页面等。浏览器会根据用户的操作动态更新页面内容。

- 状态码
  - 请求成功：
    - 200：成功
  - 重定向：
    - 301：永久重定向，响应头中会包含一个 Location 字段，指向新的URL。
    - 302：临时重定向，搜索引擎不会将权重和收录情况转移到新的URL上，而是保留原本的URL。‌
    - 304：表示可以在缓存中取数据 (协商缓存)
  - 客户端错误：
    - 401：未授权
    - 403：拒绝请求
    - 404：资源不存在
  - 服务端错误：
    - 500：服务器内部错误
    - 502：网关错误
    - 504：网关超时

- **JSONP 跨域**：利用 `<script>` 标签没有跨域限制，通过 `<script>` 标签 src 属性，发送带有 callback 参数的 GET 请求，服务端将接口返回数据拼凑到 callback 函数 中，返回给浏览器，浏览器解析执行，从而前端拿到 callback函数 返回的数据。
  - 缺点：
    - 只能处理get请求
    - 通过 URL 携带参数容易被劫持，不安全
- **CORS 跨域资源共享 （前端不需要做任何改变）**
  - nginx代理设置：通过配置文件设置请求响应头 **Access-Control-Allow-Origin** 等字段。
  - 缺点：
    - 设置具体地址，有局限性
    - 设置多源（*）就不能允许携带 cookie 了
- **nginx反向代理**：同源策略仅是针对 **浏览器** 的安全策略。服务器端调用 HTTP接口 只是使用 HTTP协议，不需要同源策略，也就不存在跨域问题。
- **WebSocket 协议跨域**：WebSocket protocol 是 HTML5 一种新的协议。它实现了浏览器与服务器全双工通信，同时 **允许跨域通讯**，是 server push 技术的一种很好的实现。

- 常见 Web 漏洞：
  - SQL注入漏洞
    - 对进入数据库的特殊字符（’”<>&\*;等）进行转义处理，或编码转换。
    - 数据长度应该严格规定，能在一定程度上防止比较长的SQL注入语句无法正确执行。  
  - 跨站脚本漏洞 XSS
    - 不仅要验证数据的类型，还要验证其格式、长度、范围和内容。
    - 不要仅仅在客户端做数据的验证与过滤，关键的过滤步骤在服务端进行。
  - 跨站请求伪造 CSRF
    - 验证码
    - Token

# 文件上传

- **文件分片**：原理就是 **Blob 对象 的 slice 方法**，File 对象 就 继承与 Blob 对象
- **区分文件**：根据 **spark-md5** 提供一个计算 hash值 的函数，并在获取文件切片之后，调用这个函数。秒传的原理就是 比较两个文件的 hash值。
- **上传切片**：定义一个 上传分片 的函数，并在获取 hash值 之后调用，把分片数组作为参数传过去。
- **小文件获取上传进度**：监听 XMLHttpRequest 的 upload 属性 的 progress 事件，event.loaded / event.total 获取上传进度。

# React 开发常见陷阱

- 状态更新不同步
  - 现象：修改状态后视图未更新
  - 原因：直接修改 state 而非调用 setState
  - 方案：调用 setState
- 副作用未清理
  - 现象：组件卸载后仍执行副作用操作
  - 原因：未在 useEffect 返回清理函数
  - 方案：useEffect 返回清理函数
- 闭包陷阱
  - 现象：回调函数捕获旧的 state 值
  - 原因：函数作用域中保存了旧的变量引用
  - 方案：useRef(count)，始终获取最新值
- 不必要的重新渲染
  - 现象：父组件更新导致子组件重复渲染
  - 原因：未优化子组件的 props 比较逻辑
  - 方案：使用 React.memo 包裹子组件，第二个参数是可以自定义比较函数
- key 值使用不当
  - 现象：列表渲染时出现内容错位
  - 原因：使用数组索引作为 key
  - 方案：使用唯一标识符
- 异步渲染问题
  - 现象：setState 调用后立即取值不是最新值
  - 原因：React 的批处理机制导致异步更新
  - 方案：使用 useEffect 监听 state 变化
- 事件处理错误
  - 现象：事件参数不正确或无法访问 this
  - 原因：未正确绑定事件处理函数绑定 this
  - 方案：绑定 this
- Context 滥用
  - 现象：组件树频繁更新导致性能下降
  - 原因：Context 值变化触发所有消费者更新
  - 方案：拆分 Context， 仅在必要时更新
- Hooks 使用规则违反
  - 现象：Hooks 无法正确工作
  - 原因：条件渲染中使用 Hooks
  - 方案：确保 Hooks 在顶层调用
