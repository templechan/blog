---
layout: post
title: "Interview"
description: "-"
author: "谌中钱"
date: "2025-01-01"
image: "/img/temple-404-bg.png"
categories: [ "Solutions" ]
---

<br />
<br />

- [Web](#web)
  - [HTML5](#html5)
    - [常见面试题](#常见面试题)
  - [CSS3](#css3)
    - [页面布局](#页面布局)
      - [flex布局属性](#flex布局属性)
      - [垂直水平居中](#垂直水平居中)
      - [两栏布局](#两栏布局)
      - [三栏布局](#三栏布局)
    - [定位](#定位)
    - [BFC](#bfc)
    - [CSS 动画](#css-动画)
    - [浏览器渲染流程](#浏览器渲染流程)
    - [CSS样式隔离方案](#css样式隔离方案)
    - [移动端适配方案](#移动端适配方案)
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
- [PWA](#pwa)
  - [Service Workers](#service-workers)
  - [Web App Manifest](#web-app-manifest)
  - [离线存储](#离线存储)
    - [浏览器存储](#浏览器存储)
- [性能优化](#性能优化)
  - [常规](#常规)
  - [React](#react-1)
  - [WebWorker](#webworker)
  - [缓存控制](#缓存控制)
    - [HTTP缓存](#http缓存)
    - [浏览器存储](#浏览器存储-1)
    - [应用缓存 Service Worker](#应用缓存-service-worker)
    - [CDN 缓存](#cdn-缓存)
- [性能监控](#性能监控)
  - [监控工具](#监控工具)
  - [关键性能指标](#关键性能指标)
- [测试部署](#测试部署)
- [Webpack](#webpack)
- [Nextjs](#nextjs)

# Web

## HTML5

### 常见面试题

- **H5 语义化？**
    - 增强代码可读性，方便维护（人）
    - 增强爬虫 SEO（机器）
- **async 和 defer 在 script标签 中的区别？**
    - **async**: **异步加载**，多个 script 时，谁先下载完执行谁。**适用于 不依赖 DOM 和 其他script 的场景。**
    - **defer**: **延迟加载**，等效于放在 body 尾部，多个 script 时，等 DOM 加载完，按顺序执行。
- **href 和 src 都是用来引用外部的资源，它们的区别？**
    - **href**: 对资源的引用，当浏览器识别到它指向的是文件时，**会异步下载，不会阻塞网页的渲染**。常用在 link、a标签 上。
    - **src**: 对资源的引用，它指向的资源会 嵌入 到当前标签所在的位置，当浏览器解析当该元素时，**会暂停其他资源的下载和处理，直到该资源加载，编译，执行完毕**。常用在 script标签 上。

## CSS3

### 页面布局

#### flex布局属性

- **容器属性**：
    - **display**: flex
    - **flex-flow**： flex-direction 和 flex-wrap 属性的简写形式
        - **flex-direction**：决定主轴的方向，属性值 row（默认），row-reverse，column，column-reverse;
        - **flex-wrap**：决定换行规则，属性值 nowrap（默认），wrap，wrap-reverse
    - **justify-content**：水平主轴对齐方式
        - **flex-start（默认）**: 左对齐
        - flex-end: 右对齐
        - **center**: 水平居中
        - **space-between**：两端对齐，项目之间的间隔都相等
        - **space-around**：两个项目两侧间隔相等
    - **align-items**：竖直轴线方向
        - **stretch（默认）**: 如果项目没有 设置高度 或者 设为auto，则占满整个容器的高度
        - flex-start: 起点对齐
        - flex-end: 终点对齐
        - **center**: 垂直居中
        - **baseline**: 项目第一行文字的  基线对齐
- **项目属性**：
    - **flex**: flex-grow，flex-shrink 和 flex-basic 属性的简写形式，默认值为 **0 1 auto**
        - **flex-grow**: 放大比例，**默认为 0，不放大**
        - **flex-shrink**: 缩小比例，**默认为 1，如果空间不足，该项目将缩小。**
        - **flex-basic**: 分配多余空间前，**项目占主轴空间的大小，默认为 auto，项目的本来大小。**
    - **order**：项目的排列顺序，数值越小越靠前，默认为 0
    - **align-self**：覆盖 **align-items** 的值，单独设置项目的 竖直轴线方向。

#### 垂直水平居中

- **行内元素** 或 **设置为表格单元格**:
    - **line-height** + text-align
    - **vertical-align: middle** + text-align
    - **display: table-cell** + **vertical-align: middle** + text-align
- **已知宽高**:
    - 绝对定位 + 负 margin
    - 绝对定位 + transform
- **flex**:
    - 容器: display: flex + align-items: center + justify-content: center
- **JS 动态居中**:

    ```js
    const element = document.querySelector('.child');
    element.style.position = 'absolute';
    element.style.top = `${(window.innerHeight - element.offsetHeight) / 2}px`;
    ```

#### 两栏布局

- **脱离文档流**：
    - **float + margin**：
        - 左：float: left + width: 200px
        - 右：margin-left: 200px
    - **absolute + margin**:
        - 容器: position: relative
            - 左: position: absolute + width: 200px
            - 右: margin-left: 200px
    - **float + BFC**：
        - 左: float: left + width: 200px
        - 右: overflow: hidden
- **flex**:
    - 容器: display: flex
        - 左: width: 200px
        - 右: flex: 1

#### 三栏布局

- **脱离文档流**：
    - **float + margin**:
        - 左：float: left + width: 200px
        - 右：float: right + width: 200px
        - 中：margin: 0 220px
        - **圣杯布局**:
            - **容器：padding: 0 220px**
                - 中: float: left + width: 100%
                - 左: float: left + width: 200px + position: relative + left: -100%;
                - 右: float: left + width: 200px + position: relative + left: -220px;
        - **双飞翼布局**:
            - 中容器: float: left + width: 100%
                - **中：margin: 0 220px**
            - 左: float: left + width: 200px + margin-left: -100%;
            - 右: float: left + width: 200px + margin-left: -220px;
    - **absolute + margin**:
        - 容器：position: relative
            - 中: margin: 0 220px
            - 左: position: absolute + width: 200px
            - 右: position: absolute + width: 200px + right: 0
- **flex**:
    - 容器：display: flex
        - 左：width: 200px
        - 中：flex: 1 + margin: 0 20px
        - 右：width: 200px

### 定位

- **static**（默认）：按照正常的文档流进行排列
- **relative**：**相对定位**，相对于其正常位置进行定位。**即使进行了偏移，也不会影响文档流中的其他元素。**
- **absolute**：**绝对定位**，相对于最近的已定位祖先元素（如果不是，则相对于初始包含块）进行定位。**元素会脱离正常文档流。**
- **fixed**：**固定定位**，相对于浏览器窗口进行定位。**即使页面滚动，元素的位置也不会改变。**
- **sticky**：**粘性定位**，可以看作是相对定位和固定定位的混合。元素在跨越特定阈值前为相对定位，之后为固定定位。**必须指定一个阈值**（如 `top`、`right`、`bottom` 或 `left`），否则行为与相对定位相同。

### BFC

- **定义**：块级格式化上下文，一个完全独立的空间，空间里的子元素不会影响到外面的布局。
- **规则**：
    - 计算BFC的高度时，浮动元素也参与计算。
    - 属于同一个 BFC 的两个 相邻的标签 外边距会发生重叠。
        - BFC 容器里的标签不会影响到外部标签。
- **解决问题**：
    - 使用 float 脱离文档流，容器 **高度塌陷**。
    - margin **边距重叠问题**。
- **触发条件**:
    - overflow: hidden
    - position: absolute、fixed
    - display: inline-block、flex、table-cell

### CSS 动画

- **transition**: 过渡属性，它的实现需要触发一个事件（比如鼠标移动上去，焦点，点击等）才执行动画。
    - 它类似于 flash 的补间动画，设置一个开始关键帧，一个结束关键帧。
- **animation**: 动画属性，它的实现不需要触发事件，设定好时间之后可以自己执行，且可以循环一个动画。
    - 它也类似于 flash 的补间动画，但是它可以设置多个关键帧（用 `@keyframe` 定义）完成动画。

### 浏览器渲染流程

- **浏览器地址到页面流程**：
  - **DNS 解析**：得到 IP 地址。
  - **建立 TCP 连接**：
    - 第 1 次握手：**客户端** 发送一个 SYN 报文段到 服务器，并进入 **SYN_SENT 状态**。
    - 第 2 次握手：**服务器** 收到客户端的 SYN 报文段后，发送一个 SYN-ACK 报文段作为响应，同时进入 **SYN_RECV 状态**。
    - 第 3 次握手：**客户端** 收到服务器的 SYN-ACK 报文段后，再发送一个 ACK 报文段给服务器，**确认连接建立**，客户端和服务器都进入 **ESTABLISHED 状态**。
  - **发送 HTTP 请求**：浏览器通过已建立的 TCP 连接发送 HTTP 或 HTTPS 请求到服务器。请求中包含 请求方法、URL、HTTP 版本、请求头 等信息。
  - **服务器处理请求**：
    - 根据请求的内容进行处理。这可能包括读取文件、执行脚本、查询数据库等操作。
    - 服务器生成响应，响应中包含状态码、响应头和响应体（通常是 HTML 文档）。
  - **浏览器接收响应**：如果响应是 HTTP 200 OK，表示请求成功，浏览器开始解析响应体中的 HTML 内容。
  - **解析 HTML**：
    - **解析 HTML**：浏览器解析 HTML 文档，构建 **DOM 树**（文档对象模型）。
        - **解析 CSS** 和 **JS**：浏览器解析 HTML 中引用的 CSS 和 JS 文件，构建 **CSSOM 树**（CSS 对象模型）和 **JS 对象**。
  - **渲染页面**：
    - **构建渲染树**：浏览器将 DOM 树和 CSSOM 树合并，构建渲染树。渲染树包含所有可见的节点及其样式信息。
    - **布局计算**：基于渲染树，浏览器计算每个节点在页面上的 位置和大小。**即 重排**。
    - **绘制**：浏览器将 渲染树 绘制 到屏幕上，显示最终的页面。**即 重绘**。
        - **页面元素发生形状大小变化就是 重排，外观发生变化就是 重绘。**
        - **重排一定会重绘，但是重绘不一定重排。**
  - **加载资源**：浏览器继续加载页面中引用的其他资源，如 图片、字体、视频 等。
    - 这些资源的加载过程类似于 初始的 HTML文档 加载过程，包括 DNS解析、建立 TCP连接、发送 HTTP请求、接收响应 等。
  - **交互**：页面加载完成后，用户可以与页面进行交互，如点击链接、填写表单、滚动页面等。浏览器会根据用户的操作动态更新页面内容。

### CSS样式隔离方案

- 模块化前端框架：
    - 使用 **CSS Modules**: 通过生成唯一的类名来实现样式隔离的技术。每个模块（文件）中的样式都会自动被本地化，避免与其他模块的样式冲突。
        - 是在 构建阶段 对 CSS类名选择器 **限定作用域** 的一种方式。
        - 所有样式都是局部作用域的，解决了全局污染问题
- 组件化的样式管理：
    - 使用 **CSS-in-JS**: 是在 JS 中直接编写 CSS 的技术，相关工具如 **emotion**。
        - 样式与组件逻辑耦合，增强模块化。
        - 支持动态计算样式，便于主题切换等场景。

### 移动端适配方案

- **rem + 动态设置 font-size**
    - 媒体查询：
        - 需要针对不同的屏幕编写大量的媒体查询
        - 如果动态改变尺寸，不会实时更新，只是一个个区间
    - 编写 js 代码：
        - 根据 html 的宽度计算出 font-size 的大小，并设置到 html 上
        - 监听页面尺寸的变化，实时修改 font-size 大小
    - lib-flexible 库：是淘宝团队出品的一个移动端自适应解决方案，通过动态计算 viewport 设置 font-size 实现不同屏幕宽度下的 UI 自适应缩放。
- **vw 单位（推荐）**
- **flex 的弹性布局**

### 常见面试题

- **盒模型的定义？标准盒模型 和 怪异盒模型 的区别？**
    - 盒模型：盒子包括 content、padding、border、margin。
    - **标准盒模型**（默认）: 元素的 width 和 height 仅指 content 的尺寸
    - **怪异盒模型**: 元素的 width 和 height 除了 content 的尺寸，还包括 padding、border
    - **切换属性**：**box-sizing**，属性值 content-box（标准盒子模型），**border-box**（怪异盒模型）
- **CSS 优先级是怎样计算的？**
    - **!important** 优先级最高 >
    - **内联样式 权重** 1000 >
    - **id选择器 权重** 100 >
    - **类选择器、属性选择器、伪类选择器 权重** 10 >
    - **标签选择器、伪元素选择器 权重** 1 >
    - **子选择器、后代选择器、兄弟选择器、通配符选择器 权重** 0 >
    - **继承的样式 没有权重**
- **margin 负值的区别？**
    - **margin-top** 和 **margin-left** 负值：**元素向上、向左移动**
    - **margin-right** 负值，右侧元素左移，**自身不受影响**
    - **margin-bottom** 负值，下方元素上移，**自身不受影响**

- **元素隐藏 的方式？**
    - **display: none**：元素在页面上将 **彻底消失**，导致浏览器的**重排和重绘**，无法响应点击事件。
    - **visibility: hidden**：仅仅是隐藏该元素，**DOM结果均会存在**，只是当时在一个不可见的状态，**不会触发重排，但是会触发重绘**，无法响应点击事件。
    - **opacity: 0**: 透明度设置为 0 后，元素也是隐藏的，不会引发重排，**一般情况下也会引发重绘**，**可以响应点击事件**。
- **清除浮动 的方式？**
    - **使用 clear: both**：在浮动元素后面放一个空的 div 标签，div 设置样式 **clear: both** 来清除浮动。
    - **利用伪元素 after**： 给父元素添加了 **::after** 伪元素，通过伪元素清除浮动，达到撑起父元素高度的目的。
    - **BFC**：给父元素设置了 overflow 样式，建构了一个 BFC。
- **怎么开启 GPU 加速？**
    - 浏览器会自动为以下属性启用 GPU 加速:
        - transform: translate3d() / translateZ(0)
        - opacity
        - filter（如模糊、阴影）
        - will-change: transform（提前声明元素会变化）
- **手写**: CSS 单行文本 字数过多显示 … ？

    ```css
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    ```

- **手写**: CSS 画三角形？

    ```css
    /* 记忆口诀：盒子宽高均为零，三面边框皆透明。 */
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

- **手写**: CSS 使用 flex 布局实现三点筛子？

    ```css
    .wrapper {
    height: 100px;
    width: 100px;
    border: solid 1px red;
    border-radius: 5px;

    display: flex;
    justify-content: space-between;
    }

    .item:nth-child(2) {
    align-self: center;
    }
    .item:nth-child(3) {
    align-self: flex-end;
    }
    ```

- **手写**: CSS 怎么画 0.5px 的线 ？
    - 采用 **transform: scale()** 的方式

        ```css
        .half-pixel-line {
        height: 1px; /* 或者你需要的长度 */
        background-color: black; /* 或你想要的颜色 */
        transform: scaleY(0.5); /* 对高度进行垂直方向的缩放 */
        }
        ```

    - 设置 **box-shadow** 的第二个参数为 0.5px，表示阴影垂直方向的偏移为 0.5px

        ```css
        height: 1px;
        box-shadow: 0 0.5px 0 #000;
        ```

## JS

### 数据类型

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

### 作用域

- 定义：作用域就是 变量与函数 的 可访问范围，控制着 变量与函数 的 可见性 和 生命周期。
- 变量的作用域有 **全局作用域** 和 **局部作用域** 两种。
  - ES6中新增 **块级作用域**。

### 闭包

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

### 原型链

- 定义：对象通过隐式原型( `__proto__` )属性指向其构造函数的原型对象( prototype )，进而通过原型对象( prototype )的隐式原型( `__proto__` )属性指向更高层级的原型对象( prototype )，最终指向null而停止所形成的链条，则称其为原型链。

### 继承

- 原型链继承：让新实例的原型是另一个构造函数的实例
  - 原型链继承原型上的属性和方法
- 构造函数继承
  - 构造函数继承实例属性
- 组合继承：上面结合
- 原型式继承
- 寄生式继承
- 寄生组合式继承

### DOM/BOM 操作

- DOM:
  - 节点操作
  - DOM事件
- BOM 常用对象
  - window 对象
  - Navigator 对象
  - History 对象
  - Location 对象
  
### Ajax

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

### 事件循环机制

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

### 模块化编程

#### CommonJS

- 导出：exports
- 导入：require
- 加载机制：CommonJS模块在加载时是**同步的**，这意味着在require函数调用时，程序会等待模块加载完成后再继续执行。这种机制在服务器端是可行的，但在浏览器端由于JavaScript的单线程特性，**同步加载可能会导致页面阻塞**，因此在浏览器中通常使用异步模块加载方式，如ES6模块。

#### ES6模块

- 导出：export
- 导入：import
- 优点：
  - 支持静态分析和树摇（Tree Shaking），这意味着未使用的代码可以被编译器自动移除，从而减小程序的大小
  - ES6模块是异步加载的，这在浏览器环境中尤为重要，可以避免页面加载时的阻塞。

### ES6+

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

### WebSocket

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

### TypeScript

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

### 常见面试题

#### 遍历方法

- **forEach()**：用于调用数组的每个元素，并将元素传递给回调函数。数组中的每个值都会调用回调函数。
- **map()**：会返回一个新数组，数组中的元素为原始数组元素调用函数处理后的值。该方法按照原始数组元素顺序依次处理元素。
- **filter()**：用于过滤数组，满足条件的元素会被返回。
- **some()**：只要有一个元素符合条件，就返回true，且剩余的元素不会再进行检测，否则就返回false。
- **every()**：只有所有元素都符合条件时，才返回true，如果数组中检测到有一个元素不满足，则整个表达式返回 false。
- **reduce()**：上一次调用回调返回的值传到下一次遍历
- **reduceRight()**：从右到左
- **find()**：通过函数内判断的数组的第一个元素的值。当数组中的元素在测试条件时返回 true 时， find() 返回符合条件的元素，之后的值不会再调用执行函数。如果没有符合条件的元素返回 undefined。 ​
- **findIndex**：符合条件的数组第一个元素位置（索引）

#### 深拷贝和浅拷贝

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

#### this/call/apply/bind

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

## React

### 生命周期

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

### 虚拟DOM是如何工作的

- 当组件的状态发生变化时，React首先会在内存中创建一个新的 **虚拟DOM树** 来表示更新后的UI结构。
- 然后，React会将这个 新的虚拟DOM树 与 旧的虚拟DOM树 进行比较（这个过程称为 Diff算法）。
- Diff算法 会找出两个虚拟DOM树之间的 **差异**，例如 哪些节点被添加、删除或者修改了。
- 最后，React 根据这些差异计算出 **最小的DOM操作集合**，只将这些必要的操作应用到实际的DOM上，从而提高性能，避免了直接操作真实DOM带来的大量 重绘和回流。

### Diff算法有哪些优化策略

- **同一层级的节点进行比较**：React只在同一层级的节点之间进行比较，不会跨层级去查找差异。这样可以大大减少比较的复杂度。
- **组件类型比较**：如果两个节点的组件类型不同（例如一个是<div>，一个是<span>），React会直接认为这是一个 **全新的节点**，会销毁旧节点及其子节点，并创建新节点及其子节点，而不会深入比较子节点。
- **列表渲染优化**：当渲染列表时，如果给每个列表项设置了唯一的key属性，React可以根据key来更高效地识别哪些列表项是新增、删除或者移动的。

### Fiber带来了哪些改进？

- React Fiber是React 16引入的一种新的协调引擎。
- 它的主要改进包括：
  - **可中断 和 可恢复 的渲染**：React Fiber可以将渲染工作分解成多个小任务，并且可以根据优先级暂停和恢复这些任务。这使得浏览器有更多的机会进行其他操作，如响应用户交互，提高了用户体验。
  - **更好的调度能力**：能够更合理地安排不同类型任务的执行顺序，例如先执行高优先级的更新（如用户交互触发的更新），再执行低优先级的更新（如数据获取后的更新）。
  - **支持并发模式**：允许 React 同时处理多个任务，例如在渲染新内容的同时还能响应用户的输入操作。

### Fiber 与 传统React渲染机制 有哪些区别？

- 传统React渲染是基于递归调用的，一旦开始渲染就会一直进行下去直到完成。
- React Fiber采用了基于链表的数据结构来表示组件树，并且可以将渲染任务分解成多个小的任务单元（Fiber节点）。
- 在任务调度方面，传统React没有很好的中断和恢复机制，而React Fiber可以根据优先级灵活地中断和恢复渲染任务。
- 在并发模式下，传统React只能顺序执行任务，而React Fiber可以同时处理多个任务，提高了资源利用率和响应速度。

### React 事件机制

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

### Redux

#### 三大原则

- **单一数据源**：整个应用的state被存储在reducer中，并且这个reducer只存在于唯一一个store
- **state是只读的**：唯一能改变 state 的就是 action, action是一个用于描述已发生事件的对象,通过 store 中的 dispatch方法 来发送 action，store.dispatch(action)
- **使用纯函数（reducer）来执行修改**: reducer是一个纯函数，它接受老的state，action，并且返回一个新的state
>
- 缺点：一个组件所需要的数据，必须由父组件传过来，而不能像flux中直接从store取。 当一个组件相关数据更新时，即使父组件不需要用到这个组件，父组件还是会重新render，可能会有效率影响，或者需要写复杂的shouldComponentUpdate进行判断。

#### redux中间件

- 为什么需要redux中间件？
  - 默认情况下，redux只能处理同步数据流。但是实际项目开发中，状态的更新、获取、通常是使用异步操作来实现的。
- 常用的redux中间件？
  - redux-thunk：处理异步操作，主要作用就是可以使action可以变成函数形式，接收两个参数dispatch、getState
  - redux-promise： 处理异步操作
  - redux-logger：打印日志，主要作用在控制台打印输出新老state等信息

# PWA

- PWA不能包含原生OS相关代码。PWA仍然是网站，只是在缓存、通知、后台功能等方面表现更好。Electron程序相当于包裹OS原生启动器（Launcher）的网站，未来，许多Electron程序可能转化为PWA

## Service Workers

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
- **推送通知**：支持通过 Push API 实现推送通知。
>
- **优化建议**：使用 **Workbox**：Google 提供的库，简化 Service Worker 开发，提供缓存策略、路由管理和自动更新等功能。

## Web App Manifest

- 在一个 JSON 文本文件中提供有关应用程序的信息（如名称，作者，图标和描述）。manifest 的目的是将 Web 应用程序安装到设备的主屏幕，为用户提供更快的访问和更丰富的体验。

## 离线存储

### 浏览器存储

- **localStorage**：存储没有截止日期的数据
- **sessionStorage**：当关闭浏览器 **标签页** 时数据会丢失
- **IndexedDB**：HTML5提供的本地数据库存储方案，适用于 大量数据的存储和复杂查询操作‌。
  - 使用：封装个 IndexDBCache 类，用于增、删、改、查 操作。
    - 参考：<https://blog.csdn.net/weiCong_Ling/article/details/131437456>
- cookie 和 浏览器存储 使用场景 对比：
  - cookie 主要用于实现 **用户会话跟踪、身份认证** 等功能。它们常用于存储少量的 用户信息 或 会话标识，以便在服务器端 识别特定用户。
  - 浏览器存储 更适合用于存储大量的数据，如 **用户偏好设置、应用程序配置** 等。由于其大容量和持久性的特点，本地存储在这些场景下表现更为出色。

# 性能优化

## 常规

- **优化图片**：使用适当的图片格式（如 WebP、JPEG 2000）和压缩图片大小，以减少页面加载时的图片大小。
- **优化字体加载**：避免同时加载多个字体文件，选择合适的字体格式和字体加载策略，以提高字体加载速度。
- **使用 CDN 加速**：将静态资源（如图片、CSS、JavaScript 文件）托管在 CDN 上，加速资源的加载速度。
- **减少 HTTP 请求**：合并和压缩 CSS、JavaScript 文件，使用 CSS Sprites 合并小图标，减少页面加载所需的 HTTP 请求次数。
- **延迟加载**：对于页面中不是立即可见的内容（如图片、视频），可以采用延迟加载的方式，等到用户滚动到可见区域时再加载。
- **使用懒加载**：对于长页面或内容较多的页面，可以使用懒加载技术，延迟加载部分内容，减少页面初次加载时的压力。
- **减少重绘和重排**：避免频繁的 DOM 操作、样式改变，以减少浏览器的重绘和重排，提高页面性能。
    - 避免频繁的 DOM 操作，可以一次性修改多个 DOM 节点，或者使用文档片段（DocumentFragment）来减少重排和重绘次数。
    - 避免使用过多复杂的 CSS 选择器，减少样式层级嵌套，以减少 CSSOM 树的构建时间。
    - 避免使用大量复杂的 CSS 动画，尽量使用 CSS3 动画代替 JavaScript 动画，以减少页面重绘次数。
- **代码分割和按需加载**：对于大型应用，可以将代码按照功能模块进行分割，按需加载，减少首屏加载时的代码量。

## React

- 缓存组件：React.memo，通过浅比较 props 发生变化时才会重新渲染
- 缓存大量的计算：useMemo
- 缓存函数：useCallback
- 延迟加载：React.lazy 和 React.Suspense 完成延迟加载
- 当渲染大量列表时，可以使用 `key` 属性来帮助 React 识别每个列表项的唯一性，减少不必要的重新渲染。
- 当需要渲染大量数据时，可以使用虚拟化技术（如 React Virtualized、react-window、react-virtualized 等库）来只渲染可见区域的内容，减少DOM操作，提高性能。

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

# 性能监控

## 监控工具

- Google Lighthouse
- WebPageTest
- 使用 React DevTools 工具来监控组件性能、检测性能瓶颈，并进行优化。
- 网络请求监控：监控网络请求的成功率、响应时间等指标，及时发现接口调用失败或延迟的问题。
- 全局错误处理：在前端代码中添加全局错误处理机制，捕获未被捕获的异常，避免影响用户体验。

## 关键性能指标

- **首次内容渲染（FCP）**：表示浏览器首次绘制页面的时间，即用户可以看到页面上有意义的内容的时间点。较低的FCP时间通常意味着更快的用户体验。
- **可交互时间（TTI）**：表示页面变得可交互的时间点，即用户可以与页面进行交互的时间。较短的TTI时间可以提升用户体验。
- **DOM完成时间**：表示浏览器完成解析DOM树的时间，即页面所有DOM元素都已解析完成的时间点。较快的DOM完成时间可以提升页面加载速度。
- **加载时间（Load Time）**：表示页面完全加载完成的时间，包括页面上所有资源（如图片、CSS、JavaScript）都已加载完成的时间点。较短的加载时间可以提升用户体验。
- **首屏加载时间**；表示页面上首屏内容加载完成的时间，即用户可以看到页面上首屏内容的时间点。较短的首屏加载时间可以提升用户体验。
- **资源加载时间**：表示页面上各种资源（如图片、CSS、JavaScript）加载完成的时间。优化资源加载时间可以提升整体页面加载速度。

# 测试部署

- 自动化测试工具：如 Jest，编写和运行自动化测试用例，确保代码的质量和功能的稳定性。
- CI/CD：Jenkins 和 google action

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
