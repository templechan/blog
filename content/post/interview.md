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

# HTML

# CSS

# JS

# HTTP

## 浏览器地址到页面流程

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

## 状态码

- 请求成功：
  - 200：成功
- 重定向：
  - 301：永久重定向，响应头中会包含一个 Location 字段，指向新的URL。
  - 302：临时重定向，搜索引擎不会将权重和收录情况转移到新的URL上，而是保留原本的URL。‌
  - 304：表示可以在缓存中取数据 (协商缓存)
- 客户端错误：
  - 401：未授权
  - 403：拒绝请求
  - 404：请求资源不存在
- 服务端错误：
  - 500：服务器内部错误
  - 502：网关错误
  - 504：网关超时

# 跨域
>
> Ajax 只能同源使用的限制，如果缺少了同源策略，浏览器很容易受到 XSS、CSFR 等攻击。
> 所谓同源是指 " 协议 + 域名 + 端口" 三者相同

解决办法：

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

# 文件上传

- **文件分片**：原理就是 **Blob 对象 的 slice 方法**，File 对象 就 继承与 Blob 对象
- **区分文件**：根据 **spark-md5** 提供一个计算 hash值 的函数，并在获取文件切片之后，调用这个函数。秒传的原理就是 比较两个文件的 hash值。
- **上传切片**：定义一个 上传分片 的函数，并在获取 hash值 之后调用，把分片数组作为参数传过去。

# 性能优化

## React 代码层面

- 缓存组件：React.memo，通过浅比较 props 发生变化时才会重新渲染
- 缓存大量的计算：useMemo
- 缓存函数：useCallback
- 延迟加载不是立即需要的组件：React.lazy 和 React.Suspense 完成延迟加载

## 静态资源

- 压缩
- 按需导入

## 网络

- 减少 http 请求数量：防抖、节流
- 懒加载，预加载
- 虚拟列表

## 后台处理
>
> 避免阻塞主线程，来提高页面的响应性。
>
### Web Workers

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

# React

# Webpack

# Nodejs

# 组件封装

# 组件化跨项目复用方案

- git仓库方式共享

# 项目难点
