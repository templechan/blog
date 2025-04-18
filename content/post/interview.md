---
layout: post
title: "前端八股文"
description: "-"
author: "谌中钱"
date: "2025-01-01"
image: "/img/temple-404-bg.png"
categories: [ "Solutions" ]
---

<br />
<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [HTML](#html)
  - [行内元素和块级元素](#行内元素和块级元素)
  - [H5新增标签](#h5新增标签)
  - [图形](#图形)
  - [存储](#存储)
    - [Cookie](#cookie)
    - [Session Storage](#session-storage)
    - [Local Storage](#local-storage)
    - [IndexedDB](#indexeddb)
  - [缓存](#缓存)
    - [客户端缓存](#客户端缓存)
      - [MemoryCache](#memorycache)
      - [Service Worker](#service-worker)
        - [PWA](#pwa)
      - [HTTP缓存（DiskCache）](#http缓存diskcache)
    - [服务器缓存](#服务器缓存)
      - [Nginx 缓存](#nginx-缓存)
      - [CDN 缓存](#cdn-缓存)
  - [多线程](#多线程)
    - [Web Worker](#web-worker)
    - [Service Worker 和 Web Worker 的区别](#service-worker-和-web-worker-的区别)
  - [单、双向通信](#单-双向通信)
    - [SSE](#sse)
    - [WorkSocket](#worksocket)
- [CSS](#css)
  - [页面布局](#页面布局)
    - [flex布局属性](#flex布局属性)
    - [垂直水平居中](#垂直水平居中)
    - [两栏布局](#两栏布局)
    - [三栏布局](#三栏布局)
  - [定位](#定位)
  - [BFC](#bfc)
  - [CSS 动画](#css-动画)
  - [CSS样式隔离方案](#css样式隔离方案)
  - [Less](#less)
  - [常见面试题](#常见面试题)
- [JS](#js)
  - [数据类型](#数据类型)
  - [作用域](#作用域)
  - [原型链](#原型链)
  - [继承](#继承)
  - [闭包](#闭包)
  - [DOM/BOM 对象](#dombom-对象)
  - [Ajax](#ajax)
  - [事件循环](#事件循环)
  - [模块化编程](#模块化编程)
    - [CommonJS](#commonjs)
    - [ES6模块](#es6模块)
  - [ES6+](#es6)
  - [手写代码](#手写代码)
    - [邮箱的正则](#邮箱的正则)
    - [数组去重](#数组去重)
    - [防抖和节流](#防抖和节流)
    - [深拷贝](#深拷贝)
  - [常见面试题](#常见面试题-1)
- [TypeScript](#typescript)
- [React](#react)
  - [版本新增](#版本新增)
  - [生命周期](#生命周期)
  - [事件机制](#事件机制)
  - [虚拟DOM](#虚拟dom)
    - [优化策略](#优化策略)
  - [Fiber架构](#fiber架构)
    - [与传统React渲染机制](#与传统react渲染机制)
  - [Redux](#redux)
    - [三大原则](#三大原则)
    - [redux中间件](#redux中间件)
  - [自定义Hook组件](#自定义hook组件)
- [Next.js](#nextjs)
- [Node后端](#node后端)
- [性能优化](#性能优化)
  - [常规](#常规)
  - [React](#react-1)
- [网络](#网络)
  - [浏览器地址到页面流程](#浏览器地址到页面流程)
  - [HTTP状态码](#http状态码)
  - [跨域](#跨域)
  - [浏览器垃圾回收机制](#浏览器垃圾回收机制)
- [安全](#安全)
  - [常见 Web 漏洞](#常见-web-漏洞)
    - [SQL注入](#sql注入)
    - [跨站脚本攻击 XSS](#跨站脚本攻击-xss)
    - [跨站请求伪造 CSRF](#跨站请求伪造-csrf)
    - [弱口令‌](#弱口令)
- [工程化](#工程化)
  - [Webpack](#webpack)
  - [前端监控](#前端监控)
    - [监控工具](#监控工具)
    - [关键性能指标](#关键性能指标)
- [项目业务](#项目业务)

<!-- /code_chunk_output -->

# HTML

## 行内元素和块级元素

- 区别：
    - 行内元素：span, a, img, input, label
        - 不独占一行
        - 不能设置宽高
        - 宽度 由其内容决定
    - 块级元素: div, p, h1, ul, ol, li, from, table
        - 独占一行
        - 可以设置宽高
        - 宽度 默认是其 父元素的 100%
    - 行内块元素: 通过 CSS 设置, 让 行内元素 可以 设置宽高
        - 不独占一行
        - 可以设置宽高
        - 宽度 由其内容决定
- 转换：
    - display：
        - inline: 使其变为 行内元素
        - block: 使其变为 块级元素
        - inline-block: 使其变为 行内块元素

## H5新增标签

- 语义化标签：header, footer, nav 等
    - 增强代码可读性，方便维护
    - 增强爬虫 SEO
- 多媒体标签：audio, video, track 等
- 表单标签：datalist, progress, meter 等

## 图形

## 存储

- 存储的容量一般 有限制。

### Cookie

- 容量：一般不超过 4KB，1个域名下存放的 Cookie 的个数一般 < 30
- 生命周期：
    - 不能跨标签访问，只能在 domain + path 下访问
    - Session Cookie：当不设置 expires 或 max-age 时，它会在 页面关闭 时被删除
    - Local Cookie：设置 expires 或 max-age
        - max-age 属性：直接以 秒 为单位指定 Cookie 的存活时间
        `let expires = "; expires=" + date.toUTCString();`
        `document.cookie = name + "=" + (value || "")  + expires + "; path=/";`
        - expires 属性：接受一个日期对象，表示 Cookie 的过期时间
        `let maxAge = "; max-age=" + seconds;`
        `document.cookie = name + "=" + (value || "")  + maxAge + "; path=/";`
        - path 属性：指定了 那些 页面 和 主机的路径 可以 访问 和 接收 Cookie，默认值为 根路径 /，以确保所有页面都能访问到这个 Cookie。
        - domain 属性：指定了哪些 页面 和 主机 可以 访问 和 接收 Cookie。默认值为 同一 host，不包含子域名。
            - 如果指定了 Domain，则一般包含子域名。
- 设置 Cookie：`document.cookie = "key=value";`
- 读取 Cookie：`document.cookie`
- 删除 Cookie：`document.cookie="key=value;expires=过去的时间";`

### Session Storage

- 容量：一般 5MB 到 10MB 之间
- 生命周期：
    - 同源下，不能跨标签访问，只能 当前标签 下访问
    - 它会在 页面关闭 时被删除
- 设置：sessionStorage.setItem(key, value) / sessionStorage.key = value
- 读取：sessionStorage.getItem(key) / sessionStorage.key / sessionStorage.valueOf()
- 删除：sessionStorage.removeItem(key) / sessionStorage.clear()

### Local Storage

- 容量：一般 5MB 到 10MB 之间
- 生命周期：
    - 同源下，可以跨标签访问
    - 持久化存储
- 设置：localStorage.setItem(key, value) / localStorage.key = value
- 读取：localStorage.getItem(key) / localStorage.key / localStorage.valueOf()
- 删除：localStorage.removeItem(key) / localStorage.clear()

### IndexedDB

- IndexedDB 是一种 浏览器端 的 NoSQL 数据库。
- 容量：一般限制为 硬盘容量 的 50% 减去一个固定值‌
- 生命周期：
    - 同源下，可以跨标签访问
    - 持久化存储

## 缓存

- 缓存的容量一般 没有限制。
- 缓存优先级：
    - MemoryCache
    - Service Work
    - HTTP缓存（DiskCache）
    - 服务器缓存
- 注意点：
    - MemoryCache 的存在会导致一个问题，ServiceWorker 并不总是对资源有着控制权。
        - 如果遇到业务场景，需要对 ServiceWorker 资源控制权有很强的的要求，那么可以想办法使资源从 MemoryCache 失效。MemoryCache 是受控于 强缓存 的，这意味着我们可以在 ServiceWorker 拦截资源的响应，并设置资源响应头来使资源从 MemoryCache 失效：

            ```js
            self.addEventListener("fetch", (event) => {
                event.respondWith(
                    (async function () {
                        // 从 HTTP 缓存或者网络获取资源
                        const res =  fetch(event.request);
                        // 因为 Response 是一个流，只能用一次，所以这里要 clone 一下
                        const newRes = res.clone();
                        // 改写资源响应头
                        return new Response(res.body, { ...newRes, headers: {
                            'cache-control': 'max-age=0'
                        }});
                    })();
                );
            });
            ```

    - 一般情况下，Service Worker 比 DiskCache  慢，但在 大并发下 Service Worker 比 DiskCache 更快。
        - 由于 Service Worker 的优先级在 DiskCache 之上，我们可以在 Service Worker 进行 资源竞速，同一时间请求 Service Worker 和 DiskCache，哪个先返回就把资源返回上一层：

            ```js
            self.addEventListener("fetch", (event) => {
                event.respondWith(
                    (async function () {
                        const res = Promise.race([
                            // 请求 Service Worker Cache
                            cache.open(CACHE_NAME).then(cache => cache.match(event.request)),
                            // 请求 DiskCache 或者网络资源
                            fetch(event.request)
                        ])
                    })();
                );
            });
            ```

    - 在某些时候，我们比较 ServiceWorker 和 HTTP 缓存有点不公平。ServiceWorker 的用途会更加广泛，它提供了更细力度的缓存控制、使离线化应用 PWA 得以实现、并且对比主线程，他能够使用更多的 CacheAPI 容量。

### 客户端缓存

#### MemoryCache

- MemoryCache 作为第一公民，位于 ServiceWorker 之上。
- 命中了 MemoryCache，就不会触发 ServiceWorker 的 fetch 事件。

#### Service Worker

- 容量：一般范围是 50MB 到 20GB，通用规则是可用空间的 20%
- 生命周期：
    - Service Worker 注册之后，可以独立于浏览器在后台运行，控制一个或多个页面。
    - 即使浏览器关闭，Service Worker 仍然可以运行，但浏览器不会允许它一直处于工作状态。如果 Service Worker 长时间不使用或系统内存有限，浏览器可能会决定销毁它‌。
    - 自由生命周期：
        - install：安装阶段，`self.addEventListener('install', event => { ...`
        - activate：激活阶段
        - active：运行阶段
        - uninstall：卸载阶段
        - fetch：拦截网络请求
        - push: 推送通知
- 注册：`navigator.serviceWorker.register("/service-worker.js")`
- 功能：
    - 请求拦截：跟 Fetch 搭配，可以从浏览器层面拦截请求，做数据 mock
    - 缓存管理：跟 Fetch 和 CacheStorage 搭配，可以做离线应用
    - 推送通知：跟 Push 和 Notification 搭配，可以做像 Native APP 那样的消息推送
- 三方库：
    - 使用 Workbox：Google 提供的库，简化 Service Worker 开发，提供缓存策略、路由管理和自动更新等功能。

##### PWA

- 把 Service Worker 的功能融合在一起，再加上 Manifest 等，就差不多成了 PWA 了。

#### HTTP缓存（DiskCache）

- 容量：无限制，但浏览器的内存缓存（如Chrome的内存缓存）和硬盘缓存（如磁盘缓存）都有一定的存储空间限制
- 生命周期：
    - 强缓存：如果存在且未过期缓存，则直接使用，不向服务器发送请求
        - Cache-Control：优先级高于 Expires，是一个相对时间
            - public：全部缓存
            - private：只能被单个用户的浏览器缓存存储
            - no-cache：每次请求时都必须向服务器验证资源的有效性
            - no-store：不缓存
            - max-age：指定资源在缓存中的最大有效时间
        - Expires：是绝对时间
    - 协商缓存：浏览器在缓存过期后，会向服务器发送请求，携带响应头，如果资源未修改，服务器返回 304 状态码，表示使用缓存资源‌
        - Last-Modified (If-Modified-Since)：基于 时间戳
        - ETag (If-None-Match)：基于 内容哈希值，能更准确地判断资源是否发生变化

### 服务器缓存

#### Nginx 缓存

#### CDN 缓存

## 多线程

### Web Worker

- 多线程：worker.js
    - 监听 self.onmessage 事件
        - 通过 event.data 接收主线程发来的消息
        - 执行计算密集型任务
    - 通过 self.postMessage 发送结果回 主线程
- 主线程：
    - 注册：`new Worker("/worker.js")`
    - 通过 worker.postMessage 发送结果给 多线程
    - 监听 worker.onmessage 事件
        - 通过 event.data 接收 多线程 发来的消息
- 卸载 WebWorker
    - 多线程：self.close()
    - 主线程：worker.terminate()

### Service Worker 和 Web Worker 的区别

- 相同点：都是在常规的 JS 引擎线程以外开辟了新的 JS 线程
- 不同点：Service Worker 是 Web Worker 进一步发展的产物
    - Service Worker 不是服务于某个特定页面的，而是服务于多个页面的。（按照同源策略）
    - Service Worker 会常驻在浏览器中，即便注册它的页面已经关闭，Service Worker 也不会停止。本质上它是一个后台线程，只有你主动终结，或者浏览器回收，这个线程才会结束。
    - 生命周期、可调用的 API 等等也有很大的不同。
    - 应用场景：
        - Web Worker：在后台运行重度计算的任务，从而不阻塞主线程。
        - Service Worker：作为一个代理，它位于 Web应用程序 与 网络 之间，允许你控制 网络请求、缓存内容 和 提供离线支持。

## 单、双向通信

### SSE

- SSE (Server-Sent Events) 是基于 HTTP 协议的，它建立的是单向通道，只允许 服务器 向 浏览器 发送数据。这意味着客户端（浏览器）可以接收服务器的实时更新，但无法直接通过 SSE 向 服务器 发送数据。
- 注册：`let source = new EventSource("demo_sse.php")`
- 接收消息：`source.onmessage = function(event) { event.data ...`

### WorkSocket

- 原理：
    - 握手阶段：
        - 客户端发起一个 HTTP 请求，包含一个特殊的头部字段 Upgrade: websocket 等。
        - 服务器收到这个带有特殊头部字段的请求后，如果支持 WebSocket 协议，就会进行协议升级。服务器返回的响应中包含了状态码 101。
        - 一旦客户端收到带有状态码 101 的响应，说明握手成功，此时连接升级完成。
    - 通信阶段：一旦握手成功，浏览器和服务器之间的通信就切换到了 WebSocket 协议。双方可以通过 WebSocket 协议进行实时双向通信，而不再依赖于传统的请求-响应模型。
- 优缺点：
    - 优点：
        - 实时性（双向通信）
        - 跨域（没有同源限制，客户端可以与任意服务器通信）
    - 缺点：
        - 需要 浏览器 和 服务器 同时支持
- 客户端 API：

    ```js
    let ws = new WebSocket(wss://ip地址/访问路径); 
    // 连接成功时触发
    ws.onopen = () => {}
    // 接收到服务器的消息时触发，res.data 是服务器返回的消息
    ws.onmessage = (res) => {}
    // 关闭连接时触发
    ws.onclose = () => {}
    // 发生错误时触发
    ws.onerror = () => {}
    // 发送消息
    ws.send(data);
    // 关闭连接
    ws.close();
    // 表示连接状态，可以是 CONNECTING (0), OPEN (1), CLOSING (2), 或 CLOSED (3)。
    socket.readyState
    // 未发送至服务器的字节数, 可以用来控制发送速率，避免发送过快导致数据丢失。
    socket.bufferedAmount
    ```

- 服务端 API: 通常借助第三方库，如 Python 的 websockets 等

# CSS

## 页面布局

### flex布局属性

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

### 垂直水平居中

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

### 两栏布局

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

### 三栏布局

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

## 定位

- **static**（默认）：按照正常的文档流进行排列
- **relative**：**相对定位**，相对于其正常位置进行定位。**即使进行了偏移，也不会影响文档流中的其他元素。**
- **absolute**：**绝对定位**，相对于最近的已定位祖先元素（如果不是，则相对于初始包含块）进行定位。**元素会脱离正常文档流。**
- **fixed**：**固定定位**，相对于浏览器窗口进行定位。**即使页面滚动，元素的位置也不会改变。**
- **sticky**：**粘性定位**，可以看作是相对定位和固定定位的混合。元素在跨越特定阈值前为相对定位，之后为固定定位。**必须指定一个阈值**（如 `top`、`right`、`bottom` 或 `left`），否则行为与相对定位相同。

## BFC

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

## CSS 动画

- **transition**: 过渡属性，它的实现需要触发一个事件（比如鼠标移动上去，焦点，点击等）才执行动画。
    - 它类似于 flash 的补间动画，设置一个开始关键帧，一个结束关键帧。
- **animation**: 动画属性，它的实现不需要触发事件，设定好时间之后可以自己执行，且可以循环一个动画。
    - 它也类似于 flash 的补间动画，但是它可以设置多个关键帧（用 `@keyframe` 定义）完成动画。

## CSS样式隔离方案

- 模块化前端框架：
    - 使用 **CSS Modules**: 通过生成唯一的类名来实现样式隔离的技术。每个模块（文件）中的样式都会自动被本地化，避免与其他模块的样式冲突。
        - 是在 构建阶段 对 CSS类名选择器 **限定作用域** 的一种方式。
        - 所有样式都是局部作用域的，解决了全局污染问题
- 组件化的样式管理：
    - 使用 **CSS-in-JS**: 是在 JS 中直接编写 CSS 的技术，相关工具如 **emotion**。
        - 样式与组件逻辑耦合，增强模块化。
        - 支持动态计算样式，便于主题切换等场景。

## Less

- @变量名：变量值
- less还可以像js一样的来封装函数，需要时可以直接调用。
- Mixins可帮助您将一组规则集中的一组属性添加到另一组规则集中。

## 常见面试题

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
- **说说 em/px/rem/vh/vw 区别？**
  - **px**：绝对单位，页面按精确像素展示
  - **em**：相对单位，基准点为父节点字体的大小，如果自身定义了font-size按自身来计算，整个页面内1em不是一个固定的值
  - **rem**：相对单位，相对的只是 HTML根元素 font-size 的值
  - **vw / vh**：就是根据窗口的宽度，分成100等份，100vw 就表示满宽，同理，vh 则为窗口的高度。主要用于页面视口大小布局，在页面布局上更加方便简单。
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

- **手写**: CSS 多行文本 字数过多显示 … ？

    ```css
    -webkit-line-clamp: 2：// 用来限制在一个块元素显示的文本的行数，为了实现该效果，它需要组合其他的WebKit属性）
    display: -webkit-box; // 和1结合使用，将对象作为弹性伸缩盒子模型显示
    -webkit-box-orient:vertical; // 和1结合使用 ，设置或检索伸缩盒对象的子元素的排列方式

    overflow: hidden; // 文本溢出限定的宽度就隐藏内容
    text-overflow: ellipsis; // 多行文本的情况下，用省略号“…”隐藏溢出范围的文本
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

# JS

## 数据类型

- 基本类型（值类型）：Number、String、Boolean、Undefined、Null
- 复杂类型（引用类型）
  - Object、Array、Function、Date、RegExp
  - 基本包装类型：Number、String、Boolean
  - 单体内置对象：Global、Math
- ES6 语法新增：Symbol、BigInt 数据类型

- JS 类型检测方式：
  - **typeof**：能判断所有值类型，函数。不可对 null、对象、数组进行精确判断，因为都返回 object
  - **instanceof**：主要用于检测引用类型，根据对象的原形链往上找，如果原形链上有右边函数.prototype，返回true;否则返回false
  - **Object.prototype.toString.call()**：
    - 由于原形链的检测有漏洞 (原型是可以改变的)，所以会造成检测结果不准确，所以可以采用此种形式。
    - 所有原始数据类型都是能判断的，还有 Error 对象，Date 对象等。

## 作用域

- 定义：作用域就是 变量与函数 的 可访问范围，控制着 变量与函数 的 可见性 和 生命周期。
- 变量的作用域有 **全局作用域** 和 **局部作用域** 两种。
  - ES6中新增 **块级作用域**。

## 原型链

- 定义：对象通过隐式原型( `__proto__` )属性指向其构造函数的原型对象( prototype )，进而通过原型对象( prototype )的隐式原型( `__proto__` )属性指向更高层级的原型对象( prototype )，最顶端是 Object.prototype，最终指向 null 而停止所形成的链条，则称其为原型链。

- 平时工作中用到哪些原型上的属性或者api
    - 节点操作API：nodeName，nodeValue，children
    - ‌静态方法：getPrototypeOf，keys，values
    - 数组API：find，includes
- 怎么判断该属性是实例的还是原型对象上的
    - hasOwnProperty

## 继承

- 原型链继承：让新实例的原型是另一个构造函数的实例
  - 原型链继承原型上的属性和方法
- 构造函数继承
  - 构造函数继承实例属性
- 组合继承：上面结合
- 原型式继承
- 寄生式继承
- 寄生组合式继承

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
- 应用场景：
    - 自执行函数
    - 防抖节流
    - 链式调用

## DOM/BOM 对象

- DOM:
  - Document：代表整个HTML文档。这是DOM树的根节点，可以通过document对象访问。
  - Element：表示HTML元素，如 div、p 等。
  - Node：所有 DOM节点 的基类，包括元素、属性、文本等。
  - Event：用于处理和生成事件的对象
  - Text：表示元素或属性中的文本内容。
  - Attr：表示HTML元素的属性
  - NodeList：可以包含各种类型的节点，包括元素节点（Element）、文本节点（Text）、注释节点（Comment）等
  - HTMLCollection：它只包含元素节点（Element），常被用作表示 动态元素 集合的方式。
    - Element 节点 继承自 Node 节点
- BOM 常用对象:
  - Window：代表浏览器窗口或框架。window对象是全局对象，所有的全局JavaScript对象、函数以及变量都自动成为window对象的成员。
  - Navigator：提供关于 浏览器 的信息，如名称、版本等。可以通过 window.navigator 访问。
  - Location：提供当前窗口的URL信息，可以通过 window.location 访问。
  - History：包含用户（在浏览器窗口中）访问过的URL。可以通过window.history访问。
  - Screen：提供有关用户屏幕的信息。可以通过window.screen访问。
  - Performance: 提供关于页面性能的信息。可以通过window.performance访问。
  
## Ajax

```js
// 创建 XMLHttpRequest 对象
let xhr = new XMLHttpRequest();

// 设置请求类型和 URL
xhr.open('GET', 'server/data.json'); // 第三个参数设置为false表示同步请求
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
// 取消请求
xhr.abort();
```

## 事件循环

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

## 手写代码

### 邮箱的正则

```js
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

const email = "templechan@126.com.cn";
console.log(emailRegex.test(email));
```

### 数组去重

- **1.** Lodash：第三方工具库

    ```js
    import _ from 'lodash';
    let arr = [12,1,12,3,1,88,66,9,66];
    console.log(_.uniq(arr));
    ```

- **2.** Set: 一种数据结构, 成员唯一

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    
    const unique = (arr = []) => {
        return [...new Set(arr)];
        // return Array.from(new Set(arr));
    };
    console.log(unique(arr));
    ```

- **3.** filter + Map.has

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    const unique = (arr = []) => {
        let map = new Map();
        return arr.filter(ele => {
            return map.has(ele) ? false : map.set(ele, ele);
        })
    };
    console.log(unique(arr));
    ```

- **4.** filter + indexOf, includes

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    const unique = (arr = []) => {
        let newArr = [];
        return arr.filter(ele => {
            return newArr.indexOf(ele) !== -1 ? false : newArr.push(ele);
            // return newArr.includes(ele) ? false : newArr.push(ele);
        });
    };
    console.log(unique(arr));
    ```

- **5.** filter + hasOwnProperty: 检测一个 对象自身 是否具有指定的属性

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    const unique = (arr = []) => {
        let obj = {};
        return arr.filter(ele => {
            return obj.hasOwnProperty(ele) ? false : obj[ele] = ele;
        });
    };
    console.log(unique(arr));
    ```

- **6.** filter + sort

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    const unique = (arr = []) => {
        return arr.sort().filter((ele, index, arr) => {
            return index === 0 || ele !== arr[index - 1];
        });
    };
    console.log(unique(arr));
    ```

- **7.** reduce + includes

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    const unique = (arr = []) => {
        return arr.reduce((pre, cur) => {
            return pre.includes(cur) ? pre : [...pre, cur];
        }, []);
    };
    console.log(unique(arr));
    ```

- **8.** 对象 属性名 不能重复 + splice

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    const unique = (arr = []) => {
        let obj = {};
        for (let i = 0; i < arr.length; i++) {
            let cur = arr[i];
            if (obj[cur]) {
                arr.splice(i, 1); // 引发数组塌陷
                i--; // 由于数组塌陷，需要调整索引值
                continue;
            }
            obj[cur] = cur;
        }
        return arr;
    };
    console.log(unique(arr));
    ```

- **9.** sort + splice

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    
    const unique = (arr = []) => {
        arr.sort();
        for (let i = 0; i < arr.length; i++) {
            if (arr[i] === arr[i+1]) {
                arr.splice(i, 1);
                i--;
            }
        }
        return arr;
    };
    console.log(unique(arr));
    ```

- **10.** 冒泡 + splice

    ```js
    let arr = [12,1,12,3,1,88,66,9,66];
    const unique = (arr = []) => {
        for (let i = 0; i < arr.length; i++) {
            for (let j = i + 1; j < arr.length; j++) {
                if (arr[j] === arr[i]) {
                    arr.splice(j, 1);
                    j--;
                }
            }
        }
        return arr;
    };
    console.log(unique(arr));
    ```

### 防抖和节流

- 防抖: 是指在事件被触发 n 秒后再执行回调，如果在这 n 秒内又被触发，则重新计时。

    - Lodash：第三方工具库

        ```js
        import _ from 'lodash';

        _.debounce(fn, 250);
        ```

    - 手写:

        ```js
        const debounce = (fn, wait) => {
            let timeout;

            return (...args) => {
                clearTimeout(timeout);

                timeout = setTimeout(() => {
                    fn.apply(this, args);
                }, wait);
            };
        }
        ```

- 节流: 是指规定在 单位时间 内，只能触发 一次 函数。如果这个 单位时间 内触发多次函数，只有第一次会生效。

    - Lodash：第三方工具库

        ```js
        import _ from 'lodash';

        _.throttle(fn, 250);
        ```

    - 手写:

        ```js
        const throttle = (fn, limit) {
            let inThrottle;
            
            return (...args) => {
                if (!inThrottle) {
                    fn.apply(this, args);

                    inThrottle = true;
                    setTimeout(() => {
                        inThrottle = false;
                    }, limit);
                }
            };
        }
        ```

### 深拷贝

- Lodash：第三方工具库

    ```js
    import _ from 'lodash';
    _.cloneDeep(original);
    ```

- 手写：
    - 序列化：
        - 拷贝的对象中如果有 function、undefined、symbol，当使用过JSON.stringify()进行处理之后，都会消失
        - 无法拷贝不可枚举的属性
        - 无法拷贝对象的原型链
        - 等等...

        ```js
        let obj2 = SON.parse(JSON.stringify(obj1));
        ```

    - 递归: 使用 for in 来遍历传入参数的属性值

        ```js
        function deepClone (source, map = new Map()) {
            if (source instanceof Object === false) return source;
            let target = Array.isArray(source) ? [] : {};

            // 解决 环引用 爆栈问题
            if (map.get(source)) {
                return map.get(source);
            }
            map.set(source, target);

            for (let i in source) {
                // 判断是否是自身属性，过滤掉 继承 而来的属性
                if (source.hasOwnProperty(i)) {
                    if (typeof source[i] === 'object') {
                        target[i] = deepClone(source[i], map);
                    } else {
                        target[i] = source[i];
                    }
                }
            }
            return target;
        }
        ```

## 常见面试题

- 遍历方法

    - **forEach()**：用于调用数组的每个元素，并将元素传递给回调函数。数组中的每个值都会调用回调函数。
    - **map()**：会返回一个新数组，数组中的元素为原始数组元素调用函数处理后的值。该方法按照原始数组元素顺序依次处理元素。
    - **filter()**：用于过滤数组，满足条件的元素会被返回。
    - **some()**：只要有一个元素符合条件，就返回true，且剩余的元素不会再进行检测，否则就返回false。
    - **every()**：只有所有元素都符合条件时，才返回true，如果数组中检测到有一个元素不满足，则整个表达式返回 false。
    - **reduce()**：上一次调用回调返回的值传到下一次遍历
    - **reduceRight()**：从右到左
    - **find()**：通过函数内判断的数组的第一个元素的值。当数组中的元素在测试条件时返回 true 时， find() 返回符合条件的元素，之后的值不会再调用执行函数。如果没有符合条件的元素返回 undefined。 ​
    - **findIndex**：符合条件的数组第一个元素位置（索引）

- this/call/apply/bind

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
            // 因为arguments是类数组，它不存在slice方法，所以这里我们可以将数组原型上的slice指向arguments，这样 arguments就拥有了slice方法
            let args = Array.prototype.slice.call(arguments, 1)
    
            // 创建一个空函数
            let fnTemp = function () { };
    
            // bind会返回一个函数
            let fnBind = function () {
                // 将this指向context
                // 因为bind返回的函数可能被调用多次，所以这里需要将参数进行合并
    
                // 判断是否是new调用，如果是new调用，this 会指向实例，将绑定函数的this指向该实例，可以让实例获得绑定函数    的值
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

- 找出数组中最大的版本号，[2.4.1, 2.5.2, 2.4.223]，返回'2.5.2'？
- 两个超出 Number 最大值的数相加？
- 有一个函数，接受了一个参数，根据参数的不同用 if 和 if else 分别来返回不同的结果，根据 设计模式 来简化时间复杂度？
    - 借助短路运算符：&&，||
    - Switch 语句:

        ```js
        function handleType(type) {
            switch (type) {
                case 'A': 
                    console.log('处理类型 A'); 
                    break; 
                case 'B': 
                    console.log('处理类型 B'); 
                    break; 
                case 'C': 
                    console.log('处理类型 C'); 
                    break; 
                default: 
                    console.log('未知类型'); 
                    break; 
            } 
        }
        ```

    - 使用 对象映射:

        ```js
        const typeHandlers = {
            A: () => console.log('处理类型 A'),
            B: () => console.log('处理类型 B'),
            C: () => console.log('处理类型 C'),
            default: () => console.log('未知类型')
        };
        
        function handleType(type) {
            (typeHandlers[type] || typeHandlers.default)();
        }
        ```

    - 使用 策略模式：定义一系列的算法，并将每一种算法封装起来，使它们可以相互替换。此模式让算法的变化独立于使用算法的客户。

        ```js
        class Strategy {
            static A() { console.log('处理类型 A'); }
            static B() { console.log('处理类型 B'); }
            static C() { console.log('处理类型 C'); }
        }
        
        function handleType(type) {
            const methodName = `static ${type}`;
            if (Strategy[methodName]) {
                Strategy[methodName]();
            } else {
                console.log('未知类型');
            }
        }
        ```

        - 可以直接使用 函数 来模拟策略模式，避免了创建类的开销

            ```js
            const strategyA = (data) => data * 2; // 策略A函数
            const strategyB = (data) => data * 3; // 策略B函数
            
            function context(strategy, data) {
                return strategy(data); // 执行具体策略函数
            }
            
            console.log(context(strategyA, 5)); // 输出: 10
            console.log(context(strategyB, 5)); // 输出: 15
            ```

- 打印值顺序的题，根据 async await？
    - async await 执行顺序：
        - 当 await 后面的函数是 同步函数 时，返回是 字符串 和 返回 promise 执行顺序一致，都按照 微任务列表 执行。
        - 当 await 后面的函数是 异步函数 时，返回是 字符串 同上，但如果返回 promise，此时任务会被放在微任务末尾，最后执行

    ```js
    console.log("script start");

    new Promise((resolve) => {
        console.log("promise1");
        resolve('微任务1');
    })
    .then((data) => { //第一个Promise加入微任务列表
        console.log(data);
    });

    async function fun1() {
        console.log("fun1");
        let data = await fun2(); // 关键的地方，await后面的代码会阻塞 ，fun2执行完毕后，后面的代码类似于传入then()中的回调
        console.log(data);
        console.log("await堵塞");
    }

    setTimeout(() => {
        console.log("setTimeout 宏任务"); //一个宏任务，加入宏任务队列
    }, 0)

    async function fun2() {
        console.log("fun2");
        // return "no promise"
        return new Promise((resolve, reject) => {
            resolve("fun2 微任务")
        })
        // return "await"
    }

    fun1(); // 代码开始执行

    new Promise((resolve) => {
        console.log("promise2");
        resolve("微任务2");
    })
    .then((data) => { // promise状态已经 fulfilled，直接加入微任务队列
        console.log(data);
    })


    console.log("同步end"); // 同步代码结束

    // 输出结果：
    // script start
    // promise1
    // fun1
    // fun2
    // promise2
    // 同步end
    // 微任务1
    // 微任务2
    // fun2 微任务
    // await堵塞
    // setTimeout 宏任务
    ```

# TypeScript

- **TS 的好处**：
    - typeScript是JavaScript的超集，添加了可选的静态类型和基于类的面向对象编程，扩展了JavaScript的语法。它提供了一种更强大的编程语言，具备更强的类型检查和更好的代码可读性。
- **TypeScript 的基础类型**包括：number、string、boolean、array和object。
- **泛型的使用：**
    - 泛型是指在定义函数、接口或类时，不预先指定具体类型，而是在使用时再指定类型的一种特性。泛型可以理解为代表类型的参数。
- **类型与接口的区别是什么？**
    - 接口主要用于描述数据结构，而类型则用于声明基本类型别名、联合类型和元组等。虽然两者都可以拓展，但语法有所不同。接口可以继承类型，类型也可以继承接口。
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
  - 类型断言 as 允许程序员手动指定一个值的类型。这在需要明确告诉编译器某个值的类型时非常有用。
  - `let strLength: number = (someValue as string).length;`
- **常用内置类型工具**
  - Partial：可选
  - Required：必选
  - Readonly：只读
  - `Record<Keys, Type>`：构造一个对象类型，其属性键为Keys，属性值为Type。

# React

## 版本新增

- 15：
    - 创建组件类：可以使用 createClass 方法来创建组件类
    - shouldComponentUpdate：允许你手动控制组件的重新渲染
- 16：
    - Hooks
    - Fiber 架构：对核心算法进行了重写。Fiber 架构改进了 React 的调度能力和性能，使得 React 更好地处理大规模和复杂的应用程序。
    - 改进的事件处理系统：对新的事件系统 SyntheticEvent 的支持
    - Fragment：Fragment 是一种新的组件，它允许你在不添加多余 DOM 元素的情况下包裹多个子元素。使用 Fragment，你可以更好地组织你的组件结构，而不会引入额外的 DOM 层级。
- 17：
    - 稳定的事件系统：引入了稳定的事件系统，不再使用合成事件的事件委托机制。这意味着你可以直接在事件目标上注册事件监听器，而不必担心事件委托带来的一些限制和问题。
    - 自动批处理：多个setState调用会被自动合并成一个单一的更新。
- 18：
    - 基于树的协调：引入了基于树的协调算法，通过部分更新来提高渲染性能。这包括增量渲染和更好的调度机制，使得 React 可以更高效地处理大型应用程序。
    - 可中断和恢复的渲染
    - 自动批量更新：引入了自动批量更新机制，减少了不必要的重渲染。

## 生命周期

- 类组件 生命周期：
  - 挂载阶段：
    - constructor：初始化组件的 state，给事件处理方法绑定 this
    - getDerivedStateFromProps：会返回一个对象用来更新当前的 state 对象，如果不需要更新可以返回 null。
    - render
    - componentDidMount：执行依赖于DOM的操作，发送网络请求，添加订阅消息
  - 更新阶段：
    - getDerivedStateFromProps
    - shouldComponentUpdate：决定组件是否需要重新渲染。它接收新的props和新的state作为参数，如果返回true，则组件会重新渲染
    - render
    - getSnapshotBeforeUpdate
    - componentDidUpdate
  - 卸载阶段：
    - componentWillUnmount：清除 timer，取消网络请求或清除，取消在 componentDidMount 中创建的订阅等

- 函数组件 生命周期 钩子：
  - useState()：管理组件的状态，类似于类组件中的 this.state 和 this.setState。
    - setVisible 异步，同步时机：
        - 当在 合成事件 和 钩子函数 中调用时，是 异步更新 的。
            - 同步方法：
                - 使用 useRef 存值
                - 使用 useLayoutEffect
        - 当在 原生事件 和 setTimeout、Promise.resolve().then 中调用时，都是同步的。
        - 原因：在 React 合成事件中，React 通过事件代理和统一的事件处理机制，能够对setState调用进行拦截和批量处理。然而，在原生 DOM 事件或setTimeout回调中，React 无法感知这些setState调用。因此，setState按照常规的同步方式执行，状态更新后立即触发组件的重新渲染。
    - 使用 函数形式 的 setVisible(pre => pre + 1) ，可以帮助确保每次状态更新都是 独立 的。
  - useEffect()：类似于 componentDidMount 和 componentDidUpdate 的合并，以及 componentWillUnmount 功能
    - 通过返回一个清理函数可以在组件卸载时执行一些操作
    - 第二个参数缺失时：每次渲染都会执行
    - 第二个参数为 [] 时，只会在首次渲染执行一次
    - 第二个参数为有值时，值发生变化就会执行
    - 如果副作用的依赖项是对象、数组或函数，在每次渲染时，JavaScript 引擎会为这些值创建新的引用。为了避免 useEffect 反复执行，可以使用 useCallback 或 useMemo 来记住函数或计算值。
  - React.memo，React.PureComponent：避免在 props 未改变时的不必要渲染
  - useMemo 和 useCallback：缓存值和函数
- 区别：
    - 类组件：
        - 优点：易于扩展，通过继承和组合，类组件可以很容易地扩展其他组件的功能。
        - 缺点：冗余代码，性能开销，它们创建了更多的实例和方法。
    - 函数组件：
        - 优点：
            - 简洁性
            - 性能更好：不涉及类的实例化，也没有额外的继承开销。
            - Hooks：函数组件配合Hooks可以非常方便地处理状态、副作用和上下文等。
        - 缺点：
            - 不适合所有场景，对于需要使用复杂生命周期逻辑的场景，类组件仍然是必要的。

## 事件机制

- React基于浏览器的事件机制自身实现了一套事件机制，包括事件注册、事件的合成、事件冒泡、事件派发等，在React中这套事件机制被称之为合成事件。
- 合成事件：实际并不会把事件代理函数直接绑定到真实的节点上，而是把所有的事件绑定到结构的最外层，使用一个统一的事件去监听。当组件挂载或卸载时，只是在这个统一的事件监听器上插入或删除一些对象。简化了事件处理和回收机制，效率也有很大提升。
- React合成事件与原生事件执行顺序：
  - React 所有事件都挂载在 document 对象上
  - 当真实 DOM 元素触发事件，会冒泡到 document 对象后，再处理 React 事件
  - 所以会先执行原生事件，然后处理 React 事件
  - 最后真正执行 document 上挂载的事件
- 总结：
  - React 上注册的事件最终会绑定在 document 这个 DOM 上，而不是 React 组件对应的 DOM (减少内存开销就是因为所有的事件都绑定在 document 上，其他节点没有绑定事件)
  - React 自身实现了一套事件冒泡机制，所以这也就是为什么我们 event.stopPropagation() 无效的原因。
  - React 通过队列的形式，从触发的组件向父组件回溯，然后调用他们 JSX 中定义的 callback
  - React 有一套自己的合成事件 SyntheticEvent

## 虚拟DOM

- 当组件的状态发生变化时，React首先会在内存中创建一个新的 **虚拟DOM树** 来表示更新后的UI结构。
- 然后，React会将这个 新的虚拟DOM树 与 旧的虚拟DOM树 进行比较（这个过程称为 Diff算法）。
- Diff算法 会找出两个虚拟DOM树之间的 **差异**，例如 哪些节点被添加、删除或者修改了。
- 最后，React 根据这些差异计算出 **最小的DOM操作集合**，只将这些必要的操作应用到实际的DOM上，从而提高性能，避免了直接操作真实DOM带来的大量 重绘和回流。

### 优化策略

- **同一层级的节点进行比较**：React只在同一层级的节点之间进行比较，不会跨层级去查找差异。这样可以大大减少比较的复杂度。
- **组件类型比较**：如果两个节点的组件类型不同（例如一个是 div，一个是 span），React会直接认为这是一个 **全新的节点**，会销毁旧节点及其子节点，并创建新节点及其子节点，而不会深入比较子节点。
- **列表渲染优化**：当渲染列表时，如果给每个列表项设置了唯一的key属性，React可以根据key来更高效地识别哪些列表项是新增、删除或者移动的。

## Fiber架构

- React Fiber是React 16引入的一种新的协调引擎。
- 它的主要改进包括：
  - **可中断 和 可恢复 的渲染**：React Fiber可以将渲染工作分解成多个小任务，并且可以根据优先级暂停和恢复这些任务。这使得浏览器有更多的机会进行其他操作，如响应用户交互，提高了用户体验。
  - **更好的调度能力**：能够更合理地安排不同类型任务的执行顺序，例如先执行高优先级的更新（如用户交互触发的更新），再执行低优先级的更新（如数据获取后的更新）。
  - **支持并发模式**：允许 React 同时处理多个任务，例如在渲染新内容的同时还能响应用户的输入操作。

### 与传统React渲染机制

- 传统React渲染是基于 **递归调用** 的，一旦开始渲染就会一直进行下去直到完成。
- React Fiber采用了 **基于链表** 的数据结构来表示组件树，并且可以将渲染任务分解成多个小的任务单元（Fiber节点）。
- 在任务调度方面，传统React没有很好的中断和恢复机制，而React Fiber可以根据优先级灵活地中断和恢复渲染任务。
- 在并发模式下，传统React只能顺序执行任务，而React Fiber可以同时处理多个任务，提高了资源利用率和响应速度。

## Redux

### 三大原则

- **单一数据源**：整个应用的state被存储在reducer中，并且这个reducer只存在于唯一一个store
- **state是只读的**：唯一能改变 state 的就是 action, action是一个用于描述已发生事件的对象,通过 store 中的 dispatch方法 来发送 action，store.dispatch(action)
- **使用纯函数（reducer）来执行修改**: reducer是一个纯函数，它接受老的state，action，并且返回一个新的state
>
- 缺点：一个组件所需要的数据，必须由父组件传过来，而不能像 flux 中直接从store取。 当一个组件相关数据更新时，即使父组件不需要用到这个组件，父组件还是会重新render，可能会有效率影响，或者需要写复杂的shouldComponentUpdate进行判断。

### redux中间件

- 为什么需要 redux中间件？
  - 默认情况下，redux 只能处理同步数据流。但是实际项目开发中，状态的更新、获取、通常是使用异步操作来实现的。
- 常用的redux中间件？
  - redux-thunk：处理异步操作，主要作用就是可以使 action 可以变成函数形式，接收两个参数 dispatch、getState
  - redux-promise： 处理异步操作
  - redux-logger：打印日志，主要作用在控制台打印输出新老state等信息

## 自定义Hook组件

自定义 Hook：

```js
import { useState, useEffect } from 'react';
 
function useCountdown(initialTime) {
  const [timeLeft, setTimeLeft] = useState(initialTime);
 
  useEffect(() => {
    if (timeLeft > 0) {
      const timer = setTimeout(() => {
        setTimeLeft(timeLeft - 1000); // 每次减少1000毫秒（1秒）
      }, 1000);
      return () => clearTimeout(timer); // 清除定时器以避免内存泄漏
    } else {
      console.log('倒计时结束');
    }
  }, [timeLeft]);
 
  return timeLeft;
}
```

使用 Hook：

```js
import React from 'react';
import useCountdown from './useCountdown'; // 确保路径正确
 
function CountdownTimer() {
  const timeLeft = useCountdown(10000); // 例如，设置倒计时为10秒（10000毫秒）
  const minutes = Math.floor(timeLeft / 60000);
  const seconds = Math.floor((timeLeft % 60000) / 1000);
 
  return (
    <div>
      <p>倒计时: {minutes}:{seconds < 10 ? `0${seconds}` : seconds}</p>
    </div>
  );
}
 
export default CountdownTimer;
```

# Next.js

- 优缺点：
    - 优点：
        - SSR: 使得页面加载速度快，有利于SEO。
        - SSG: 支持静态站点生成，适用于内容不经常更新的网站，可以进一步提高性能。
        - 文件系统路由: 使得页面结构与文件目录结构相匹配，易于理解和维护。
        - API 路由: 内置的 API 路由功能允许开发者轻松创建 RESTful API 或 GraphQL API，无需额外的配置。
        - 自动代码拆分: 优化了应用的加载时间。
        - 内置图像优化: 通过 next/image 组件，Next.js 提供了图像优化功能，包括懒加载和占位符。
    - 缺点：
        - 配置复杂性: 在某些高级配置和自定义功能时，可能需要深入了解其配置选项。
        - 性能开销：过度使用 SSR 或 SSG 而非根据实际需求选择合适的渲染方式。
        - 资源占用: 在服务器端的资源占用可能相对较高，尤其是在高流量的情况下。
        - 构建时间: 对于大型项目，Next.js 的构建时间可能会比较长，特别是在开发模式下频繁构建时。
        - 灵活性限制: 在某些情况下，它可能限制了开发者对底层技术栈的完全控制。例如，在某些复杂的自定义服务器配置中可能会遇到限制。
- 支持 CSR, SSG, SSR
    - CSR 客户端渲染：适用于需要 **交互性** 和 **快速加载** 的 非静态内容的单页应用。
    - SSG 静态站点生成：适用于 **静态内容**，构建时生成页面。
    - SSR 服务端渲染：适用于需要 服务器端数据的 **动态内容**。
- SSG: 通过 getStaticProps 获取数据

    ```js
    // pages/about.js
    export async function getStaticProps(context) {
    // 获取数据
    const data = await fetch('https://api.example.com/data').then(res => res.json());
    
    // 将数据返回给页面
    return {
        props: { data }
    }
    }
    
    export default function About({ data }) {
    return (
        <div>
        <h1>About Us</h1>
        <p>{data.description}</p>
        </div>
    );
    }
    ```

- SSR: 通过 getServerSideProps 获取数据

    ```js
    // pages/dynamic.js
    export async function getServerSideProps(context) {
    // 从 API 获取数据
    const res = await fetch('http://localhost:3000/api/data');
    const data = await res.json();
    
    // 将数据返回给页面
    return {
        props: { data }
    }
    }
    
    export default function DynamicPage({ data }) {
    return (
        <div>
        <h1>Dynamic Page</h1>
        <p>{data.description}</p>
        </div>
    );
    }
    ```

- 路由：
    - 页面路由：定义客户端渲染的页面。
        - 这些文件通常位于 pages 目录下。
    - API路由：处理数据请求的一种特殊类型的路由。
        - API 路由通常位于 pages/api 目录下
        - Next.js API 适用于高并发、Serverless 场景
            - Express 适用于长时间运行的后端服务
    - 动态路由：具有动态参数的页面，这些参数可以在运行时确定
- 水合：是 Next.js 在 SSG 和 SSR 中将服务器端渲染的 静态 HTML 转换 为 交互式 React 应用的过程。
    - 水合过程：
        - 构建虚拟 DOM：React 使用 props 数据生成虚拟 DOM。
        - 比较 DOM：React 将虚拟 DOM 与服务器端生成的真实 DOM 进行比较。
        - 绑定事件：React 将事件监听器附加到现有 DOM 节点上，而不是替换它们。
- 优化图片/视频资源
    - Next.js Image组件
        - 延迟加载：默认启用懒加载，仅在需要时加载图像。
        - 自动格式转换：根据用户设备和浏览器选择最佳图像格式（如WebP）。
        - 响应式支持：自动调整图像大小以适应不同设备。
    - CDN加速
- 嵌入结构化数据:
    - 通常使用 JSON-LD 格式编写，嵌入到HTML页面的 head 部分或紧接在 body 标签之前
    - 结构化数据类型：
        - 文章（Article）：用于新闻报道、博客文章等。
        - 事件（Event）：用于展示即将发生的事件。
        - 产品（Product）：用于商品详情页面。
        - 组织（Organization）：用于公司、机构等。
        - 评论（Review）：用于产品或服务的用户评价。
        - 本地业务（Local Business）：用于实体店的位置和营业信息。
    - 验证：使用Google的Structured Data Testing Tool或其他在线工具来验证你的结构化数据是否正确嵌入并符合规范。
- 实现多语言动态切换（i18n）
    - Next.js 从 v9.3 版本开始支持内置的 i18n 功能。
    - 在 pages 目录下创建一个名为 _app.js 的文件（如果还没有的话），并在其中配置 i18n：

        ```
        // pages/_app.js
        import { useRouter } from 'next/router';
        import { useEffect } from 'react';

        function MyApp({ Component, pageProps }) {
            const router = useRouter();

            useEffect(() => {
                // 你可以在这里添加额外的国际化逻辑
            }, [router.locale]);

            return <Component {...pageProps} />;
        }

        export default MyApp;
        ```

    - 在 next.config.js 中配置 i18n：

        ```js
        module.exports = {
        i18n: {
            locales: ['en', 'zh'], // 支持的语言
            defaultLocale: 'en', // 默认语言
        },
        };
        ```

    - 创建多语言页面

        ```
        pages/
            en/
                index.js
            zh/
                index.js
        ```

    - 添加语言切换链接

        ```
        import Link from 'next/link';
        import { useRouter } from 'next/router';

        function Home() {
        const router = useRouter();
        const { locale } = router;

        return (
            <div>
            <h1>Hello World</h1>
            <Link href='/index' locale={locale === 'en' ? 'zh' : 'en'}>
                <a>{locale === 'en' ? 'Switch to Chinese' : '切换到英文'}</a>
            </Link>
            </div>
        );
        }

        export default Home;
        ```

    - 虽然 Next.js 提供了内置的支持，但有时你可能需要更强大的功能，比如消息提取、编译时检查等。这时可以考虑使用第三方库，如 next-i18next 或 react-intl。
- 确保符合 GDPR/CCPA 数据隐私规范，处理Cookie同意弹窗等交互逻辑。
    - GDPR（欧盟通用数据保护条例）
        - 要求： 如果网站面向欧盟用户，使用 Cookies（尤其是非必要的追踪 Cookies）时必须获得用户同意。
        - 影响： 用户需要明确接受或拒绝 Cookies（通常通过弹窗或横幅实现）。
    - CCPA（加州消费者隐私法）
        - 要求： 网站需告知用户其数据如何被收集，并提供选择退出数据出售或共享的功能。
        - 影响： 通常会显示隐私声明通知用户，提供隐私设置入口。
    - 开发者实现:
        - Cookies 和隐私确认是由网站开发者实现的。常见实现方式：
            - Cookies 横幅通知： 页面底部或顶部显示通知，提示用户网站使用 Cookies。
            - 选择同意/拒绝： 用户点击同意后，网站才会存储非必要 Cookies。
            - 动态加载： 网站在用户同意之前，不加载追踪代码或营销工具。
        - 实现时通常会用到以下技术：
            - JavaScript Cookies 库： 例如 js-cookie。
            - 专用插件或服务： 如 OneTrust、Cookiebot 等，专门用于管理隐私和 Cookies 合规。
- 优化 Core Web Vitals​（LCP、FID、CLS）
 - Core Web Vitals 是 Google 提出的用于衡量网站用户体验的核心指标，专注于页面加载速度、交互性和视觉稳定性。主要包括三个指标：
    - LCP：最大内容绘制
        - 衡量页面主内容加载的速度，理想值应在 2.5秒 内加载完主要内容。
        - 影响因素：图片、视频、文本等内容的加载速度
    - FID：首次输入延迟
        - 衡量用户首次与页面交互（如点击链接或按钮）到浏览器响应的时间，理想值应低于 100毫秒。
        - 影响因素：JavaScript 执行延迟、页面的响应性。
    - CLS：累积布局偏移
        - 衡量页面加载过程中视觉稳定性，理想值应低于 0.1。
        - 影响因素：页面加载时元素的移动、图片尺寸未定义等问题。
    - 优化：
        - 浏览器缓存
        - 图片优化
        - 页面压缩
        - 异步加载与延迟加载
        - 使用 CDN 加速
        - HTTP/2 和 HTTPS
        - 数据库优化：数据库清理与索引优化
        - 移动端优化：响应式设计，确保网站在不同设备上自适应，避免不必要的资源加载，提升 LCP 和 CLS。移动端的优化也有助于提升 FID，让用户交互更加流畅。
        - Service Workers：实现离线功能和缓存管理，提高页面加载速度，并减少 LCP 和 FID 的加载延迟。
        - WebAssembly 模块 加载到 Web Worker 中，可以在后台线程中执行高性能的计算任务，而不影响主线程的性能
        - 字体优化
            - Next.js 内置字体优化功能，通过使用 Google Fonts 和其他Web字体，减少字体加载时间。
            - 使用next/font模块加载Google Fonts：

                ```
                import { Roboto } from 'next/font/google';
    
                const roboto = Roboto({
                    subsets: ['latin'],
                    weight: ['400', '700'],
                });
                
                export default function Home() {
                    return <p className={roboto.className}>Hello, World!</p>;
                }
                ```

        - 第三方资源优化:
            - 减少第三方脚本：减少外部脚本（如广告、社交按钮等）的加载数量，并优化其加载顺序，减少 FID 和 CLS 的不稳定性。
            - 优化广告加载：通过异步加载广告脚本，避免广告影响页面的初始加载，提升 LCP 和 CLS。
        - 网络优化：
            - 减少 DNS 查询：使用 DNS 预取 和优化 DNS 设置，减少域名解析延迟，从而减少 FID。
            - TCP连接优化：通过 TCP Fast Open 减少连接延迟，提高 FID。
        - 性能监控与实时分析：定期使用 Lighthouse 和 Core Web Vitals 工具分析和优化网站，确保所有关键指标都处于理想状态。
- 集成 Headless CMS​（如 Contentful/Sanity），管理多语言内容并确保数据实时同步。
    - Contentful 是一个无头CMS。这意味着它是作为一个内容库而构建的，并通过一个API来提供数据。
    - 在Contentful上创建一个账户, 设置内容模型, 向Contentful添加帖子
    - 创建 Next.js 应用程序
        - 向Next.js应用程序添加Contentful凭证：在你的contentful-nextjs-app 项目文件夹中，创建一个.env.local 文件。
        - 设置API: 在你项目的根文件夹中创建一个lib 文件夹。在lib 文件夹中，创建一个api.js 文件。
            - 声明我们需要获取的字段
            - 创建一个自定义的fetchGraphQL 方法，用于与Contentful API建立联系。
            - 对于来自Contentful API的每一个响应，数据将与各种元数据一起返回。

# Node后端

- 一个基于 Chrome V8 引擎的 JavaScript 运行环境，是一个让 JavaScript 运行在服务端的开发平台。

- express.js：TJ 开发的最早出现的一款框架。
    - 基于回调，也是node中最常见的 Error-First 的模式
    - 内置了大多数的中间件，大而全，更让人省心
    - 通过回调函数的方式实现异步

    ```js
    const express = require('express');
    const app = express();

    /* 中间件 */
    app.use((req, res, next) => {
        console.log('middleware');
        next();
        console.log('middleware call');
    });

    /* 路由部分 */
    const router = express.Router();
    router.get('/', (req, res) => {
        res.send('Home');
    });
    app.use(router);

    /* 静态文件 */
    app.use(express.static('./'));

    app.listen(3000);
    ```

- koa2.js：犹豫 ES6 语法糖 async/await 的出现，作为回应，TJ 推出了 Koa2.js
    - 基于Promise，丢弃回调函数
    - 没有捆绑任何中间件，更容易实现定制化，扩展性好
    - 增强错误处理，使用Try-Catch来捕获错误
    - 使用 await next() 进入下一个中间件

    ```js
    const Koa = require('koa');
    const Router = require('koa-router');
    const serve = require('koa-static');

    const app = new Koa();
    const router = Router();

    /* 中间件 */
    app.use(async (ctx, next) => {
        console.log('middleware');
        next();
        console.log('middleware call');
    });

    /* 路由部分 */
    router.get('/', (ctx) => {
        ctx.body = 'Home';
    });
    app.use(router.routes());

    /* 静态文件 */
    app.use(serve('./'));

    app.listen(3000);
    ```

- egg.js：基于Koa.js，将社区最佳实践整合进了Koa.js，另取名叫 egg.js
    - 开箱即用,将多进程启动，开发时的热更新 等问题一并解决了
    - 一个 约定大于配置 的框架
    - 缺点：
        - 单实例多进程模式，架构异常复杂，为了提升一点点性能，所增加的复杂度完全不可接受。如今serverless的时代，为了性能容器化部署，多实例才是主流。
        - 开发体验，egg调试体验不太好，打个断点也很困难，调试需要依赖console打印。
        - 插件机制，万物挂ctx，且不带类型提示（靠别人自觉写d.ts）。插件机制异常黑盒，只能靠配置文件。
        - Egg.js没有原生提供的TypeScript支持， 开发时需要用egg-ts-helper 来帮助自动生成 d.ts 文件
- Nest.js：基于 Express、Socket.io 封装的 nodejs 后端开发框架，支持 ts。

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

# 网络

## 浏览器地址到页面流程

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

## HTTP状态码

- 状态码
  - 101: 协议切换准备
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

## 跨域

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

## 浏览器垃圾回收机制

- 说一下浏览器垃圾回收机制
    - 标记清除：当变量进⼊执⾏环境时，就标记这个变量“进⼊环境”。当变量离开环境时，就会被标记为“离开环境”
    - 引⽤计数：跟踪记录每个值被引⽤的次数，变为0时，说明这个变量已经没有价值
- 哪些操作会造成内存泄露问题，怎么避免
    - 造成：
        - 意外的全局变量
        - 遗忘的计时器
        - 闭包
    - 避免：
        - 数组：将数组的⻓度设置为0，以此来达到清空数组的⽬的
        - object：对于不再使⽤的对象，就将其设置为 null

# 安全

## 常见 Web 漏洞

### SQL注入
>
> SQL注入是一种常见的安全漏洞，攻击者通过在表单提交、URL参数、Cookie等输入点插入恶意SQL命令，绕过验证机制和权限检查，从而获取或篡改数据。SQL注入可能导致数据库信息泄露、网页篡改、服务器被远程控制等严重后果‌

- 使用参数化查询接口，避免将用户输入直接拼接到SQL语句中
- 对输入数据进行过滤和转义处理，特别是对特殊字符进行转义或编码转换。

### 跨站脚本攻击 XSS
>
> XSS攻击发生在客户端，攻击者通过在网页中注入恶意脚本，窃取用户数据、进行钓鱼欺骗或传播恶意代码。

- 对输入数据进行适当的编码处理，确保输出的HTML和JavaScript代码不会执行恶意脚本。
- 使用内容安全策略（CSP）来限制资源加载和执行，防止跨域脚本执行。
- 对用户上传的内容进行严格的验证和过滤，避免执行未经验证的代码

### 跨站请求伪造 CSRF
>
> CSRF攻击允许攻击者在用户不知情的情况下，以用户的身份执行某些操作。例如，通过诱导用户点击一个链接，该链接会以用户的身份发送一个恶意请求到服务器‌

- 验证码
- Token

### 弱口令‌
>
> 弱口令漏洞使得攻击者可以通过简单的密码猜测或暴力破解方法登录系统，进而进行进一步攻击。弱口令问题常见于系统默认密码未修改、密码策略不完善等情况‌

- 设置强密码策略，要求密码包含数字、大小写字母和特殊字符
- 强制用户首次登录时修改默认密码，并定期要求用户更换密码
- 使用验证码，限制登录尝试次数‌

# 工程化

## Webpack

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

## 前端监控

### 监控工具

- Google Lighthouse
- WebPageTest
- 使用 React DevTools 工具来监控组件性能、检测性能瓶颈，并进行优化。
- 网络请求监控：监控网络请求的成功率、响应时间等指标，及时发现接口调用失败或延迟的问题。
- 全局错误处理：在前端代码中添加全局错误处理机制，捕获未被捕获的异常，避免影响用户体验。

### 关键性能指标

- **首次内容渲染（FCP）**：表示浏览器首次绘制页面的时间，即用户可以看到页面上有意义的内容的时间点。较低的FCP时间通常意味着更快的用户体验。
- **可交互时间（TTI）**：表示页面变得可交互的时间点，即用户可以与页面进行交互的时间。较短的TTI时间可以提升用户体验。
- **DOM完成时间**：表示浏览器完成解析DOM树的时间，即页面所有DOM元素都已解析完成的时间点。较快的DOM完成时间可以提升页面加载速度。
- **加载时间（Load Time）**：表示页面完全加载完成的时间，包括页面上所有资源（如图片、CSS、JavaScript）都已加载完成的时间点。较短的加载时间可以提升用户体验。
- **首屏加载时间**；表示页面上首屏内容加载完成的时间，即用户可以看到页面上首屏内容的时间点。较短的首屏加载时间可以提升用户体验。
- **资源加载时间**：表示页面上各种资源（如图片、CSS、JavaScript）加载完成的时间。优化资源加载时间可以提升整体页面加载速度。

# 项目业务

- 平时项目里做过哪些优化？
    - 万条数据渲染
        - 时间分片渲染：通过 定时器 setTimeout 来包裹每次的渲染，利用任务队列机制，将渲染拆解成多个宏任务。
        - 帧绘制：使用 requestAnimationFrame （RAF） + createDocumentFragment（文档碎片）：它会在每一帧绘制前被调用，从而保证平滑的渲染。能够避免定时器的不稳定问题。
        - 虚拟列表：通过 **动态计算 可视区域数据**，仅渲染用户可见部分的内容，配合 **缓冲区机制** 模拟完整列表的滚动效果
- 平时怎么去约束代码，增加代码可读性？
    - 命名
    - 代码风格
    - 注释
    - 抽取 重复代码 成 函数
