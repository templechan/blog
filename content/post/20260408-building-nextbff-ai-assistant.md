---
layout: post
title: 构建 Next BFF 级 AI 助手 - T.AI
subtitle:
description: 涉及 AI流式对话，多模型统一适配，RAG私有文档问答 等。
author: 谌中钱
date: 2026-04-08
lastMod:
image: img/post-bg-default.png
categories:
  - programming
tags:
  - 解决方案
  - AI
slug: building-nextbff-ai-assistant
weight: 1
showtoc: true
draft: false
---

<br />

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6} -->

<!-- code_chunk_output -->

- [1 项目预览](#1-项目预览)
- [2 技术选型](#2-技术选型)
- [2 项目开发](#2-项目开发)
  - [2.1 项目初始化](#21-项目初始化)
    - [2.1.1 配置优化](#211-配置优化)
      - [2.1.1.1 项目依赖与脚本配置](#2111-项目依赖与脚本配置)
      - [2.1.1.2 Next 核心配置](#2112-next-核心配置)
      - [2.1.1.3 TypeScript 编译配置](#2113-typescript-编译配置)
      - [2.1.1.4 ESLint 代码规范配置](#2114-eslint-代码规范配置)
        - [2.1.1.4.1 集成代码格式化插件 prettier](#21141-集成代码格式化插件-prettier)
        - [2.1.1.4.2 Git 提交格式化配置](#21142-git-提交格式化配置)
      - [2.1.1.5 pnpm 工作区配置](#2115-pnpm-工作区配置)
      - [2.1.1.6 解除 pnpm 警告](#2116-解除-pnpm-警告)
  - [2.2 UI 开发](#22-ui-开发)
    - [2.2.1 安装依赖](#221-安装依赖)
    - [2.2.2 全局样式](#222-全局样式)
    - [2.2.3 布局相关](#223-布局相关)
      - [2.2.3.1 根布局组件](#2231-根布局组件)
      - [2.2.3.2 基础布局组件](#2232-基础布局组件)
    - [2.2.4 基础相关](#224-基础相关)
      - [2.2.4.1 通用弹窗组件](#2241-通用弹窗组件)
      - [2.2.4.2 文档预览组件](#2242-文档预览组件)
    - [2.2.5 侧边栏相关](#225-侧边栏相关)
      - [2.2.5.1 侧边栏组件](#2251-侧边栏组件)
      - [2.2.5.2 侧边栏组件 (移动端)](#2252-侧边栏组件-移动端)
      - [2.2.5.3 会话列表组件](#2253-会话列表组件)
        - [2.2.5.3.1 会话列表 Hook 组件](#22531-会话列表-hook-组件)
    - [2.2.6 会话相关](#226-会话相关)
      - [2.2.6.1 会话标题组件](#2261-会话标题组件)
      - [2.2.6.2 会话内容组件](#2262-会话内容组件)
      - [2.2.6.3 会话聊天框相关](#2263-会话聊天框相关)
        - [2.2.6.3.1 会话聊天框组件](#22631-会话聊天框组件)
        - [2.2.6.3.2 输入框组件](#22632-输入框组件)
        - [2.2.6.3.3 文件上传按钮组件](#22633-文件上传按钮组件)
        - [2.2.6.3.4 文件上传按钮 Hook 组件](#22634-文件上传按钮-hook-组件)
        - [2.2.6.3.5 文件列表展示组件](#22635-文件列表展示组件)
        - [2.2.6.3.6 模型选择组件](#22636-模型选择组件)
        - [2.2.6.3.7 发送按钮组件](#22637-发送按钮组件)
      - [2.2.6.4 前端文档解析工具封装](#2264-前端文档解析工具封装)
    - [2.2.7 页面相关](#227-页面相关)
      - [2.2.7.1 首页页面组件](#2271-首页页面组件)
      - [2.2.7.2 会话页面组件](#2272-会话页面组件)
        - [2.2.7.2.1 会话页面 Hook 组件](#22721-会话页面-hook-组件)
    - [2.2.8 通用工具](#228-通用工具)
  - [2.3 数据管理](#23-数据管理)
    - [2.3.1 安装依赖](#231-安装依赖)
    - [2.3.2 客户端全局应用常量](#232-客户端全局应用常量)
    - [2.3.3 客户端全局 TS 类型](#233-客户端全局-ts-类型)
    - [2.3.4 状态封装](#234-状态封装)
      - [2.3.4.1 通用状态](#2341-通用状态)
      - [2.3.4.2 模型状态](#2342-模型状态)
      - [2.3.4.3 会话状态](#2343-会话状态)
      - [2.3.4.4 会话请求状态](#2344-会话请求状态)
    - [2.3.5 客户端请求工具封装](#235-客户端请求工具封装)
    - [2.3.6 客户端服务层封装](#236-客户端服务层封装)
      - [2.3.6.1 模型列表服务层](#2361-模型列表服务层)
      - [2.3.6.2 会话列表服务层](#2362-会话列表服务层)
      - [2.3.6.3 会话请求服务层](#2363-会话请求服务层)
    - [2.3.7 SWR Hook 组件](#237-swr-hook-组件)
  - [2.4 BFF 开发](#24-bff-开发)
    - [2.4.1 BFF 全局应用常量](#241-bff-全局应用常量)
    - [2.4.2 BFF 全局 TS 类型](#242-bff-全局-ts-类型)
    - [2.4.3 数据库初始化](#243-数据库初始化)
      - [2.4.3.1 安装依赖](#2431-安装依赖)
        - [2.4.3.1.1 PostgreSQL 数据库安装](#24311-postgresql-数据库安装)
        - [2.4.3.1.2 数据库代码连接依赖安装](#24312-数据库代码连接依赖安装)
      - [2.4.3.2 模型配置文件](#2432-模型配置文件)
      - [2.4.3.3 数据库初始化脚本](#2433-数据库初始化脚本)
    - [2.4.4 BFF 请求工具封装](#244-bff-请求工具封装)
    - [2.4.5 BFF 接口异常处理工具封装](#245-bff-接口异常处理工具封装)
    - [2.4.6 API 开发](#246-api-开发)
      - [2.4.6.1 BFF 模型列表接口](#2461-bff-模型列表接口)
      - [2.4.6.2 BFF 会话列表接口](#2462-bff-会话列表接口)
      - [2.4.6.3 BFF 会话聊天接口](#2463-bff-会话聊天接口)
    - [2.4.7 BFF 服务层封装](#247-bff-服务层封装)
      - [2.4.7.1 BFF 模型列表服务层](#2471-bff-模型列表服务层)
      - [2.4.7.2 BFF 会话列表服务层](#2472-bff-会话列表服务层)
      - [2.4.7.3 BFF 会话请求服务层](#2473-bff-会话请求服务层)
        - [2.4.7.3.1 RAG 工具封装](#24731-rag-工具封装)
        - [2.4.7.3.2 大模型流式响应解析器工厂](#24732-大模型流式响应解析器工厂)
    - [2.4.8 BFF 通用工具](#248-bff-通用工具)
  - [2.5 自动化部署](#25-自动化部署)
    - [2.5.1 CI/CD 脚本](#251-cicd-脚本)
    - [2.5.2 部署脚本](#252-部署脚本)
    - [2.5.3 Docker 文件](#253-docker-文件)

<!-- /code_chunk_output -->

## 1 项目预览

- AI 助手在线地址：<a href="https://tai.templechann.com" target="_blank">`https://tai.templechann.com`</a>
- Github 仓库地址：<a href="https://github.com/templechan/tai" target="_blank">`https://github.com/templechan/tai`</a>

## 2 技术选型

> 本项目采用的技术点版本，除了兼容性考虑外，都采用最新版，使用 pnpm-lock.yaml 保证协同一致性。

<style>
/* 外层容器：移动端 100% 触发横向滚动 */
.table-wrapper {
  width: 100% !important;
  max-width: 100% !important;
  overflow-x: auto !important;
  overflow-y: hidden !important;
  margin: 12px 0 !important;
  -webkit-overflow-scrolling: touch !important;
  display: block !important;
}

/* 表格本体：紧凑样式 + 强制最小宽度触发滚动 */
.markdown-table {
  width: 100% !important;
  min-width: 700px !important;
  border-collapse: collapse !important;
  border-spacing: 0 !important;
  font-size: 14px !important;
  line-height: 1.4 !important; /* 恢复紧凑行高 */
  border-radius: 6px !important;
}

.markdown-table th,
.markdown-table td {
  padding: 8px 12px !important; /* 恢复紧凑内边距 */
  border: 1px solid #e8ebee !important;
  text-align: left !important;
  word-break: break-word !important;
  white-space: normal !important;
  background: transparent !important;
  color: #333 !important;
}

/* 第一列：最小5个汉字，固定宽度 */
.markdown-table td:first-child,
.markdown-table th:first-child {
  min-width: 80px !important;
  width: 80px !important;
  white-space: nowrap !important;
}

.markdown-table th {
  background: #f7f8fa !important;
  font-weight: 600 !important;
}
.markdown-table tr:nth-child(even) {
  background: #fcfdff !important;
}
.markdown-table tr:hover {
  background: #f2f5f9 !important;
}
</style>

<div class="table-wrapper">
<table class="markdown-table">
  <thead>
    <tr>
      <th></th>
      <th>技术点</th>
      <th>版本</th>
      <th>生产优势</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>基础环境</td>
      <td>Git、Node.js、NVM、PNPM</td>
      <td>git 2.53.0.2<br />node.js 24.14.1<br />nvm 1.2.2.0<br />pnpm 10.33.0</td>
      <td>🔹Git：版本控制，多人协作<br />🔹NVM：Node.js 多版本管理器<br />🔹Node.js：JS 运行环境，前端全栈基础设施<br />🔹PNPM：高性能的 NPM（Node.js 的包管理器）</td>
    </tr>
    <tr>
      <td>UI设计</td>
      <td>参考 DeepSeek、字节豆包、阿里千问 的 Web 端、移动端</td>
      <td>最新</td>
      <td>🔹市场已验证，符合用户习惯</td>
    </tr>
    <tr>
      <td>前端框架</td>
      <td>React、Next.js、create-next-app</td>
      <td>react 19.2.4<br />next 16.2.3<br />create-next-app 16.2.3</td>
      <td>🔹React：前端主流框架，生态强大，大厂标准<br />🔹Next.js：React 的全栈增强框架，解决 SEO、首屏慢、路由麻烦、接口分离等痛点<br />🔹create-next-app：Next.js 的脚手架，一键搭建标准化的项目结构</td>
    </tr>
    <tr>
      <td>UI</td>
      <td>Tailwind CSS、shadcn/ui、lucide-react、sonner</td>
      <td>tailwindcss ^4<br />shadcn ^4.2.0<br />lucide-react ^1.8.0<br />sonner ^2.0.7</td>
      <td>🔹Tailwind CSS：CSS 原子化样式工具类框架，快速写页面样式，简化响应式布局<br />🔹shadcn/ui：基于 Tailwind CSS 的高质量可定制组件库<br />🔹lucide-react：React 专用的图标库，轻量<br />🔹sonner：轻量提示组件，官方推荐</td>
    </tr>
    <tr>
      <td>数据管理</td>
      <td>Zustand、SWR、fetch</td>
      <td>zustand ^5.0.12<br />swr ^2.4.1</td>
      <td>🔹Zustand：前端全局状态存取，轻量<br />🔹SWR：后端数据调度，负责统一管理服务层接口，实现数据自动缓存、刷新、重试等，轻量</td>
    </tr>
    <tr>
      <td>文档解析</td>
      <td>FileReader、mammoth、pdfjs-dist</td>
      <td>mammoth ^1.12.0<br />pdfjs-dist ^5.6.205</td>
      <td>🔹mammoth：纯前端解析 .docx 文档的库<br />🔹pdfjs-dist：纯前端解析 .pdf 文件的库</td>
    </tr>
    <tr>
      <td>RAG技术</td>
      <td>@langchain/core、@langchain/textsplitters、@xenova/transformers、pg</td>
      <td>@langchain/core ^1.1.39<br />@langchain/textsplitters ^1.0.1<br />@xenova/transformers ^2.17.2<br />pg^8.20.0</td>
      <td>🔹@langchain/core：RAG 流程调度核心，负责把 文档读取 → 分块 → 向量化 → 检索 → 提示词 → 大模型回答，串成一条完整流水线。<br />🔹@langchain/textsplitters：文档分块，切割后送入 embedding 模型<br />🔹@xenova/transformers：纯 JS 本地跑 AI 模型，负责向量生成、向量检索、问题分类等<br /><br />当前项目使用的模型有：<br />🔹Xenova/all-MiniLM-L6-v2：嵌入模型，负责向量生成、检索，轻量超快<br />🔹Xenova/distilbert-base-uncased-mnli：分类模型，负责用户意图识别，超轻量蒸馏模型</td>
    </tr>
    <tr>
      <td>后端框架</td>
      <td>Next API Routes</td>
      <td>Next.js 内置的后端接口能力</td>
      <td>🔹Next API Routes：提供接口能力，信息安全隔离，支持边缘化</td>
    </tr>
    <tr>
      <td>数据库</td>
      <td>PostgreSQL、pgvector</td>
      <td>PostgreSQL 18<br />pgvector：是 PostgreSQL 的向量插件</td>
      <td>🔹PostgreSQL：世界上最稳定、最强大的开源数据库 🐶，高一致性，适合复杂分析等<br />🔹pgvector：负责把 Xenova 模型生成的向量存进数据库，使用用户问题生产的向量去检索数据库中相似的文档片段</td>
    </tr>
    <tr>
      <td>第三方工具</td>
      <td>dayjs、uuid</td>
      <td>dayjs ^1.11.20<br />uuid ^13.0.0</td>
      <td>🔹dayjs：轻量级时间日期处理库<br />🔹uuid：唯一 ID 生成库</td>
    </tr>
    <tr>
      <td>工程化</td>
      <td>TypeScript、ESLint、Prettier、Husky、lint-staged、Turbopack</td>
      <td>typescript ^5<br />eslint ^9<br />prettier ^3.8.1<br />husky ^9.1.7<br />lint-staged ^16.4.0<br />Turbopack：Next.js 16.2.3 已全面默认的打包工具</td>
      <td>🔹TypeScript：给 JS 加类型，防止 BUG，更安全<br />🔹ESLint：检查代码语法错误、不规范写法<br />🔹Prettier：自动格式化代码，统一风格<br />🔹Husky：Git 提交钩子，拦截不合格代码<br />🔹lint-staged：只检查本次修改的文件，速度飞快<br />🔹Turbopack：由 Vercel 官方开发的下一代 JavaScript 打包工具，比 webpack 快 10～100 倍，比 Vite 快 5～20 倍，兼容 webpack</td>
    </tr>
    <tr>
      <td>自动化部署</td>
      <td>Docker、Nginx、GitHub Actions</td>
      <td>Docker 29.1.3<br />Nginx 1.24.0</td>
      <td>🔹Docker：容器化，环境统一，跨平台<br />🔹Nginx：高性能 Web 服务器，提供反向代理，解决跨域，SSL证书配置等功能<br />🔹GitHub Actions：CI/CD 自动化部署</td>
    </tr>
    <tr>
      <td>边缘部署</td>
      <td>Vercel、Vercel Postgres</td>
      <td></td>
      <td></td>
    </tr>
  </tbody>
</table>
</div>
 
## 2 项目开发

### 2.1 项目初始化

```shell
# 进入项目的父目录
cd /d D:\dev\workspace

# 创建并初始化项目
pnpm create next-app@latest nextbff-ai-assistant --ts --eslint --react-compiler --tailwind --src-dir --app --import-alias "@/*" --no-agents-md

# .../19d71cb1a2a-1af40                    |   +1 +
# .../19d71cb1a2a-1af40                    | Progress: resolved 1, reused 0, downloaded 1, added 1, done
# Creating a new Next.js app in D:\dev\workspace\nextbff-ai-assistant.

# Using pnpm.

# Initializing project with template: app-tw


# Installing dependencies:
# - next
# - react
# - react-dom

# Installing devDependencies:
# - @tailwindcss/postcss
# - @types/node
# - @types/react
# - @types/react-dom
# - babel-plugin-react-compiler
# - eslint
# - eslint-config-next
# - tailwindcss
# - typescript

#  WARN  Request took 11474ms: https://registry.npmjs.org/next
# Downloading next@16.2.3: 33.99 MB/33.99 MB, done
# Packages: +350
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Downloading @next/swc-win32-x64-msvc@16.2.3: 43.69 MB/43.69 MB, done
# Progress: resolved 424, reused 348, downloaded 7, added 350, done

# dependencies:
# + next 16.2.3
# + react 19.2.4
# + react-dom 19.2.4

# devDependencies:
# + @tailwindcss/postcss 4.2.2
# + @types/node 20.19.39 (25.5.2 is available)
# + @types/react 19.2.14
# + @types/react-dom 19.2.3
# + babel-plugin-react-compiler 1.0.0
# + eslint 9.39.4 (10.2.0 is available)
# + eslint-config-next 16.2.3
# + tailwindcss 4.2.2
# + typescript 5.9.3 (6.0.2 is available)

# Done in 2m 24.7s using pnpm v10.33.0

# Generating route types...
# ✓ Types generated successfully

# Initialized a git repository.

# Success! Created nextbff-ai-assistant at D:\dev\workspace\nextbff-ai-assistant


# 进入项目目录
cd .\nextbff-ai-assistant
```

#### 2.1.1 配置优化

##### 2.1.1.1 项目依赖与脚本配置

`/package.json`：添加生产环境脚本、清理缓存脚本、TS 类型检查脚本、代码格式检查脚本 等

```shell
# 清理缓存脚本依赖 rimraf
# rimraf 是一个跨平台的 Node.js 工具,可以在 Windows、macOS 和 Linux 上正常工作,完美替代 Unix 的 rm -rf 命令
pnpm add -D rimraf
```

```json
{
  // ... existing code ...
  // 生产环境脚本
  "prod": "pnpm build && pnpm start",
  // 清理缓存脚本
  "clean": "pnpm store prune --force && rimraf pnpm-lock.yaml node_modules .next",

  // TS 类型 检查脚本
  "type:check": "tsc --noEmit",
  // 代码规范 检查脚本
  "lint:check": "eslint",
  // 代码格式 检查脚本
  "format:check": "prettier --check \"**/*.{ts,tsx,js,jsx,json,css,scss}\"",

  // 自动修复 ESLint 问题（包括 Prettier）
  "lint:fix": "eslint . --fix",
  // 代码格式化脚本
  "format:fix": "prettier --write \"**/*.{ts,tsx,js,jsx,json,css,scss}\"",

  // 三合一检查脚本
  "check-all": "pnpm type:check && pnpm lint:check && pnpm format:check",
  // 二合一修复脚本
  "fix-all": "pnpm lint:fix && pnpm format:fix"
}
```

##### 2.1.1.2 Next 核心配置

`/next.config.ts`：添加安全配置等

```ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
    // 启用生产轻量化构建，支持 API Route
    output: "standalone",

    // 关闭 React 严格模式（临时解决开发模式下 useEffect 执行两次）
    reactStrictMode: false,

    // 开启 React 官方自动优化编译器
    // 自动帮你做 useMemo/useCallback 优化，提升页面渲染流畅度，无需手写优化 Hooks
    reactCompiler: true,

    // 开启输出压缩（Next 高版本默认已开启，显式声明更稳妥）
    // 启用 Gzip/Brotli 压缩，减小静态资源（JS/CSS/HTML）体积，加快页面加载速度
    compress: true,

    // 禁用 x-powered-by 头（安全最佳实践）
    // 隐藏响应头里的 X-Powered-By: Next.js，不让攻击者知道你的技术栈，提升网站安全性
    poweredByHeader: false,

    // 允许整个局域网访问开发服务，方便调试移动端，不然移动访问时事件等无法水合过去
    allowedDevOrigins: ["192.168.1.*"],

    // 配置网站安全头部
    async headers() {
        return [
            {
                source: "/:path*",
                headers: [
                    // 开启 DNS 预解析，加快页面加载
                    { key: "X-DNS-Prefetch-Control", value: "on" },
                    // 强制浏览器用 HTTPS 访问，防止网络劫持
                    { key: "Strict-Transport-Security", value: "max-age=63072000; includeSubDomains; preload" },
                ],
            },
        ];
    },
};

export default nextConfig;
```

##### 2.1.1.3 TypeScript 编译配置

`/tsconfig.json`：添加更严格的类型检查选项（已注释，按需配置）

```json
{
    "compilerOptions": {
        "target": "ES2017", // 目标 ECMAScript 版本
        "lib": ["dom", "dom.iterable", "esnext"], // 包含浏览器环境类型
        "allowJs": true, // 允许导入 JS 文件
        "skipLibCheck": true, // 跳过声明文件检查（加速编译）
        "strict": true, // 启用严格模式
        "noEmit": true, // 不输出 JS 文件（Next.js 处理）
        "esModuleInterop": true, // 兼容 CommonJS/ESM
        "module": "esnext", // 使用最新模块系统
        "moduleResolution": "bundler", // 现代打包工具解析策略
        "resolveJsonModule": true, // 允许导入 JSON
        "isolatedModules": true, // 每个文件独立编译
        "jsx": "react-jsx", // 使用新的 JSX 转换
        "incremental": true, // 增量编译（加速）
        // "noUnusedLocals": true,  // 报告未使用的局部变量
        // "noUnusedParameters": true,  // 报告未使用的参数
        // "exactOptionalPropertyTypes": true,  // 严格可选属性类型
        // "noImplicitReturns": true,  // 确保所有代码路径都有返回值
        // "noFallthroughCasesInSwitch": true,  // 禁止 switch case 穿透
        // "forceConsistentCasingInFileNames": true,  // 强制文件名大小写一致
        "plugins": [
            {
                "name": "next"
            }
        ],
        "paths": {
            "@/*": ["./src/*"]
        }
    },
    "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts", ".next/dev/types/**/*.ts", "**/*.mts"],
    "exclude": ["node_modules"]
}
```

##### 2.1.1.4 ESLint 代码规范配置

`/eslint.config.mjs`：添加更多自定义规则（已注释，按需配置）

```js
import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";
import nextTs from "eslint-config-next/typescript";
import prettier from "eslint-plugin-prettier/recommended"; // 添加这行

const eslintConfig = defineConfig([
    ...nextVitals,
    ...nextTs,
    prettier, // 集成代码格式化插件 prettier，需要添加这行，必须在最后
    {
        rules: {
            "prettier/prettier": "error", // 将 Prettier 问题视为错误（可选）
            "max-lines": [
                "error",
                {
                    // 单个文件最大行数（默认 300 行，超了报错）
                    max: 300, // 文件最大行数
                    skipBlankLines: true, // 忽略空行
                    skipComments: true, // 忽略注释
                },
            ],
            // 允许使用 any 类型（极少数时候会用到，关闭报错）
            "@typescript-eslint/no-explicit-any": "off",
            // 关闭 原生JS 未使用表达式警告（比如用了 map 但不接收返回值，纯粹遍历）
            "no-unused-expressions": "off",
            // 关闭 TypeScript 未使用表达式警告
            "@typescript-eslint/no-unused-expressions": "off",
            // 全局关闭 React Hook 依赖项警告（永远不提示）
            "react-hooks/exhaustive-deps": "off",
            // // 禁止 console.log（生产环境）
            // 'no-console': ['warn', { allow: ['warn', 'error'] }],

            // // 强制使用箭头函数
            // 'prefer-arrow-callback': 'error',

            // // 强制 const 而非 let
            // 'prefer-const': 'error',

            // // 禁止未使用的变量
            // '@typescript-eslint/no-unused-vars': ['error', {
            //   argsIgnorePattern: '^_',
            //   varsIgnorePattern: '^_'
            // }],
        },
    },
    // Override default ignores of eslint-config-next.
    globalIgnores([
        // Default ignores of eslint-config-next:
        ".next/**",
        "out/**",
        "build/**",
        "next-env.d.ts",
        "node_modules/**",
        "public/**",
        "tmp/**",
    ]),
]);

export default eslintConfig;
```

###### 2.1.1.4.1 集成代码格式化插件 prettier

> 下面是代码内集成方式，保证项目所有人统一格式。

> 如果只是自己使用的话，可以安装 VS Code 的插件 Prettier - Code formatter：
> - 可以设置保存自动格式化，然后设置默认格式化工具为 prettier
> - 最后去插件配置里设置相关配置路径 `.prettierrc` 和 `.prettierignore` 即可
  
```shell
pnpm install -D prettier eslint-config-prettier eslint-plugin-prettier prettier-plugin-tailwindcss prettier-plugin-import-sort import-sort-style-module

# prettier：核心格式化工具
# eslint-config-prettier：会自动禁用所有与 Prettier 冲突的 ESLint 规则
# eslint-plugin-prettier：会将 Prettier 格式问题作为 ESLint 错误报告
# prettier-plugin-tailwindcss：会自动排序 Tailwind CSS 类名，非常有用！！


# 关于导入的排序，由于 相关排序插件 和 Tailwind CSS 类名排序插件不兼容，目前暂时使用手动排序：

"use client";

// ==================== 根布局组件 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //
```

创建 Prettier 配置文件：`/.prettierrc`
 
```json
{
  "semi": true, // 强制使用分号
  "trailingComma": "all", // 强制使用尾随逗号
  "singleQuote": false, // 禁用单引号
  "printWidth": 9999, // 自动换行长度
  "tabWidth": 4, // 缩进 4 个空格
  "useTabs": false, // 禁用制表符
  "bracketSpacing": true, // 对象括号前后加空格
  "arrowParens": "always", // 箭头函数参数使用括号
  "endOfLine": "lf", // 换行符类型，使用 lf
  // 其他可选值：
  // "crlf" - Windows 风格 (\r\n)
  // "cr"   - 旧 Mac 风格 (\r)
  // "auto" - 根据文件内容自动检测
  // 建议："lf" - 跨平台兼容性最好（Git 可以处理转换）
  "plugins": ["prettier-plugin-tailwindcss"]
}
```

创建 .prettierignore 文件：`/.prettierignore`

```
# Dependencies
node_modules

# Build outputs
.next
out
build
dist

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Environment files
.env*

# IDE
.vscode
.idea
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Generated files
next-env.d.ts
*.tsbuildinfo

# Lock files (保持原样)
pnpm-lock.yaml
package-lock.json
yarn.lock

# Public assets (通常不需要格式化)
public/*.svg
public/*.png
public/*.jpg

# 禁止格式化 Markdown 文件
*.md

# 禁止格式化 shadcn/ui 原子组件
src/components/ui

tmp
```

###### 2.1.1.4.2 Git 提交格式化配置

使用 Husky + lint-staged 在提交前自动格式化：

```shell
pnpm add -D husky lint-staged
pnpm exec husky init
```

会自动创建 `/.husky/pre-commit` 文件，修改为：

```shell
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
```

在 `/package.json` 中添加 lint-staged 配置：

```json
{
  "lint-staged": {
    "*.{ts,tsx,js,jsx}": [
      "eslint --fix",
      "prettier --write"
    ],
    "*.{json,css,scss}": [
      "prettier --write"
    ]
  } 
}
```


##### 2.1.1.5 pnpm 工作区配置

`/pnpm-workspace.yaml`： 当前项目并非 monorepo 单体仓库，不需要 workspace 配置。ignoredBuiltDependencies 用于跳过某些包的安装后构建步骤，但是项目需要这些包，应删除此文件。

```yaml
ignoredBuiltDependencies:
  - sharp
  - unrs-resolver
```

##### 2.1.1.6 解除 pnpm 警告

> 项目开发过程中，如果遇到一些包安装的错误，可以运行 `pnpm approve-builds` 检查试试。

```shell
# 项目开发前，先清空下缓存，安装依赖
pnpm clean && pnpm install
# 会提示：
# ╭ Warning ───────────────────────────────────────────────────────────────────────────────────╮
# │                                                                                            │
# │   Ignored build scripts: sharp@0.34.5, unrs-resolver@1.11.1.                               │
# │   Run "pnpm approve-builds" to pick which dependencies should be allowed to run scripts.   │
# │                                                                                            │
# ╰────────────────────────────────────────────────────────────────────────────────────────────╯
# 原因：pnpm 自身的安全控制，导致 sharp、unrs-resolver 等包无法安装，但是项目需要这些包
# 解除警告，进行安装
pnpm approve-builds
# 按 a键 全选，然后回车，按 y 键，安装完毕即可
```





### 2.2 UI 开发

> 组件开发原则：每个组件尽量控制在 300行 以内（通过ESLint可检查），职责要分离清晰，便于维护
> - 页面组件：尽量只用来 调用各子组件 和 布局。
> - 业务组件：
>   - JSX 里面除了只有1行代码的的函数，都要抽出来。
>   - 业务逻辑较多，或可复用的，都应该把业务抽成对应的 Hook。

#### 2.2.1 安装依赖

```shell
# 安装组件库 shadcn/ui（自带图标库 lucide-react）
pnpm dlx shadcn@latest init --base radix --preset nova
# 安装轻量级全局提示容器 sonner（shadcn/ui 官方推荐）
pnpm install sonner
# 安装文档解析依赖
pnpm install mammoth pdfjs-dist
# 安装需要的工具
pnpm install uuid dayjs

# 按需添加组件
pnpm dlx shadcn@latest add button-group button dialog drawer dropdown-menu input select separator textarea tooltip
```

#### 2.2.2 全局样式

`/src/app/globals.css`：

```css
/* ==================== 全局样式 ==================== */

@import "tailwindcss";
@import "tw-animate-css";
@import "shadcn/tailwind.css";

@custom-variant dark (&:is(.dark *));

@theme inline {
    --color-background: var(--background);
    --color-foreground: var(--foreground);
    --font-sans: var(--font-sans);
    --font-mono: var(--font-geist-mono);
    --font-heading: var(--font-sans);
    --color-sidebar-ring: var(--sidebar-ring);
    --color-sidebar-border: var(--sidebar-border);
    --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);
    --color-sidebar-accent: var(--sidebar-accent);
    --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);
    --color-sidebar-primary: var(--sidebar-primary);
    --color-sidebar-foreground: var(--sidebar-foreground);
    --color-sidebar: var(--sidebar);
    --color-chart-5: var(--chart-5);
    --color-chart-4: var(--chart-4);
    --color-chart-3: var(--chart-3);
    --color-chart-2: var(--chart-2);
    --color-chart-1: var(--chart-1);
    --color-ring: var(--ring);
    --color-input: var(--input);
    --color-border: var(--border);
    --color-destructive: var(--destructive);
    --color-accent-foreground: var(--accent-foreground);
    --color-accent: var(--accent);
    --color-muted-foreground: var(--muted-foreground);
    --color-muted: var(--muted);
    --color-secondary-foreground: var(--secondary-foreground);
    --color-secondary: var(--secondary);
    --color-primary-foreground: var(--primary-foreground);
    --color-primary: var(--primary);
    --color-popover-foreground: var(--popover-foreground);
    --color-popover: var(--popover);
    --color-card-foreground: var(--card-foreground);
    --color-card: var(--card);
    --radius-sm: calc(var(--radius) * 0.6);
    --radius-md: calc(var(--radius) * 0.8);
    --radius-lg: var(--radius);
    --radius-xl: calc(var(--radius) * 1.4);
    --radius-2xl: calc(var(--radius) * 1.8);
    --radius-3xl: calc(var(--radius) * 2.2);
    --radius-4xl: calc(var(--radius) * 2.6);
}

:root {
    --background: oklch(1 0 0);
    --foreground: oklch(0.145 0 0);
    --card: oklch(1 0 0);
    --card-foreground: oklch(0.145 0 0);
    --popover: oklch(1 0 0);
    --popover-foreground: oklch(0.145 0 0);
    --primary: oklch(0.205 0 0);
    --primary-foreground: oklch(0.985 0 0);
    --secondary: oklch(0.97 0 0);
    --secondary-foreground: oklch(0.205 0 0);
    --muted: oklch(0.97 0 0);
    --muted-foreground: oklch(0.556 0 0);
    --accent: oklch(0.97 0 0);
    --accent-foreground: oklch(0.205 0 0);
    --destructive: oklch(0.577 0.245 27.325);
    --border: oklch(0.922 0 0);
    --input: oklch(0.922 0 0);
    --ring: oklch(0.708 0 0);
    --chart-1: oklch(0.87 0 0);
    --chart-2: oklch(0.556 0 0);
    --chart-3: oklch(0.439 0 0);
    --chart-4: oklch(0.371 0 0);
    --chart-5: oklch(0.269 0 0);
    --radius: 0.625rem;
    --sidebar: oklch(0.985 0 0);
    --sidebar-foreground: oklch(0.145 0 0);
    --sidebar-primary: oklch(0.205 0 0);
    --sidebar-primary-foreground: oklch(0.985 0 0);
    --sidebar-accent: oklch(0.97 0 0);
    --sidebar-accent-foreground: oklch(0.205 0 0);
    --sidebar-border: oklch(0.922 0 0);
    --sidebar-ring: oklch(0.708 0 0);
}

.dark {
    --background: oklch(0.145 0 0);
    --foreground: oklch(0.985 0 0);
    --card: oklch(0.205 0 0);
    --card-foreground: oklch(0.985 0 0);
    --popover: oklch(0.205 0 0);
    --popover-foreground: oklch(0.985 0 0);
    --primary: oklch(0.922 0 0);
    --primary-foreground: oklch(0.205 0 0);
    --secondary: oklch(0.269 0 0);
    --secondary-foreground: oklch(0.985 0 0);
    --muted: oklch(0.269 0 0);
    --muted-foreground: oklch(0.708 0 0);
    --accent: oklch(0.269 0 0);
    --accent-foreground: oklch(0.985 0 0);
    --destructive: oklch(0.704 0.191 22.216);
    --border: oklch(1 0 0 / 10%);
    --input: oklch(1 0 0 / 15%);
    --ring: oklch(0.556 0 0);
    --chart-1: oklch(0.87 0 0);
    --chart-2: oklch(0.556 0 0);
    --chart-3: oklch(0.439 0 0);
    --chart-4: oklch(0.371 0 0);
    --chart-5: oklch(0.269 0 0);
    --sidebar: oklch(0.205 0 0);
    --sidebar-foreground: oklch(0.985 0 0);
    --sidebar-primary: oklch(0.488 0.243 264.376);
    --sidebar-primary-foreground: oklch(0.985 0 0);
    --sidebar-accent: oklch(0.269 0 0);
    --sidebar-accent-foreground: oklch(0.985 0 0);
    --sidebar-border: oklch(1 0 0 / 10%);
    --sidebar-ring: oklch(0.556 0 0);
}

@layer base {
    * {
        @apply border-border outline-ring/50;
    }

    body {
        @apply bg-background text-foreground;
    }

    html {
        @apply font-sans;
    }
}

/* ==================== 全局美化滚动条 ==================== */
/* 滚动条宽度 */
::-webkit-scrollbar {
    /* 垂直滚动条宽度 */
    width: 4px;
    /* 水平滚动条高度 */
    height: 4px;
}

/* 滚动条滑块 */
::-webkit-scrollbar-thumb {
    background: #94a3b880;
    border-radius: 999px;
    /* hover 平滑过渡 */
    transition: all 0.2s ease;
}

/* 滚动条轨道 */
::-webkit-scrollbar-track {
    background: #f8fafc80;
    border-radius: 999px;
}

/* 滚动条滑块 hover */
::-webkit-scrollbar-thumb:hover {
    /* 主题色 */
    background: #052658;
}

/* 兼容 Firefox */
* {
    scrollbar-width: thin;
    scrollbar-color: #94a3b880 #f8fafc80;
}

/* ==================== 自定义 Toast 轻提示样式 ==================== */
/* 全局容器 */
.custom-toast {
    /* 普通提示（主题深蓝 #052658） */
    --info-or-other-bg: #f5f8fb;
    --info-or-other-text: #052658;
    --info-or-other-border: #d4e1f5;
    /* 成功提示 */
    --success-bg: #dcfce7;
    --success-text: #166534;
    --success-border: #bbf7d0;
    /* 错误提示 */
    --error-bg: #fee2e2;
    --error-text: #fb2c36;
    --error-border: #fecaca;
    /* 警告提示（金黄配色） */
    --warning-bg: #fff9e6;
    --warning-text: #f0b100;
    --warning-border: #fadb8e;
    /* 通用样式 */
    --border-radius: 8px;
    --padding: 12px 16px;
    --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    --font-size: 14px;
    --font-weight: 500;
    /* PC提示位置 */
    --width: max-content !important;
}

/* 移动端提示位置 */
@media (max-width: 600px) {
    .custom-toast [data-sonner-toast] {
        width: max-content !important;
        margin: 0 auto !important;
        left: -32px !important;
    }
}

/* 通用样式 */
.custom-toast [data-sonner-toast] {
    border-radius: var(--border-radius) !important;
    padding: var(--padding) !important;
    box-shadow: var(--shadow) !important;
    font-size: var(--font-size) !important;
    font-weight: var(--font-weight) !important;
    border: 1px solid var(--info-border) !important;
    /* PC提示位置 */
    top: 10px !important;
    left: -56px;
}

/* 提示样式 */
.custom-toast [data-sonner-toast][data-type="info"] {
    background: var(--info-or-other-bg) !important;
    color: var(--info-or-other-text) !important;
    border-color: var(--info-or-other-border) !important;
}

/* 成功样式 */
.custom-toast [data-sonner-toast][data-type="success"] {
    /* background: var(--success-bg) !important;
    color: var(--success-text) !important;
    border-color: var(--success-border) !important; */
    background: var(--info-or-other-bg) !important;
    color: var(--info-or-other-text) !important;
    border-color: var(--info-or-other-border) !important;
}

/* 错误样式 */
.custom-toast [data-sonner-toast][data-type="error"] {
    background: var(--error-bg) !important;
    color: var(--error-text) !important;
    border-color: var(--error-border) !important;
}

/* 警告样式 */
.custom-toast [data-sonner-toast][data-type="warning"] {
    /* background: var(--warning-bg) !important;
    color: var(--warning-text) !important;
    border-color: var(--warning-border) !important; */
    background: var(--info-or-other-bg) !important;
    color: var(--info-or-other-text) !important;
    border-color: var(--info-or-other-border) !important;
}

/* 关闭按钮隐藏（保持自动消失） */
.custom-toast [data-close-button] {
    display: none !important;
}
```

#### 2.2.3 布局相关

##### 2.2.3.1 根布局组件

`/src/app/layout.tsx`：

```tsx
// ==================== 根布局组件 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import { Toaster } from "sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import "./globals.css";
// ========== Icon、Type ========== //
import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

const geistSans = Geist({
    variable: "--font-geist-sans",
    subsets: ["latin"],
    preload: false, // 关闭预加载，警告直接消失
});

const geistMono = Geist_Mono({
    variable: "--font-geist-mono",
    subsets: ["latin"],
    preload: false,
});

export const metadata: Metadata = {
    title: "T.AI - AI助手",
    description: "Chat with T.AI – your intelligent assistant for coding, content creation, file reading, and more. Upload documents, engage in long-context conversations, and get expert help in AI, natural language processing, and beyond. | T.AI 助力编程代码开发、创意写作、文件处理等任务，支持文件上传及长文本对话，随时为您提供高效的AI支持。",
    keywords: ["AI", "Assistant", "Next.js", "Chat"],
    icons: {
        icon: "/favicon.ico",
        apple: "/assets/images/logo.png",
    },
    authors: [{ name: "谌中钱" }],
    creator: "谌中钱",
    publisher: "爬界科技",
    formatDetection: {
        email: false,
        address: false,
        telephone: false,
    },
    metadataBase: new URL("https://tai.templechann.com"),
    openGraph: {
        title: "T.AI - AI助手",
        description: "Chat with T.AI – your intelligent assistant for coding, content creation, file reading, and more. Upload documents, engage in long-context conversations, and get expert help in AI, natural language processing, and beyond. | T.AI 助力编程代码开发、创意写作、文件处理等任务，支持文件上传及长文本对话，随时为您提供高效的AI支持。",
        url: "https://tai.templechann.com",
        siteName: "T.AI - AI助手",
        locale: "zh_CN",
        type: "website",
        images: [{ url: "https://tai.templechann.com/logo.png" }],
    },
    twitter: {
        card: "summary_large_image",
        title: "T.AI - AI助手",
        description: "Chat with T.AI – your intelligent assistant for coding, content creation, file reading, and more. Upload documents, engage in long-context conversations, and get expert help in AI, natural language processing, and beyond. | T.AI 助力编程代码开发、创意写作、文件处理等任务，支持文件上传及长文本对话，随时为您提供高效的AI支持。",
        images: [{ url: "https://tai.templechann.com/logo.png" }],
    },
    robots: {
        index: true,
        follow: true,
        googleBot: {
            index: true,
            follow: true,
            "max-video-preview": -1,
            "max-image-preview": "large",
            "max-snippet": -1,
        },
    },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
    return (
        // data-scroll-behavior="smooth"：Next.js 路由切换时会自动管理页面滚动，手动开启平滑滚动需要显示声明，不然会有警告
        <html lang="zh-CN" className={`${geistSans.variable} ${geistMono.variable} antialiased`} data-scroll-behavior="smooth">
            {/* h-dvh，是现代动态 CSS 视口单位，专门解决移动端浏览器的坑：传统 vh 会被地址栏 / 底部导航栏挤占，导致高度计算错误 */}
            <body className="h-dvh w-full overflow-hidden">
                <TooltipProvider>{children}</TooltipProvider>
                {/* 全局提示容器，轻量级 toast，shadcn/ui 官方推荐 */}
                {/* toast.success("操作成功！"); 
                    toast.error("操作失败！");
                    toast.warning("请注意！");
                    toast.info("普通提示");
                */}
                <Toaster
                    className="custom-toast" // 自定义样式
                    position="top-center" // 位置：top-center / top-right 等
                    duration={2000} // 2秒自动消失
                    expand={true} // 多个弹窗需要展开
                    visibleToasts={3} // 允许同时显示5个弹窗
                    closeButton={false} // 隐藏关闭按钮
                    richColors={false} // 关闭默认配色，用我们的自定义色
                    gap={10} // 多个提示间距
                />
            </body>
        </html>
    );
}
```

##### 2.2.3.2 基础布局组件

`/src/components/layouts/CommonLayout.tsx`：

```tsx
"use client";

// ==================== 基础布局组件 ==================== //

// ========== React、Next、Utils ========== //
import { useEffect, useLayoutEffect, useRef, useState } from "react";
// ========== Components、CSS ========== //
import Sidebar from "@/components/features/sidebar/Sidebar";
import CommonModal from "@/components/features/common/CommonModal";
import DocPreview from "@/components/features/common/DocPreview";
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //

export default function BaseLayout({ children }: Readonly<{ children: React.ReactNode }>) {
    const [autoScroll, setAutoScroll] = useState(true);
    // 移动端触摸状态（解决 iOS 滑动冲突）
    const [isTouching, setIsTouching] = useState(false);

    // 精确订阅
    const collapsed = useCommonStore((state) => state.collapsed);
    const currentSession = useSessionStore((state) => state.currentSession);
    const isSendLoading = useChatStore((state) => state.isLoading);

    const chatContainerRef = useRef<HTMLDivElement>(null);
    const timerRef = useRef<NodeJS.Timeout[]>([]);
    const rafId = useRef<number>(null);

    // 清理所有定时器（防止内存泄漏）
    const clearAllTimers = () => {
        timerRef.current.forEach((timer) => clearTimeout(timer));
        timerRef.current = [];
    };

    // 组件卸载销毁定时器
    useEffect(() => {
        return () => clearAllTimers();
    }, []);

    // 自动滚动到最底部
    const scrollToBottom = () => {
        if (autoScroll && !isTouching && chatContainerRef.current) {
            chatContainerRef.current.scrollTop = chatContainerRef.current.scrollHeight;
        }
    };

    // 当组件重新挂载时，重新开启自动滚动并滚动到底部
    useLayoutEffect(() => {
        if (currentSession) {
            rafId.current = requestAnimationFrame(() => {
                scrollToBottom();
            });
        }
        return () => {
            rafId.current && cancelAnimationFrame(rafId.current);
        };
    }, [currentSession, autoScroll]);

    useLayoutEffect(() => {
        let timer = null;
        if (isSendLoading) {
            // 异步更新，绕过 ESLint 严格校验，功能完全不变
            timer = setTimeout(() => {
                setAutoScroll(true);
            }, 0);
            timerRef.current.push(timer);
        }
    }, [isSendLoading]);

    // 处理滚动事件，用户手动滚动时暂停自动滚动
    const handleScroll = () => {
        if (!chatContainerRef.current || isTouching) return;

        const { scrollTop, scrollHeight, clientHeight } = chatContainerRef.current;
        // 移动端适配：缩小阈值，更灵敏
        const threshold = window.innerWidth < 768 ? 160 : 100;

        if (scrollHeight - scrollTop - clientHeight > threshold) {
            setAutoScroll(false);
        } else {
            setAutoScroll(true);
        }
    };

    // 触摸事件
    const handleTouchStart = () => setIsTouching(true);
    const handleTouchEnd = () => {
        setIsTouching(false);
        handleScroll();
        autoScroll && scrollToBottom();
    };

    return (
        // flex 布局必须加 w-full：因为 flex 布局默认宽度是内容宽度，会被被内容撑开
        <div className="flex h-full w-full md:min-w-350">
            <Sidebar />
            <div ref={chatContainerRef} className={`${!collapsed ? "md:pl-64" : ""} flex h-full w-full flex-1 justify-center overflow-y-auto transition-all duration-300`} onScroll={handleScroll} onTouchStart={handleTouchStart} onTouchEnd={handleTouchEnd} onTouchCancel={handleTouchEnd}>
                {children}
            </div>
            <CommonModal />
            <DocPreview />
        </div>
    );
}
```

#### 2.2.4 基础相关

##### 2.2.4.1 通用弹窗组件

`/src/components/features/common/CommonModal.tsx`：

```tsx
"use client";

// ==================== 通用弹窗组件 ==================== //

// ========== React、Next、Utils ========== //
import { ReactNode } from "react";
// ========== Components、CSS ========== //
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
// ========== Icon、Type ========== //
import { AlertCircle, CheckCircle, Info, LoaderCircle } from "lucide-react";
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
// ========== Hooks ========== //
// ========== Services ========== //

export type ModalType = "success" | "error" | "warning" | "info"; // 弹窗类型

export interface CommonModalProps {
    // 受控显隐
    open: boolean;
    onOpenChange?: ((open: boolean) => void) | null;

    // 基础内容
    type?: ModalType;
    title?: string;
    // ReactNode，支持换行、标签、样式（不支持表格，可以在 children 用原生表格）
    description?: ReactNode;
    // 自定义内容
    children?: ReactNode;

    // 按钮配置
    confirmText?: string;
    cancelText?: string;
    showCancel?: boolean;
    confirmLoading?: boolean;

    // 回调
    onConfirm?: (() => void | Promise<void>) | null;
    onCancel?: (() => void) | null;
}

export default function CommonModal() {
    const commonModal = useCommonStore((state) => state.commonModal);
    const setCommonModal = useCommonStore((state) => state.setCommonModal);
    const resetCommonModal = useCommonStore((state) => state.resetCommonModal);

    const { open, onOpenChange, type = "info", title, description, children, confirmText = "确定", cancelText = "取消", showCancel = true, confirmLoading = false, onConfirm, onCancel } = commonModal;

    // 根据类型自动匹配标题图标
    const renderIcon = (): ReactNode => {
        switch (type) {
            case "success":
                return <CheckCircle className="h-6 w-6 text-[#166534]" />;
            case "error":
                return <AlertCircle className="h-6 w-6 text-[#FB2C36]" />;
            case "warning":
                return <Info className="h-6 w-6 text-[#F0B100]" />;
            case "info":
                return <Info className="h-6 w-6 text-[#052658]" />;
            default:
                return <Info className="h-6 w-6 text-[#052658]" />;
        }
    };

    // 处理确认
    const handleConfirm = async (): Promise<void> => {
        try {
            setCommonModal({ ...useCommonStore.getState().commonModal, confirmLoading: true });
            await onConfirm?.();
            setCommonModal({ ...useCommonStore.getState().commonModal, confirmLoading: false });
        } finally {
            // 默认自动关闭，如果需要关闭时进行其他操作，请设置 onOpenChange
            if (onOpenChange) {
                onOpenChange(false);
            } else {
                setCommonModal({ ...useCommonStore.getState().commonModal, open: false });
            }
        }
    };
    // 处理取消
    const handleCancel = (): void => {
        onCancel?.();

        // 默认自动关闭，如果需要关闭时进行其他操作，请设置 onOpenChange
        if (onOpenChange) {
            onOpenChange(false);
        } else {
            setCommonModal({ ...commonModal, open: false });
            resetCommonModal();
        }
    };

    return (
        <Dialog open={open} onOpenChange={onOpenChange || undefined}>
            <DialogContent
                className="md:max-w-100"
                // 隐藏标题右侧的关闭按钮
                showCloseButton={false}
                // 禁止外部点击关闭
                onInteractOutside={(e) => e.preventDefault()}
                // 禁止按 ESC 关闭
                onEscapeKeyDown={(e) => e.preventDefault()}
                // 取消打开时的默认聚焦行为
                onOpenAutoFocus={(e) => e.preventDefault()}
            >
                <DialogHeader className="flex flex-col gap-6">
                    <DialogTitle className="flex items-center justify-start gap-3 md:max-w-80">
                        <div className="shrink-0">{renderIcon()}</div>
                        <div className="flex-1 truncate" title={title}>
                            {title}
                        </div>
                    </DialogTitle>
                    <DialogDescription className="pb-2 text-gray-950">{description}</DialogDescription>
                </DialogHeader>

                {/* 自定义内容区域 */}
                {children && <div className="pb-2 text-gray-950">{children}</div>}
                <br />

                <DialogFooter className="flex items-center justify-end gap-2">
                    {/* 取消按钮 */}
                    {showCancel && (
                        <Button variant="ghost" onClick={handleCancel} disabled={confirmLoading} className="cursor-pointer">
                            {cancelText}
                        </Button>
                    )}

                    {/* 确认按钮（根据类型变色） */}
                    <Button variant={type === "error" ? "destructive" : "default"} disabled={confirmLoading} onClick={handleConfirm} className={`flex cursor-pointer gap-2 ${type !== "error" ? "bg-[#052658]" : ""}`}>
                        {/* 确认按钮加载中图标 */}
                        {confirmLoading && <LoaderCircle className="h-4! w-4! animate-spin" />}
                        {confirmText}
                    </Button>
                </DialogFooter>
            </DialogContent>
        </Dialog>
    );
}
```
 
##### 2.2.4.2 文档预览组件

`/src/components/features/common/DocPreview.tsx`

```tsx
"use client";

// ==================== 文档预览组件 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import Image from "next/image";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
// ========== Hooks ========== //
// ========== Services ========== //

export default function DocPreview() {
    const previewDoc = useCommonStore((state) => state.previewDoc);
    const isPreviewDocOpen = useCommonStore((state) => state.isPreviewDocOpen);
    const setIsPreviewDocOpen = useCommonStore((state) => state.setIsPreviewDocOpen);

    return (
        <Dialog open={isPreviewDocOpen} onOpenChange={setIsPreviewDocOpen}>
            <DialogContent className="flex h-[80vh] w-[90vw] max-w-[90vw]! flex-col overflow-hidden">
                <DialogHeader>
                    <DialogTitle className="flex items-center gap-3 text-xl">
                        <Image src={previewDoc ? `/assets/images/fileIcons/${previewDoc?.fileType}.png` : "/assets/images/logo.png"} alt="" width={20} height={20} priority />
                        <span className="w-[60vw] truncate text-base text-gray-900" title={previewDoc?.fileName}>
                            {previewDoc?.fileName}
                        </span>
                    </DialogTitle>
                    <DialogDescription></DialogDescription>
                </DialogHeader>

                <div className="min-h-0 flex-1 overflow-x-hidden overflow-y-auto px-1 py-0 break-all">
                    <pre className="rounded-md border border-gray-200 bg-white px-4 py-2 font-mono text-sm leading-relaxed whitespace-pre-wrap text-gray-800 shadow-sm">{previewDoc?.content || "文件内容为空"}</pre>
                </div>
            </DialogContent>
        </Dialog>
    );
}
```


#### 2.2.5 侧边栏相关

##### 2.2.5.1 侧边栏组件

`/src/components/features/sidebar/Sidebar.tsx`：

```tsx
"use client";

// ==================== 侧边栏组件 ==================== //

// ========== React、Next、Utils ========== //
import { useRouter } from "next/navigation";
// ========== Components、CSS ========== //
import Image from "next/image";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
import SessionList from "@/components/features/sidebar/SessionList";
// ========== Icon、Type ========== //
import { PanelLeft, MessageCirclePlus } from "lucide-react";
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //

export default function Sidebar() {
    const collapsed = useCommonStore((state) => state.collapsed);
    const setCollapsed = useCommonStore((state) => state.setCollapsed);
    const currentSession = useSessionStore((state) => state.currentSession);
    const setCurrentSession = useSessionStore((state) => state.setCurrentSession);
    const resetChat = useChatStore((state) => state.resetChat);

    const router = useRouter();

    // 会话新开启
    const handleSessionNewClick = (): void => {
        if (!currentSession) {
            toast.info("已在新对话中");
            return;
        }

        // 开启新会话
        router.push("/");
        setCurrentSession(null);
        resetChat();
    };

    return (
        <>
            <div className={`hidden md:flex ${!collapsed ? "translate-x-0" : "-translate-x-full"} fixed top-0 left-0 z-30! h-full w-64 flex-col overflow-hidden border-r border-gray-200 bg-[#F9F9F9] transition-transform duration-300 ease-in-out`}>
                <div className="flex items-center justify-between pt-4 pr-2 pb-5 pl-4">
                    <div className="flex items-center gap-2">
                        <Image className="rounded-sm" src="/assets/images/logo.png" alt="T.AI" width={32} height={32} priority />
                        <span className="text-xl font-bold tracking-widest text-[#052658] italic drop-shadow-2xl">T.AI</span>
                    </div>
                    <Tooltip>
                        <TooltipTrigger asChild>
                            <Button size="icon" variant="ghost" className="cursor-pointer text-gray-500" onClick={() => setCollapsed(!collapsed)}>
                                <PanelLeft className="h-6! w-6!" />
                            </Button>
                        </TooltipTrigger>
                        <TooltipContent>
                            <p>收起边栏</p>
                        </TooltipContent>
                    </Tooltip>
                </div>
                <div className="mx-4 flex cursor-pointer items-center justify-center rounded-xl border border-gray-500 bg-white py-1 transition-shadow hover:shadow-md" onClick={() => handleSessionNewClick()}>
                    <Button size="icon" variant="ghost" className="cursor-pointer">
                        <MessageCirclePlus className="h-4! w-4!" />
                    </Button>
                    <span className="text-sm">开启新对话</span>
                </div>
                <SessionList />
            </div>

            <div className={`hidden md:flex ${!collapsed ? "pointer-events-none opacity-0" : "pointer-events-auto opacity-100"} fixed top-4 left-4 z-30! flex items-center gap-4 transition-opacity duration-1000 ease-in-out`}>
                <Image className="rounded-sm" src="/assets/images/logo.png" alt="T.AI" width={32} height={32} priority />
                <div className="flex items-center gap-5 rounded-xl border border-gray-500 px-3.5 py-2">
                    <Tooltip>
                        <TooltipTrigger asChild>
                            <Button size="icon" variant="ghost" className="h-5! w-5! cursor-pointer" onClick={() => setCollapsed(!collapsed)}>
                                <PanelLeft className="h-5! w-5!" />
                            </Button>
                        </TooltipTrigger>
                        <TooltipContent>
                            <p>打开边栏</p>
                        </TooltipContent>
                    </Tooltip>
                    <Tooltip>
                        <TooltipTrigger asChild>
                            <Button size="icon" variant="ghost" className="h-5! w-5! cursor-pointer" onClick={() => handleSessionNewClick()}>
                                <MessageCirclePlus className="h-5! w-5!" />
                            </Button>
                        </TooltipTrigger>
                        <TooltipContent>
                            <p>开启新对话</p>
                        </TooltipContent>
                    </Tooltip>
                </div>
            </div>
        </>
    );
}
```

##### 2.2.5.2 侧边栏组件 (移动端)

`/src/components/features/sidebar/SidebarMobile.tsx`：

```tsx
"use client";

// ==================== 侧边栏组件（移动端） ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Drawer, DrawerContent, DrawerDescription, DrawerTitle, DrawerTrigger } from "@/components/ui/drawer";
import SessionList from "@/components/features/sidebar/SessionList";
// ========== Icon、Type ========== //
import { PanelLeft } from "lucide-react";
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { useSessionStore } from "@/store/useSessionStore";
// ========== Hooks ========== //
// ========== Services ========== //

export default function SidebarMobile() {
    const isSidebarMobileOpen = useCommonStore((state) => state.isSidebarMobileOpen);
    const setIsSidebarMobileOpen = useCommonStore((state) => state.setIsSidebarMobileOpen);
    const editId = useSessionStore((state) => state.editId);
    const resetEdit = useSessionStore((state) => state.resetEdit);

    // 受控抽屉隐藏操作
    const handleSidebarMobileClose = (isOpen: boolean): void => {
        // 抽屉隐藏后，取消重命名状态
        if (editId && !isOpen) {
            resetEdit();
            toast.info("会话重命名已取消");
        }
        // 设置受控抽屉状态
        setIsSidebarMobileOpen(isOpen);
    };

    return (
        // autoFocus：禁止抽屉隐藏后，抽屉按钮获取焦点
        <Drawer direction="left" open={isSidebarMobileOpen} onOpenChange={(isOpen) => handleSidebarMobileClose(isOpen)} autoFocus={false}>
            <DrawerTrigger asChild>
                <Button size="icon" variant="ghost" className="h-6 w-6 cursor-pointer">
                    <PanelLeft className="h-6! w-6!" />
                </Button>
            </DrawerTrigger>
            {/* h-dvh!，防止输入法自动关闭时，SessionList 高度没有自适应占满屏幕 */}
            {/* 取消 ESC 关闭抽屉，兼容会话列表组件 SessionList */}
            <DrawerContent className="h-dvh! rounded-none!" onEscapeKeyDown={(e) => e.preventDefault()}>
                <DrawerTitle />
                <DrawerDescription />
                <SessionList />
            </DrawerContent>
        </Drawer>
    );
}
```

##### 2.2.5.3 会话列表组件

`/src/components/features/sidebar/SessionList.tsx`：

```tsx
"use client";

// ==================== 会话列表组件 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import { Button } from "@/components/ui/button";
import { ButtonGroup } from "@/components/ui/button-group";
import { Input } from "@/components/ui/input";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
// ========== Icon、Type ========== //
import { Bot, Check, MoreHorizontal, X } from "lucide-react";
import type { Session } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
import { useSessionList } from "@/components/hooks/sidebar/useSessionList";
// ========== Services ========== //

export default function SessionList() {
    // 从业务Hook中引入相关属性和方法
    const { currentSession, editId, editName, sessionList, handleSessionDetailClick, handleSessionRenameClick, handleSessionRenameConfirm, handleSessionRenameCancel, handleSessionDelClick, handleAllDropdownMenusClose, handleInputRefsSet, handleInputKeyDown, handleInputTextChange, splitSessionsByTime } = useSessionList();
    const { sessions7Days, sessions30Days, sessionsOlder } = splitSessionsByTime();

    // 渲染会话列表的函数
    const renderSessionItem = (session: Session) => (
        <div key={session.id} className="relative">
            {/* 单会话正常显示 */}
            <div className={` ${editId === session.id ? "pointer-events-none opacity-0" : "pointer-events-auto opacity-100"} ${session.id === currentSession?.id ? "bg-blue-100 text-[#052658]" : "hover:bg-gray-200"} flex h-11 cursor-pointer items-center justify-between rounded-lg pr-2 pl-3`} onClick={() => handleSessionDetailClick(session.id)}>
                <div className="flex-1 truncate text-sm" title={session.title}>
                    {session.title}
                </div>
                <DropdownMenu onOpenChange={handleAllDropdownMenusClose}>
                    <DropdownMenuTrigger asChild>
                        <Button
                            size="icon"
                            variant="ghost"
                            className="h-8! w-7! cursor-pointer rounded-xl text-[#052658] hover:bg-gray-300"
                            onClick={(e) => {
                                e.stopPropagation();
                            }}
                        >
                            <MoreHorizontal className="h-4! w-4!" />
                        </Button>
                    </DropdownMenuTrigger>

                    {/* onCloseAutoFocus 取消自动聚焦弹窗关闭后的默认行为 */}
                    <DropdownMenuContent align="end" onCloseAutoFocus={(e) => e.preventDefault()}>
                        <DropdownMenuItem className="cursor-pointer" onClick={(e) => handleSessionRenameClick(e, session)}>
                            重命名
                        </DropdownMenuItem>
                        <DropdownMenuSeparator />
                        <DropdownMenuItem className="cursor-pointer text-red-600" onClick={(e) => handleSessionDelClick(e, session)}>
                            删除
                        </DropdownMenuItem>
                    </DropdownMenuContent>
                </DropdownMenu>
            </div>

            {/* 会话重命名框显示 */}
            <div className={`${editId === session.id ? "pointer-events-auto opacity-100" : "pointer-events-none opacity-0"} absolute top-0 left-0 my-0.5 rounded-lg border-2 border-[#052658] pr-2`}>
                <ButtonGroup className="flex items-center justify-between">
                    <Input className="h-9 border-0 border-[#052658]/20 pr-2 pl-4 focus:border-[#052658]/20 focus:ring-0 focus-visible:ring-0 focus-visible:outline-none" ref={(el) => handleInputRefsSet(el, session)} value={editName} onChange={handleInputTextChange} onKeyDown={(e) => handleInputKeyDown(e, session)} />
                    <Button size="icon" variant="ghost" className="mr-1 h-4 w-4 cursor-pointer text-[#166534]" onClick={() => handleSessionRenameConfirm(session.id)}>
                        <Check className="h-4! w-4!" />
                    </Button>
                    <Button size="icon" variant="ghost" className="h-4 w-4 cursor-pointer text-[#FB2C36]" onClick={handleSessionRenameCancel}>
                        <X className="h-4! w-4!" />
                    </Button>
                </ButtonGroup>
            </div>
        </div>
    );

    return (
        // Tailwind CSS 规则：calc 里不能有空格
        <div className="flex h-full flex-col overflow-x-hidden overflow-y-auto pr-2 pb-2 pl-3 md:h-[calc(100%-64px)]">
            {sessionList?.length ? (
                <>
                    {/* 7天内会话 */}
                    {sessions7Days.length > 0 && (
                        <div className="mt-7 mb-2">
                            <h3 className="pb-2 pl-3 text-xs font-semibold text-[#052658] uppercase">7天内</h3>
                            {sessions7Days.map(renderSessionItem)}
                        </div>
                    )}

                    {/* 30天内会话 */}
                    {sessions30Days.length > 0 && (
                        <div className="mt-5 mb-2">
                            <h3 className="pb-2 pl-3 text-xs font-semibold text-[#052658] uppercase">30天内</h3>
                            {sessions30Days.map(renderSessionItem)}
                        </div>
                    )}

                    {/* 更早会话 */}
                    {sessionsOlder.length > 0 && (
                        <div className="mt-5 mb-2">
                            <h3 className="pb-2 pl-3 text-xs font-bold text-[#052658] uppercase">更早</h3>
                            {sessionsOlder.map(renderSessionItem)}
                        </div>
                    )}
                </>
            ) : (
                <>
                    <div className="flex h-full flex-col items-center justify-center gap-5">
                        <Bot className="h-6! w-6! text-gray-500" />
                        <div className="text-md font-bold text-gray-500">暂无历史会话</div>
                    </div>
                </>
            )}
        </div>
    );
}
```

###### 2.2.5.3.1 会话列表 Hook 组件

`/src/components/hooks/sidebar/useSessionList.tsx`：

```tsx
"use client";

// ==================== 会话列表 Hook 组件 ==================== //

// ========== React、Next、Utils ========== //
import { useEffect, useLayoutEffect, useRef } from "react";
import { useRouter } from "next/navigation";
// ========== Components、CSS ========== //
import { toast } from "sonner";
// ========== Icon、Type ========== //
import type { ChangeEvent, KeyboardEvent } from "react";
import type { Session } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //
import { useGetSessionList } from "@/components/hooks/common/useSwrApi";
import { sessionService } from "@/services/sessionService";

export const useSessionList = () => {
    const setCommonModal = useCommonStore((state) => state.setCommonModal);
    const setIsSidebarMobileOpen = useCommonStore((state) => state.setIsSidebarMobileOpen);
    const sessionList = useSessionStore((state) => state.sessionList);
    const setSessionList = useSessionStore((state) => state.setSessionList);
    const currentSession = useSessionStore((state) => state.currentSession);
    const setCurrentSession = useSessionStore((state) => state.setCurrentSession);
    const editId = useSessionStore((state) => state.editId);
    const setEditId = useSessionStore((state) => state.setEditId);
    const editName = useSessionStore((state) => state.editName);
    const setEditName = useSessionStore((state) => state.setEditName);
    const resetEdit = useSessionStore((state) => state.resetEdit);
    const resetChat = useChatStore((state) => state.resetChat);
    const chat = useChatStore((state) => state.chat);

    const router = useRouter();
    const inputRefs = useRef<Map<string, HTMLInputElement>>(new Map());
    const timerRef = useRef<NodeJS.Timeout[]>([]);

    const { fetchedSessionList, refreshSessionList } = useGetSessionList();

    // 清理所有定时器（防止内存泄漏）
    const clearAllTimers = () => {
        timerRef.current.forEach((timer) => clearTimeout(timer));
        timerRef.current = [];
    };

    // 组件卸载销毁定时器
    useEffect(() => {
        return () => clearAllTimers();
    }, []);

    // 会话列表 状态存储
    useEffect(() => {
        if (fetchedSessionList) {
            setSessionList(fetchedSessionList);
        }
    }, [fetchedSessionList]);

    // 输入框获取焦点
    // 问题：输入框获取焦点时，会立马失去焦点
    // 原因：shadcn/ui 的下拉菜单关闭瞬间，会给父容器自动设置 aria-hidden="true"（无障碍机制），会强制清空父容器在的所有焦点
    // 解决办法：
    // 1 必须：<DropdownMenuContent> 设置 onCloseAutoFocus, 取消 自动聚焦弹窗关闭后 的默认行为（取消开启无障碍机制的行为）
    // 2 加强：延时菜单项的点击事件 handleSessionRenameClick 100ms 左右再进入编辑态，等菜单完全关闭，aria-hidden 自动移除（等开启的无障碍机制结束）
    useLayoutEffect(() => {
        if (!editId) return;
        const rafId = requestAnimationFrame(() => {
            const input = inputRefs.current.get(editId);
            if (input) {
                input.focus();
            }
        });
        return () => cancelAnimationFrame(rafId);
    }, [editId]);

    // 会话详情获取
    const handleSessionDetailClick = (sessionId: string): void => {
        // 如果有会话正在编辑重命名，则取消重命名状态
        if (editId) {
            handleSessionRenameCancel();
        }
        if (!sessionId) {
            toast.error("会话ID不存在");
            return;
        }
        // 关闭侧边栏（移动端）
        setIsSidebarMobileOpen(false);
        if (!currentSession || (currentSession && sessionId !== currentSession.id)) {
            resetChat(chat.model);
        }
        // 跳转到会话页面组件
        router.push(`/chat/${sessionId}`);
    };

    // 会话重命名点击
    const handleSessionRenameClick = (e: React.MouseEvent<HTMLDivElement>, session: Session): void => {
        e.stopPropagation();
        if (!session.id) {
            toast.error("会话ID不存在");
            return;
        }

        // 延时菜单项的点击事件 handleSessionRenameClick 100ms 左右再进入编辑态，等菜单完全关闭，aria-hidden 自动移除
        const timer = setTimeout(() => {
            setEditId(session.id);
            setEditName(session.title || "");
        }, 100);

        timerRef.current.push(timer);
    };

    // 会话重命名确认
    const handleSessionRenameConfirm = async (sessionId: string): Promise<void> => {
        if (!sessionId) {
            toast.error("会话ID不存在");
            return;
        }
        if (!editName.trim()) {
            toast.error("会话名不能设置为空");
            return;
        }

        try {
            // 更新会话名称
            await sessionService.updateSession(sessionId, { title: editName.trim().slice(0, 19) });
            toast.success("会话重命名成功");
            if (currentSession && sessionId === currentSession.id) {
                const res = await sessionService.getSession(sessionId);
                setCurrentSession(res.data);
            }
            resetEdit();
            refreshSessionList();
        } catch (error) {
            console.error(error);
            toast.error("会话重命名失败");
        }
    };

    // 会话重命名取消
    const handleSessionRenameCancel = (): void => {
        resetEdit();
        toast.info("会话重命名已取消");
    };

    // 会话删除点击
    const handleSessionDelClick = (e: React.MouseEvent<HTMLDivElement>, session: Session): void => {
        e.stopPropagation();
        if (!session.id) {
            toast.error("会话ID不存在");
            return;
        }
        // 打开删除弹窗
        setCommonModal({
            open: true,
            title: "删除对话",
            type: "error",
            description: (
                <>
                    确定删除对话 「{session.title}」吗?
                    <br />
                    <br />
                    此操作不可撤销，所有对话记录将被永久删除。
                </>
            ),
            confirmText: "删除",
            cancelText: "取消",
            onConfirm: () => {
                handleSessionDelConfirm(session.id);
            },
        });
    };

    // 会话删除确认
    const handleSessionDelConfirm = async (sessionId: string): Promise<void> => {
        if (!sessionId) {
            toast.error("会话ID不存在");
            return;
        }
        try {
            // 会话删除
            await sessionService.deleteSession(sessionId);
            toast.success("会话删除成功");
            if (currentSession && sessionId === currentSession.id) {
                router.push(`/`);
            }
            setCurrentSession(null);
            refreshSessionList();
        } catch (error) {
            console.error(error);
            toast.error("会话删除失败");
        }
    };

    // 手动安全关闭所有下拉菜单
    // 问题：如果前一个菜单没有关闭，在点击打开下一个菜单前，旧菜单不会关闭
    // 原因：shadcn/ui 的 DropdownMenu 组件默认独立管理自身展开 / 收起状态，多个 DropdownMenu 实例之间不会联动，因此点击新菜单的触发按钮时，旧菜单不会自动关闭。
    // 解决办法：
    // 触发 ESC 按键事件关闭菜单（shadcn/ui 原生支持 ESC 关闭，最稳妥），无副作用
    const handleAllDropdownMenusClose = (): void => {
        // 函数内部的局部临时对象，自动回收，无内存泄漏诱因
        document.dispatchEvent(
            new KeyboardEvent("keydown", {
                key: "Escape",
                // bubbles: true, // 开启事件冒泡，这里是 按键事件，不需要设置
                cancelable: true, // 可取消事件，浏览器标准，兼容必备
            }),
        );
    };

    // 设置输入框 Refs
    const handleInputRefsSet = (el: HTMLInputElement | null, session: Session): void => {
        if (el) {
            inputRefs.current.set(session.id, el);
        } else {
            inputRefs.current.delete(session.id);
        }
    };
    // 输入框按键事件
    const handleInputKeyDown = (e: KeyboardEvent<HTMLInputElement>, session: Session): void => {
        if (e.key === "Enter") handleSessionRenameConfirm(session.id);
        if (e.key === "Escape") handleSessionRenameCancel();
    };

    // 输入框文本限制
    const handleInputTextChange = (e: ChangeEvent<HTMLInputElement>): void => {
        const value = e.target.value;

        if (value.length > 20) {
            toast.warning("最多只能输入20个文字");
            setEditName(value.slice(0, 19));
        } else {
            setEditName(value);
        }
    };

    // 按创建时间分割会话列表
    const splitSessionsByTime = () => {
        const now = new Date();
        const sevenDaysAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
        const thirtyDaysAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);

        const sessions7Days: Session[] = [];
        const sessions30Days: Session[] = [];
        const sessionsOlder: Session[] = [];

        sessionList.forEach((session) => {
            if (session.createTime) {
                const createTime = new Date(session.createTime);
                if (createTime >= sevenDaysAgo) {
                    sessions7Days.push(session);
                } else if (createTime >= thirtyDaysAgo) {
                    sessions30Days.push(session);
                } else {
                    sessionsOlder.push(session);
                }
            } else {
                // 没有创建时间的会话默认归为更早
                sessionsOlder.push(session);
            }
        });

        return { sessions7Days, sessions30Days, sessionsOlder };
    };

    return {
        currentSession,
        editId,
        editName,
        sessionList,
        setEditName,
        handleSessionDetailClick,
        handleSessionRenameClick,
        handleSessionRenameConfirm,
        handleSessionRenameCancel,
        handleSessionDelClick,
        handleAllDropdownMenusClose,
        handleInputRefsSet,
        handleInputKeyDown,
        handleInputTextChange,
        splitSessionsByTime,
    };
};
```


#### 2.2.6 会话相关

##### 2.2.6.1 会话标题组件

`/src/components/features/chat/chat-title/ChatTitle.tsx`：

```tsx
"use client";

// ==================== 会话标题组件 ==================== //

// ========== React、Next、Utils ========== //
import { useRouter } from "next/navigation";
// ========== Components、CSS ========== //
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import SidebarMobile from "@/components/features/sidebar/SidebarMobile";
// ========== Icon、Type ========== //
import { MessageCirclePlus } from "lucide-react";
// ========== Stroe、Constants ========== //
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //

export default function ChatTitle() {
    const currentSession = useSessionStore((state) => state.currentSession);
    const setCurrentSession = useSessionStore((state) => state.setCurrentSession);
    const resetChat = useChatStore((state) => state.resetChat);

    const router = useRouter();

    // 会话新开启
    const handleSessionNewClick = (): void => {
        if (!currentSession) {
            toast.info("已在新对话中");
            return;
        }

        // 开启新会话
        router.push("/");
        setCurrentSession(null);
        resetChat();
    };

    return (
        <>
            {/* PC端 */}
            <div className={`${currentSession ? "hidden md:flex" : "hidden"} h-14 w-full items-center justify-center bg-white`}>
                <div className="mx-40 flex-1 truncate text-center font-bold" title={currentSession?.title}>
                    {currentSession?.title}
                </div>
            </div>
            {/* 移动端 */}
            <div className="z-30! flex h-14 w-full items-center justify-between gap-12 bg-white px-3 md:hidden">
                <SidebarMobile />
                <div className={`${currentSession ? "" : "hidden"} flex-1 truncate text-center font-bold`} title={currentSession?.title}>
                    {currentSession?.title}
                </div>
                <Button size="icon" variant="ghost" className="h-6 w-6 cursor-pointer" onClick={() => handleSessionNewClick()}>
                    <MessageCirclePlus className="h-6! w-6!" />
                </Button>
            </div>
        </>
    );
}
```

##### 2.2.6.2 会话内容组件

`/src/components/features/chat/chat-content/ChatContent.tsx`：

```tsx
"use client";

// ==================== 会话内容组件 ====================

// ========== React、Next、Utils ==========
import { useEffect, useRef, useState } from "react";
import { copyToClipboard } from "@/lib/utils/common-tools";
// ========== Components、CSS ==========
import Image from "next/image";
import { Button } from "@/components/ui/button";
import ChatDocShow from "@/components/features/chat/chat-box/ChatDocShow";
// ========== Icon、Type ==========
import { Copy, Check, RefreshCcw, LoaderCircle } from "lucide-react";
import type { Chat, ChatHistory, Message } from "@/lib/types/app";
// ========== Stroe、Constants ==========
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ==========
// ========== Services ==========

export default function ChatContent() {
    const [copiedId, setCopiedId] = useState<string | null>(null);

    const currentSession = useSessionStore((state) => state.currentSession);
    const setChat = useChatStore((state) => state.setChat);
    const setIsAutoSend = useChatStore((state) => state.setIsAutoSend);

    const timerRef = useRef<NodeJS.Timeout[]>([]);

    // 清理所有定时器（防止内存泄漏）
    const clearAllTimers = () => {
        timerRef.current.forEach((timer) => clearTimeout(timer));
        timerRef.current = [];
    };

    // 组件卸载销毁定时器
    useEffect(() => {
        return () => clearAllTimers();
    }, []);

    const handleCopy = (text: string, id: string) => {
        copyToClipboard(text);
        setCopiedId(id);

        // 2秒后重置复制状态
        const timer = setTimeout(() => setCopiedId(null), 2000);
        timerRef.current.push(timer);
    };

    const handleRetry = (message: Message) => {
        const chatParams: Chat = {
            id: currentSession?.id || "",
            model: message.model,
            content: message.content,
            chatHistorys: currentSession?.messages?.map((msg) => ({ role: msg.role.trim(), content: msg.content.trim() }) as ChatHistory) || [],
            docs: message.docs,
            hasDocHistorys: !!currentSession?.messages?.some((item) => item.docs?.length > 0),
        };
        setChat(chatParams);
        setIsAutoSend(true);
    };

    return (
        <div className="flex h-full w-full flex-col gap-6 px-4 md:px-0">
            {currentSession?.messages?.map((msg, index) => (
                <div key={index} className={`flex w-full ${msg.role === "user" ? "justify-end" : "justify-start"}`}>
                    {/* AI 回答：左侧 */}
                    {msg.role === "assistant" && (
                        <div className="flex w-[92%] flex-col gap-1">
                            <div className="flex w-full gap-1">
                                <div className="shrink-0 pt-1 pr-1">
                                    <Image className="rounded-sm" src={msg.model ? `/assets/images/modelIcons/${msg.model}.png` : "/assets/images/logo.png"} alt="T.AI" width={30} height={30} priority />
                                </div>
                                {msg.content ? (
                                    <div className="max-w-full min-w-0! rounded-2xl border border-gray-200 bg-white px-4 py-3 wrap-break-word whitespace-pre-wrap">
                                        <div className="prose prose-sm md:prose-base max-w-none text-gray-700">{msg.content}</div>
                                    </div>
                                ) : (
                                    <Button size="icon" variant="ghost" className="mt-2.5 ml-1 h-6 w-6 overflow-hidden text-gray-400">
                                        <LoaderCircle className="h-5! w-5! animate-spin" />
                                    </Button>
                                )}
                            </div>
                            {msg.content ? (
                                <div className="flex items-center gap-3">
                                    <Button size="icon" variant="ghost" className="mt-1 ml-11 h-6 w-6 cursor-pointer rounded-full text-gray-400 hover:bg-gray-100 hover:text-gray-600 active:translate-y-0!" onClick={() => handleCopy(msg.content, `${msg.role}-${index}`)}>
                                        {copiedId === `${msg.role}-${index}` ? <Check className="h-4 w-4" /> : <Copy className="h-5! w-5!" />}
                                    </Button>
                                </div>
                            ) : (
                                <></>
                            )}
                        </div>
                    )}

                    {/* 用户回答：右侧 */}
                    {msg.role === "user" && (
                        <div className="flex max-w-[85%] flex-col items-end gap-1">
                            <ChatDocShow messageDocs={msg.docs} />
                            <div className="max-w-full min-w-0! rounded-2xl bg-[#052658] px-4 py-3 wrap-break-word whitespace-pre-wrap">
                                <div className="prose prose-sm md:prose-base prose-invert text-white">{msg.content}</div>
                            </div>
                            <div className="flex items-center gap-2">
                                <Button size="icon" variant="ghost" className="mt-1 h-6 w-6 cursor-pointer rounded-full text-gray-400 hover:bg-gray-100 hover:text-gray-600 active:translate-y-0!" onClick={() => handleRetry(msg)}>
                                    <RefreshCcw className="h-5! w-5!" />
                                </Button>
                                <Button size="icon" variant="ghost" className="mt-1 mr-2 h-6 w-6 cursor-pointer rounded-full text-gray-400 hover:bg-gray-100 hover:text-gray-600 active:translate-y-0!" onClick={() => handleCopy(msg.content, `${msg.role}-${index}`)}>
                                    {copiedId === `${msg.role}-${index}` ? <Check className="h-3 w-3" /> : <Copy className="h-5! w-5!" />}
                                </Button>
                            </div>
                        </div>
                    )}
                </div>
            ))}
        </div>
    );
}
```

##### 2.2.6.3 会话聊天框相关

###### 2.2.6.3.1 会话聊天框组件

`/src/components/features/chat/chat-box/ChatBox.tsx`：

```tsx
"use client";

// ==================== 会话聊天框相关 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import ChatInput from "@/components/features/chat/chat-box/ChatInput";
import ChatDocUpload from "@/components/features/chat/chat-box/ChatDocUpload";
import ChatDocShow from "@/components/features/chat/chat-box/ChatDocShow";
import ChatModelSelector from "@/components/features/chat/chat-box/ChatModelSelector";
import ChatSendBtn from "@/components/features/chat/chat-box/ChatSendBtn";
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //

export default function ChatBox({ onSend, onAbort }: { onSend?: () => void; onAbort?: () => void }) {
    const chat = useChatStore((state) => state.chat);

    return (
        <div className={`${chat.docs.length ? "h-51" : "h-34"} flex w-full flex-col gap-1 rounded-4xl border border-gray-400 bg-white p-3 shadow-sm`}>
            <ChatDocShow />
            <ChatInput onSend={onSend} />
            <div className="flex items-center justify-between">
                <ChatModelSelector />
                <div className="flex items-center gap-3">
                    <ChatDocUpload />
                    <ChatSendBtn onSend={onSend} onAbort={onAbort} />
                </div>
            </div>
        </div>
    );
}

```
###### 2.2.6.3.2 输入框组件

`/src/components/features/chat/chat-box/ChatInput.tsx`：

```tsx
"use client";

// ==================== 输入框组件 ==================== //

// ========== React、Next、Utils ========== //
import { useRouter } from "next/navigation";
// ========== Components、CSS ========== //
import { Textarea } from "@/components/ui/textarea";
// ========== Icon、Type ========== //
import type { KeyboardEvent } from "react";
// ========== Stroe、Constants ========== //
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
import { HOME_CHAT_PROMPT, HOME_CHATING_PROMPT } from "@/lib/constants/app";
// ========== Hooks ========== //
// ========== Services ========== //
import { sessionService } from "@/services/sessionService";

export default function ChatInput({ onSend }: { onSend?: () => void }) {
    const currentSession = useSessionStore((state) => state.currentSession);
    const chat = useChatStore((state) => state.chat);
    const setChat = useChatStore((state) => state.setChat);
    const isChatLoading = useChatStore((state) => state.isLoading);
    const setIsAutoSend = useChatStore((state) => state.setIsAutoSend);

    const router = useRouter();

    // 输入框输入
    const setInput = (input: string) => {
        setChat({
            ...chat,
            content: input,
        });
    };

    // 输入框回车
    const handleInputKeyDown = async (e: KeyboardEvent<HTMLTextAreaElement>) => {
        if (e.key === "Enter" && !e.shiftKey && chat?.content.trim()) {
            e.preventDefault();
            const chat = useChatStore.getState().chat;

            if (!currentSession) {
                // 首页发送
                // 创建会话ID
                const { id } = (
                    await sessionService.createSession({
                        // 标题默认截取前 20 位
                        title: chat?.content.slice(0, 19),
                    })
                ).data;
                setIsAutoSend(true);
                // 跳转到会话页面组件
                router.push(`/chat/${id}`);
            } else {
                onSend?.();
            }
        }
    };

    return <Textarea className="w-full flex-1 resize-none border-0 outline-none focus-visible:ring-0 focus-visible:ring-offset-0" value={chat?.content || ""} onChange={(e) => setInput(e.target.value)} placeholder={isChatLoading ? HOME_CHATING_PROMPT : HOME_CHAT_PROMPT} disabled={isChatLoading} onKeyDown={(e) => handleInputKeyDown(e)} />;
}
```

###### 2.2.6.3.3 文件上传按钮组件

`/src/components/features/chat/chat-box/ChatDocUpload.tsx`：

```tsx
"use client";

// ==================== 文件上传按钮组件 ==================== //
// 支持 PDF/DOCX/TXT/MD 纯前端本地解析
// 文件限制最多3个，单文件 ≤ 100MB，自动校验大小/格式/空文件
// 内存安全，配合解析工具自动释放资源，无内存泄漏

// ========== React、Next、Utils ========== //
import { useRef } from "react";
// ========== Components、CSS ========== //
import { Button } from "@/components/ui/button";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
// ========== Icon、Type ========== //
import { Paperclip, LoaderCircle } from "lucide-react";
// ========== Stroe、Constants ========== //
import { useChatStore } from "@/store/useChatStore";
import { MAX_FILE_SIZE } from "@/lib/utils/universal-file-parser";
// ========== Hooks ========== //
import { useDocUpload } from "@/components/hooks/chat/useDocUpload";
// ========== Services ========== //

export default function ChatDocUpload() {
    const isSendLoading = useChatStore((state) => state.isLoading);
    const fileInputRef = useRef<HTMLInputElement>(null);
    const { handleFileUpload, isParsing, MAX_FILE_NUM } = useDocUpload();

    return (
        <>
            <input className="hidden" ref={fileInputRef} multiple type="file" accept=".pdf,.docx,.txt,.md" disabled={isParsing} onChange={handleFileUpload} />
            <Tooltip>
                <TooltipTrigger asChild>
                    <Button className="h-8 w-8 cursor-pointer rounded-full" variant="ghost" disabled={isParsing || isSendLoading} onClick={() => fileInputRef.current?.click()}>
                        {isParsing ? <LoaderCircle className="h-5! w-5! animate-spin" /> : <Paperclip className="h-5! w-5!" />}
                    </Button>
                </TooltipTrigger>

                <TooltipContent className="flex flex-col items-start">
                    <p>上传附件（仅识别文字）</p>
                    <p>
                        最多 {MAX_FILE_NUM} 个，每个 {(MAX_FILE_SIZE / 1024 / 1024).toFixed(0)} MB，支持 .txt、.md、.docx、.pdf 文本文件
                    </p>
                </TooltipContent>
            </Tooltip>
        </>
    );
}
```

###### 2.2.6.3.4 文件上传按钮 Hook 组件

`/src/components/hooks/chat/useDocUpload.tsx`：

```tsx
"use client";

// ==================== 文件上传按钮 Hook 组件 ==================== //

// ========== React、Next、Utils ========== //
import { useState } from "react";
import { v4 as uuidv4 } from "uuid";
import { formatFileSize } from "@/lib/utils/common-tools";
// 解析工具核心
import { browserParser, type ParseResult } from "@/lib/utils/universal-file-parser";
// ========== Components、CSS ========== //
import { toast } from "sonner";
// ========== Icon、Type ========== //
import type { Document } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //

export const useDocUpload = () => {
    const [isParsing, setIsParsing] = useState<boolean>(false);
    const setCommonModal = useCommonStore((state) => state.setCommonModal);
    const setChat = useChatStore((state) => state.setChat);
    const setIsDocUploaded = useChatStore((state) => state.setIsDocUploaded);

    // 最大文件上传数量
    const MAX_FILE_NUM = 5;

    // 文件上传处理
    const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const files = e.target.files;
        if (!files || files.length === 0) return;

        setIsParsing(true);
        setIsDocUploaded(false); // 发送按钮不能点击
        // toast.info("文件上传中，请稍等...");

        try {
            // 1. 仅校验文件数量（大小/格式/空文件 由解析工具内部统一校验）
            if (files.length > MAX_FILE_NUM || useChatStore.getState().chat.docs.length >= MAX_FILE_NUM) {
                toast.error(`文件上传失败，最多支持上传 ${MAX_FILE_NUM} 个文件`);
                return;
            }

            const successResults: ParseResult[] = [];
            const errorMap: Record<string, string> = {};

            // 2. 遍历所有文件，执行解析
            for (const file of files) {
                // 调用解析工具
                const result = await browserParser.parse(file);

                // 分类收集结果/错误
                if (result.success) {
                    successResults.push(result);
                } else {
                    errorMap[file.name] = result.error!;
                }
            }

            // 3. 更新到 会话请求状态 中
            setChat({
                ...useChatStore.getState().chat,
                docs: [
                    ...useChatStore.getState().chat.docs,
                    ...successResults.map((result: ParseResult) => {
                        const doc = {
                            id: uuidv4(),
                            fileName: result.file.name,
                            fileType: result.fileType,
                            sizeText: formatFileSize(result.file.size),
                            content: result.text,
                            uploadTime: new Date().toISOString(),
                        } as Document;
                        return doc;
                    }),
                ],
            });

            // 4. 有上传错误的文件，弹窗展示告知
            const errorNums = Object.keys(errorMap).length;
            if (errorNums) {
                toast.warning(`文件上传结束，${files.length - errorNums} 个上传成功，${errorNums} 个上传失败，请查看原因`);
                // 打开上传错误文件信息弹窗
                setCommonModal({
                    open: true,
                    title: "部分文件上传失败信息",
                    type: "error",
                    children: (
                        <div className="mt-2 w-full rounded-md border border-gray-200">
                            {/* 关键：table-layout:fixed 固定布局，强制适配容器宽度 */}
                            <table className="table-layout-fixed w-full border-collapse text-left text-sm">
                                {/* 表头 */}
                                <thead className="bg-gray-50 text-gray-700">
                                    <tr>
                                        <th className="w-2/5 px-3 py-2 font-medium">文件名</th>
                                        <th className="w-3/5 px-3 py-2 font-medium">错误信息</th>
                                    </tr>
                                </thead>

                                {/* 表体 */}
                                <tbody className="divide-y divide-gray-200">
                                    {Object.entries(errorMap).map(([fileName, errorMsg]) => (
                                        <tr key={fileName} className="bg-white transition-colors hover:bg-gray-50">
                                            {/* 文件名：移除截断，自动换行，长文本拆分 */}
                                            <td className="px-3 py-2 break-all whitespace-normal text-gray-900">{fileName}</td>
                                            {/* 错误信息：自动换行，红色高亮 */}
                                            <td className="px-3 py-2 break-all whitespace-normal text-red-500">{errorMsg}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    ),
                    confirmText: "确认",
                    showCancel: false,
                });
            } else {
                toast.success("文件上传完成");
            }
        } catch (err) {
            console.error("文件处理失败:", err);
            toast.error("文件处理失败，请重试");
        } finally {
            setIsParsing(false);
            setIsDocUploaded(true);
            e.target.value = "";
        }
    };

    return {
        handleFileUpload,
        isParsing,
        MAX_FILE_NUM,
    };
};
```

###### 2.2.6.3.5 文件列表展示组件

`/src/components/features/chat/chat-box/ChatDocShow.tsx`：

```tsx
"use client";

// ==================== 文件列表展示组件 ==================== //

// ========== React、Next、Utils ========== //
import { useEffect, useRef, useState } from "react";
import dayjs from "dayjs";
// ========== Components、CSS ========== //
import Image from "next/image";
import { Tooltip, TooltipContent, TooltipTrigger } from "@/components/ui/tooltip";
// ========== Icon、Type ========== //
import { X } from "lucide-react";
import type { Document } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //

export default function ChatDocShow({ messageDocs }: { messageDocs?: Document[] }) {
    const [docs, setDocs] = useState<Document[]>([]);
    const setPreviewDoc = useCommonStore((state) => state.setPreviewDoc);
    const setIsPreviewDocOpen = useCommonStore((state) => state.setIsPreviewDocOpen);
    const chat = useChatStore((state) => state.chat);
    const setChat = useChatStore((state) => state.setChat);
    const docShowRef = useRef<HTMLDivElement>(null);

    useEffect(() => {
        // 异步包裹 setState，彻底解决级联渲染报错
        Promise.resolve().then(() => {
            // 有 messageDocs 用它，没有就用 chat.docs，兜底空数组
            const finalDocs = messageDocs || chat?.docs || [];
            setDocs(finalDocs);
        });
    }, [messageDocs, chat]);

    // 滚动控制颠倒
    useEffect(() => {
        const el = docShowRef.current;
        if (el) {
            const handleWheel = (e: any) => {
                e.preventDefault();
                el.scrollLeft += e.deltaY;
            };
            el.addEventListener("wheel", handleWheel);
            return () => el.removeEventListener("wheel", handleWheel);
        }
    }, []);

    // 预览临时上传文档
    const previewTempDoc = (doc: Document) => {
        setPreviewDoc(doc);
        setIsPreviewDocOpen(true);
    };

    // 删除临时上传文件
    const removeTempDoc = (e: any, docId: string) => {
        e.stopPropagation();

        setChat({
            ...useChatStore.getState().chat,
            docs: useChatStore.getState().chat.docs.filter((doc: Document) => doc.id !== docId),
        });
    };

    return (
        <div className={`${!docs.length && "hidden"} flex max-w-full gap-2 overflow-x-auto pb-1`} ref={docShowRef}>
            {docs?.map((doc: Document) => (
                <Tooltip key={doc.id}>
                    <TooltipTrigger asChild>
                        <div className="relative flex w-46 cursor-pointer items-center justify-start gap-2 rounded-sm bg-gray-100 py-1 pr-5 pl-3" title="点击预览文件" onClick={() => previewTempDoc(doc)}>
                            <Image src={`/assets/images/fileIcons/${doc.fileType}.png`} alt="" width={18} height={18} priority />

                            <div className="flex min-w-0 flex-col">
                                <span className="truncate text-sm text-gray-900">{doc.fileName}</span>

                                <span className="text-xs text-gray-500">
                                    {doc.fileType} · {doc.sizeText}
                                </span>
                            </div>
                            {!messageDocs ? (
                                <>
                                    <div className="absolute top-1 right-1 cursor-pointer" onClick={(e) => removeTempDoc(e, doc.id)} title="删除文件">
                                        <X size={12} />
                                    </div>
                                </>
                            ) : (
                                <></>
                            )}
                        </div>
                    </TooltipTrigger>
                    <TooltipContent className="flex flex-col items-start gap-1">
                        <p>文件ID：{doc.id}</p>
                        <p>文件名：{doc.fileName}</p>
                        <p>类型：{doc.fileType}</p>
                        <p>大小：{doc.sizeText}</p>
                        {/* <p>上传时间：{dayjs(doc.uploadTime).fromNow()}</p> */}
                        <p>上传时间：{dayjs(doc.uploadTime).format("YYYY-MM-DD HH:mm")}</p>
                    </TooltipContent>
                </Tooltip>
            ))}
        </div>
    );
}
```

###### 2.2.6.3.6 模型选择组件

`/src/components/features/chat/chat-box/ChatModelSelector.tsx`：

```tsx
"use client";

// ==================== 模型选择组件 ==================== //

// ========== React、Next、Utils ========== //
import { useEffect } from "react";
// ========== Components、CSS ========== //
import Image from "next/image";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
// ========== Icon、Type ========== //
import type { Model } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
import { useModelStore } from "@/store/useModelStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //
import { useGetModelList } from "@/components/hooks/common/useSwrApi";

export default function ChatModelSelector() {
    const modelList = useModelStore((state) => state.modelList);
    const setModelList = useModelStore((state) => state.setModelList);
    const chat = useChatStore((state) => state.chat);
    const setChat = useChatStore((state) => state.setChat);

    const { fetchedModelList } = useGetModelList();

    // 模型自动赋值
    const setCurrentModelByChatData = () => {
        if (fetchedModelList?.length) {
            if (!chat.model) {
                // 无选中模型时，默认选中第一个
                setChat({ ...useChatStore.getState().chat, model: fetchedModelList[0].name });
            } else {
                const isExist = useModelStore.getState().modelList.some((model: Model) => model.name === chat.model);
                setChat({ ...useChatStore.getState().chat, model: isExist ? chat.model : fetchedModelList[0].name });
            }
        }
    };

    // 模型列表 状态存储
    useEffect(() => {
        if (!fetchedModelList) return;
        setModelList(fetchedModelList);
    }, [fetchedModelList]);

    useEffect(() => {
        setCurrentModelByChatData();
    }, [fetchedModelList, chat.model]);

    // 获取当前模型配置（本项目是开启了 React Compiler，会自动 useMemo/useCallback 优化）
    const getCurrentModelByChatData = (modelName: string): Model | undefined => {
        return modelList?.find((model: Model) => model.name === modelName);
    };

    return (
        <Select value={chat.model || ""} onValueChange={(name) => setChat({ ...chat, model: name })}>
            <SelectTrigger className="flex w-35 cursor-pointer items-center px-2 py-4" autoFocus={false}>
                <SelectValue>
                    <Image className="rounded-sm" src={chat.model ? `/assets/images/modelIcons/${chat.model}.png` : "/assets/images/logo.png"} alt="" width={24} height={24} priority />
                    <span className="font-medium text-gray-900">{getCurrentModelByChatData(chat.model)?.label}</span>
                </SelectValue>
            </SelectTrigger>

            <SelectContent className="w-60 px-1" position="popper" side="top" sideOffset={0} align="start" alignOffset={0} autoFocus={false}>
                {modelList?.map((model) => (
                    <SelectItem className="m-1 cursor-pointer px-5 py-2" key={model.name} value={model.name || ""}>
                        <div className="mr-4 flex w-full items-start gap-2">
                            <Image className="mt-1 rounded-sm" src={chat.model ? `/assets/images/modelIcons/${model.name}.png` : "/assets/images/logo.png"} alt="" width={24} height={24} priority />
                            <div className="flex flex-col">
                                <span className="flex h-6 items-center font-medium text-gray-900">{model.label}</span>
                                <span className="text-xs text-gray-500!">{model.description}</span>
                            </div>
                        </div>
                    </SelectItem>
                ))}
            </SelectContent>
        </Select>
    );
}
```

###### 2.2.6.3.7 发送按钮组件

`/src/components/features/chat/chat-box/ChatSendBtn.tsx`：

```tsx
"use client";

// ==================== 发送按钮组件 ==================== //

// ========== React、Next、Utils ========== //
import { useRouter } from "next/navigation";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import { LoaderCircle, Send } from "lucide-react";
// ========== Stroe、Constants ========== //
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //
import { sessionService } from "@/services/sessionService";

export default function ChatSendBtn({ onSend, onAbort }: { onSend?: () => void; onAbort?: () => void }) {
    const currentSession = useSessionStore((state) => state.currentSession);
    const chat = useChatStore((state) => state.chat);
    const isDocUploaded = useChatStore((state) => state.isDocUploaded);
    const isSendLoading = useChatStore((state) => state.isLoading);
    const setIsAutoSend = useChatStore((state) => state.setIsAutoSend);

    const router = useRouter();

    // 处理请求发送
    const handleSend = async (): Promise<void> => {
        const chat = useChatStore.getState().chat;

        if (!currentSession) {
            // 首页发送
            // 创建会话ID
            const { id } = (
                await sessionService.createSession({
                    // 标题默认截取前 20 位
                    title: chat?.content.slice(0, 19),
                })
            ).data;
            // 跳转到会话页面组件
            setIsAutoSend(true);
            router.push(`/chat/${id}`);
        } else {
            onSend?.();
        }
    };

    return (
        <>
            {isSendLoading ? (
                <div className="flex h-8 w-8 cursor-pointer items-center justify-center rounded-full bg-red-500 text-white shadow-lg transition-all duration-200 hover:bg-red-600 hover:shadow-red-500/30 active:scale-95" onClick={onAbort}>
                    <LoaderCircle className="h-4 w-4 animate-spin" />
                </div>
            ) : !chat.content.trim() || !isDocUploaded ? (
                <div className="flex h-8 w-8 cursor-not-allowed items-center justify-center rounded-full bg-gray-300 text-gray-500 shadow-lg transition-all duration-200">
                    <Send className="h-4 w-4" />
                </div>
            ) : (
                <div className="flex h-8 w-8 cursor-pointer items-center justify-center rounded-full bg-[#052658] text-white shadow-lg transition-all duration-200 hover:bg-[#063272] hover:shadow-[#052658]/30 active:scale-95" onClick={handleSend}>
                    <Send className="h-4 w-4" />
                </div>
            )}
        </>
    );
}
```

##### 2.2.6.4 前端文档解析工具封装

```shell
pnpm install mammoth pdfjs-dist

```

`/src/lib/utils/universalFileParser.ts`：

```ts
"use client";

// ==================== 前端文档解析工具 ==================== //

// ========== React、Next、Utils ========== //
// 依赖 mammoth pdfjs-dist，这里是动态导入，所以你需要提前安装
// `pnpm install mammoth pdfjs-dist`
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

export interface ParseProgress {
    progress: number;
}

export interface ParseResult {
    text: string;
    fileType: string;
    file: File;
    success: boolean;
    error?: string;
}

export const MAX_FILE_SIZE = 10 * 1024 * 1024;
export const ALLOWED_EXTENSIONS = [".txt", ".md", ".pdf", ".docx"] as const;
export const ALLOWED_MIME_TYPES = ["text/plain", "text/markdown", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/pdf"];
export const ERROR_MESSAGES = {
    FILE_TOO_LARGE: `文件大小超出限制，最大支持 ${(MAX_FILE_SIZE / 1024 / 1024).toFixed(0)} MB`, // TXT、MD、DOCX、PDF
    INVALID_TYPE: "不支持的文件格式，请上传 .txt、.md、.docx、.pdf 文件", // TXT、MD、DOCX、PDF
    EMPTY_FILE: "文件内容为空，无法提取文本", // TXT、MD、DOCX、PDF
    NO_EXTRACTED_TEXT: "文件解析完成，但未提取到有效文本", // TXT、MD、DOCX、PDF
    PARSE_FAILED: "文件解析失败，请检查文件完整性", // TXT、MD
    CORRUPTED_FILE: "文件已损坏或格式错误", // DOCX、PDF
    ENCRYPTED_PDF: "PDF 文件已加密，无法解析", // PDF
} as const;

class UniversalFileParser {
    private isPdfInitialized = false;

    constructor() {
        if (typeof window !== "undefined") this.initPdfParser();
    }

    /**
     * pdfjs-dist 解析包初始化
     * 提前准备：需要把 `/node_modules/pdfjs-dist/build/pdf.worker.min.mjs` 复制到 `/assets/pdf-worker/` 下
     */
    private initPdfParser = async () => {
        if (this.isPdfInitialized) return;
        try {
            const pdfjs = await import("pdfjs-dist");
            // 直接使用你项目里的本地静态文件路径
            pdfjs.GlobalWorkerOptions.workerSrc = "/assets/pdf-worker/pdf.worker.min.mjs";
            this.isPdfInitialized = true;
        } catch (error) {
            throw new Error(`pdfjs-dist 解析包初始化失败: ${(error as Error).message}`);
        }
    };

    // 文件校验：文件大小、文件类型、文件内容非空
    private validateFile = (file: File): string | null => {
        if (file.size > MAX_FILE_SIZE) return ERROR_MESSAGES.FILE_TOO_LARGE;
        const fileName = file.name.toLowerCase();
        const isValidExt = ALLOWED_EXTENSIONS.some((ext) => fileName.endsWith(ext));
        const isValidMime = ALLOWED_MIME_TYPES.includes(file.type);
        if (!isValidExt && !isValidMime) return ERROR_MESSAGES.INVALID_TYPE;
        if (file.size === 0) return ERROR_MESSAGES.EMPTY_FILE;
        return null;
    };

    // 解析 TXT / MD
    private parseText = async (file: File): Promise<string> => {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.readAsText(file, "UTF-8");
            reader.onerror = () => reject(ERROR_MESSAGES.PARSE_FAILED);
            reader.onload = (e) => {
                const text = e.target?.result as string;
                text.trim() ? resolve(text) : reject(ERROR_MESSAGES.NO_EXTRACTED_TEXT);
            };
        });
    };

    // 解析 DOCX
    private parseDocx = async (file: File): Promise<string> => {
        try {
            const mammoth = await import("mammoth");
            const arrayBuffer = await file.arrayBuffer();
            const result = await mammoth.extractRawText({ arrayBuffer });
            if (result.value.trim()) {
                return result.value.trim();
            } else {
                throw new Error(ERROR_MESSAGES.NO_EXTRACTED_TEXT);
            }
        } catch {
            throw new Error(ERROR_MESSAGES.CORRUPTED_FILE);
        }
    };

    // 解析 PDF（纯本地、带进度、内存安全）
    private parsePdf = async (file: File, onProgress?: (progress: ParseProgress) => void): Promise<string> => {
        if (!this.isPdfInitialized) await this.initPdfParser();
        const pdfjs = await import("pdfjs-dist");
        const arrayBuffer = await file.arrayBuffer();
        let pdfInstance = null;

        try {
            pdfInstance = await pdfjs.getDocument({ data: arrayBuffer }).promise;
            const totalPages = pdfInstance.numPages;
            let fullText = "";

            for (let i = 1; i <= totalPages; i++) {
                const page = await pdfInstance.getPage(i);
                const content = await page.getTextContent();
                const pageText = content.items.map((item: any) => item.str).join(" ");
                fullText += pageText + "\n";
                onProgress?.({ progress: i / totalPages });
            }
            if (fullText.trim()) {
                return fullText.trim();
            } else {
                throw new Error(ERROR_MESSAGES.NO_EXTRACTED_TEXT);
            }
        } catch (err) {
            if ((err as Error).message.includes("password")) throw new Error(ERROR_MESSAGES.ENCRYPTED_PDF);
            throw new Error(ERROR_MESSAGES.CORRUPTED_FILE);
        } finally {
            if (pdfInstance) pdfInstance.destroy();
        }
    };

    // 统一解析入口
    parse = async (file: File, onProgress?: (progress: ParseProgress) => void): Promise<ParseResult> => {
        try {
            const validateError = this.validateFile(file);
            if (validateError) return { text: "", fileType: "", file, success: false, error: validateError };

            const fileName = file.name.toLowerCase();
            let text = "";
            let fileType = "";
            if (fileName.endsWith(".txt") || fileName.endsWith(".md")) {
                text = await this.parseText(file);
                if (fileName.endsWith(".txt")) {
                    fileType = "txt";
                } else {
                    fileType = "md";
                }
            } else if (fileName.endsWith(".docx")) {
                text = await this.parseDocx(file);
                fileType = "docx";
            } else if (fileName.endsWith(".pdf")) {
                text = await this.parsePdf(file, onProgress);
                fileType = "pdf";
            }

            return { text, fileType, file, success: true };
        } catch (err: any) {
            return { text: "", fileType: "", file, success: false, error: err.message || ERROR_MESSAGES.PARSE_FAILED };
        }
    };
}

export const browserParser = new UniversalFileParser();
```


#### 2.2.7 页面相关

##### 2.2.7.1 首页页面组件


`/src/app/page.tsx`：

```tsx
"use client";

// ==================== 首页页面组件 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import Image from "next/image";
import CommonLayout from "@/components/layouts/CommonLayout";
import ChatTitle from "@/components/features/chat/chat-title/ChatTitle";
import ChatBox from "@/components/features/chat/chat-box/ChatBox";
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { HOME_CHAT_TITLE } from "@/lib/constants/app";
// ========== Hooks ========== //
// ========== Services ========== //

export default function Home() {
    const collapsed = useCommonStore((state) => state.collapsed);

    return (
        <CommonLayout>
            <div className={`${collapsed ? "md:max-w-220" : "md:max-w-3xl"} flex h-full w-full flex-col md:justify-center`}>
                <div className="fixed top-0 w-full">
                    <ChatTitle />
                </div>

                <div className="-mt-16 flex h-full w-full items-center justify-center gap-4 md:mb-6 md:h-auto">
                    <Image className="rounded-sm" src="/assets/images/logo.png" alt="T.AI" width={46} height={46} priority />
                    <h3 className="text-xl font-medium text-[#052658]">{HOME_CHAT_TITLE}</h3>
                </div>

                <div className="fixed bottom-0 w-full px-3 py-5 md:relative">
                    <ChatBox />
                </div>
            </div>
        </CommonLayout>
    );
}

```

##### 2.2.7.2 会话页面组件

`/src/app/chat/page.tsx`：

```tsx
"use client";

// ==================== 会话页面组件 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import CommonLayout from "@/components/layouts/CommonLayout";
import ChatTitle from "@/components/features/chat/chat-title/ChatTitle";
import ChatContent from "@/components/features/chat/chat-content/ChatContent";
import ChatBox from "@/components/features/chat/chat-box/ChatBox";
// ========== Icon、Type ========== //
import type { Chat } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
import { useCommonStore } from "@/store/useCommonStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
import { useChat } from "@/components/hooks/chat/useChat";
// ========== Services ========== //

export default function Chat() {
    const collapsed = useCommonStore((state) => state.collapsed);
    const chat = useChatStore((state) => state.chat);

    const { sendChatMessage, abortChatRequest } = useChat();

    return (
        <CommonLayout>
            <div className={`${collapsed ? "md:max-w-242" : "md:max-w-3xl"} flex h-full w-full flex-col`}>
                <div className={`${collapsed ? "md:max-w-242" : "md:max-w-3xl"} fixed top-0 z-30! w-full md:my-auto`}>
                    <ChatTitle />
                    <div className="pointer-events-none h-3 w-full bg-linear-to-b from-white to-transparent" />
                </div>
                <div className={`${chat.docs.length ? "pb-67" : "pb-50"} z-10! w-full pt-20`}>
                    <ChatContent />
                </div>
                <div className={`${collapsed ? "md:max-w-242" : "md:max-w-3xl"} fixed bottom-0 z-30! flex w-full justify-center bg-white px-3 py-5 md:my-auto md:px-0`}>
                    <div className="pointer-events-none absolute -top-5 left-0 h-5 w-full bg-linear-to-t from-white to-transparent" />
                    <ChatBox onSend={sendChatMessage} onAbort={abortChatRequest} />
                </div>
            </div>
        </CommonLayout>
    );
}
```

###### 2.2.7.2.1 会话页面 Hook 组件

`/src/components/hooks/chat/useChat.tsx`：

```tsx
"use client";

// ==================== 会话页面 Hook 组件 ==================== //

// ========== React、Next、Utils ========== //
import { useEffect, useRef, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { v4 as uuidv4 } from "uuid";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { Chat, ChatHistory, Message } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
import { useSessionStore } from "@/store/useSessionStore";
import { useChatStore } from "@/store/useChatStore";
// ========== Hooks ========== //
// ========== Services ========== //
import { sessionService } from "@/services/sessionService";
import { chatService } from "@/services/chatService";

export const useChat = () => {
    const setCurrentSession = useSessionStore((state) => state.setCurrentSession);
    const isAutoSend = useChatStore((state) => state.isAutoSend);
    const setIsAutoSend = useChatStore((state) => state.setIsAutoSend);
    const setIsLoading = useChatStore((state) => state.setIsLoading);
    const setChat = useChatStore((state) => state.setChat);
    const resetChat = useChatStore((state) => state.resetChat);

    // 标记会话是否初始化完成
    const [isSessionInitialized, setIsSessionInitialized] = useState(false);
    const router = useRouter();
    // 用于中断请求的控制器 Ref（持久化存储，避免重渲染丢失）
    const abortControllerRef = useRef<AbortController | null>(null);
    const timerRef = useRef<NodeJS.Timeout[]>([]);

    // 从路由参数获取会话ID
    const params = useParams<{ sessionId: string }>();
    const sessionId = params.sessionId;

    // 清理所有定时器（防止内存泄漏）
    const clearAllTimers = () => {
        timerRef.current.forEach((timer) => clearTimeout(timer));
        timerRef.current = [];
    };

    // 初始化会话
    const initSession = async () => {
        try {
            // 从服务端获取会话详情
            const res = await sessionService.getSession(sessionId);
            setCurrentSession(res.data);
            setIsSessionInitialized(true); // 标记会话初始化完成

            // 模型赋值
            if (res.data.messages?.length) {
                // 优先选最后一条消息的模型
                const modelName = res.data.messages.slice(-1)[0].model;
                setChat({ ...useChatStore.getState().chat, model: modelName });
            }

            // 自动发送消息
            if (isAutoSend) {
                sendChatMessage();
            }
        } catch (error) {
            console.log("获取会话信息失败：", error);
            // 会话不存在时跳转到首页
            router.push("/");
            resetChat();
            setCurrentSession(null);
        }
    };

    // 中止请求
    const abortChatRequest = () => {
        const controller = abortControllerRef.current;
        if (controller && !controller.signal.aborted) {
            controller.abort();
        }
    };

    // 组件挂载时初始化会话
    useEffect(() => {
        if (!sessionId) return;
        initSession();
    }, []);

    // 组件卸载时中止所有未完成的请求
    useEffect(() => {
        return () => {
            abortChatRequest();
            clearAllTimers();
        };
    }, []);

    // 自动发送会话，首页跳转和重试场景使用，确保在会话初始化完成后发送，否者消息显示会重置
    useEffect(() => {
        if (isAutoSend && isSessionInitialized) {
            sendChatMessage();
        }
    }, [isAutoSend, isSessionInitialized]);

    // 发送聊天消息
    const sendChatMessage = async () => {
        // 清理旧请求：保证同一时间只有一个请求在执行
        if (abortControllerRef.current) {
            abortControllerRef.current.abort();
            abortControllerRef.current = null;
        }

        try {
            // 关闭自动发送开关（避免重复触发，这个开关主要是用于首页跳转的请求和重试功能）
            setIsAutoSend(false);
            // 创建新的中断控制器，用于本次请求
            const abortController = new AbortController();
            abortControllerRef.current = abortController;

            // 组装请求参数：从状态库获取当前会话和聊天配置
            let currentSession = useSessionStore.getState().currentSession;
            const chat = useChatStore.getState().chat;
            const chatParams: Chat = {
                ...chat,
                id: sessionId,
                // 转换会话消息为接口要求的格式
                chatHistorys:
                    currentSession?.messages?.map(
                        (msg) =>
                            ({
                                role: msg.role.trim(),
                                content: msg.content.trim(),
                            }) as ChatHistory,
                    ) || [],
                // 判断是否有文档关联的历史消息
                hasDocHistorys: !!currentSession?.messages?.some((item) => item.docs?.length > 0),
            };

            // 用户问题 UI 显示，异步保存
            const userMessage: Message = {
                id: uuidv4(),
                role: "user",
                model: chat.model,
                content: chat.content,
                createTime: new Date().toISOString(),
                docs: chat.docs,
            };

            if (currentSession) {
                setCurrentSession({
                    ...currentSession,
                    messages: [...(currentSession.messages || []), userMessage],
                });
                // 更新消息到服务端
                sessionService.updateSessionMessage(sessionId, { message: userMessage });
            }

            // AI回复 UI 显示，内容暂时为空
            currentSession = useSessionStore.getState().currentSession;
            const assistantMessage: Message = {
                id: uuidv4(),
                role: "assistant",
                model: chat.model,
                content: "", // 初始为空，后续流式填充
                createTime: new Date().toISOString(),
                docs: [],
            };
            if (currentSession) {
                setCurrentSession({
                    ...currentSession,
                    messages: [...(currentSession.messages || []), assistantMessage],
                });
            }

            // 流式返回读写器
            let reader: ReadableStreamDefaultReader<Uint8Array> | null = null;

            // 中止时的处理函数：取消流读取（等于告诉后端中断），主动保存已生成的AI消息
            const handleAbort = async () => {
                if (reader) {
                    reader?.cancel();
                }
                // 取到AI回复的内容，加上终止信息，更新会话消息到服务器
                currentSession = useSessionStore.getState().currentSession;
                const allMessages = currentSession?.messages;
                const lastMessage = allMessages!.at(-1);
                // 添加终止信息
                let abortMessage = "[已中止]";
                if (lastMessage!.content) {
                    abortMessage = "...\n\n" + abortMessage;
                }

                if (currentSession) {
                    setCurrentSession({
                        ...currentSession,
                        messages: currentSession.messages?.map((item, idx, arr) =>
                            // 只更新最后一条（AI回复）的内容
                            idx === arr.length - 1 ? { ...item, content: item.content + abortMessage } : item,
                        ),
                    });
                }

                // 更新会话消息到服务端
                lastMessage!.content += abortMessage;
                if (lastMessage && chatParams.id) {
                    sessionService.updateSessionMessage(chatParams.id, { message: lastMessage });
                }
            };

            // 监听中止信号，触发流取消逻辑
            abortController.signal.addEventListener("abort", handleAbort);

            // 重置聊天输入状态，发送按钮标记加载中
            resetChat(chat.model);
            // 延迟500ms，确保请求以生成
            const timer = setTimeout(() => {
                setIsLoading(true);
            }, 500);
            timerRef.current.push(timer);

            // 发送请求：调用聊天服务，传入中断信号
            const res = await chatService.sendChat({
                chatParams: chatParams,
                signal: abortController.signal,
            });

            // 处理流式返回：逐段读取AI回复并更新UI
            reader = res.body.getReader();
            // 解码二进制流为字符串
            const decoder = new TextDecoder("utf-8");

            // 循环读取流式数据
            while (true) {
                // 若请求已中止，直接退出循环
                if (abortController.signal.aborted) break;

                try {
                    const { done, value } = await reader!.read();
                    // 流读取完成或请求中止，退出循环
                    if (done || abortController.signal.aborted) break;

                    // 实时更新AI回复内容（只修改最后一条AI消息）
                    currentSession = useSessionStore.getState().currentSession;
                    if (currentSession) {
                        setCurrentSession({
                            ...currentSession,
                            messages: currentSession.messages?.map((item, idx, arr) =>
                                // 只更新最后一条（AI回复）的内容
                                idx === arr.length - 1 ? { ...item, content: item.content + decoder.decode(value) } : item,
                            ),
                        });
                    }
                } catch (readError) {
                    console.error("流式读取异常：", readError);
                    break;
                }
            }

            // 清理中止监听事件
            abortController.signal.removeEventListener("abort", handleAbort);
        } catch (error) {
            // 忽略主动中止的错误，仅打印其他异常
            if (error instanceof DOMException && error.name === "AbortError") {
                console.log("聊天请求已主动中止");
            } else {
                console.error("发送聊天消息失败：", error);
            }
        } finally {
            // 无论成功/失败，都标记加载结束，清理控制器
            setIsLoading(false);
            abortControllerRef.current = null;
        }
    };

    // 返回给组件的方法
    return {
        sendChatMessage, // 发送消息方法
        abortChatRequest, // 中止请求方法
        sessionId, // 当前会话ID
    };
};
```

#### 2.2.8 通用工具

`/src/lib/utils/common-tools.ts`：


```tsx
// ==================== 通用工具 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
import { toast } from "sonner";
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

// 文件大小单位转换：B → KB → MB
export const formatFileSize = (bytes: number): string => {
    if (bytes < 1024) return bytes + " B";
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + " KB";
    return (bytes / (1024 * 1024)).toFixed(1) + " MB";
};

// 复制文本到剪贴板
export const copyToClipboard = async (text: string) => {
    try {
        // 尝试使用 Clipboard API
        if (navigator.clipboard && navigator.clipboard.writeText) {
            await navigator.clipboard.writeText(text);
            toast.success("复制成功");
        } else {
            // 降级方案：创建临时输入框并复制
            const textArea = document.createElement("textarea");
            textArea.value = text;
            textArea.style.position = "fixed";
            textArea.style.left = "-999999px";
            textArea.style.top = "-999999px";
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();

            try {
                document.execCommand("copy");
                toast.success("复制成功");
            } catch (err) {
                console.error("复制失败:", err);
                toast.error("复制失败");
            } finally {
                document.body.removeChild(textArea);
            }
        }
    } catch (error) {
        console.error("复制失败:", error);
        toast.error("复制失败");
    }
};
```


### 2.3 数据管理

#### 2.3.1 安装依赖

```shell
pnpm install zustand swr
```

#### 2.3.2 客户端全局应用常量

`/src/lib/constants/app.ts`：

```ts
// ==================== 客户端全局应用常量 ==================== //

// 首页聊天框标题
export const HOME_CHAT_TITLE = "今天有什么可以帮到你？";
// 首页聊天框提示语
export const HOME_CHAT_PROMPT = "给 T.AI 发送消息";
export const HOME_CHATING_PROMPT = "稍等，T.AI 正在思考中...";
// 前端接口请求默认配置
export const FETCH_CONFIG = {
    TIMEOUT: 600000, // 客户端请求默认超时时间
    PREFIX: "/api", // 接口请求前缀
    BFF_PREFIX: "/api", // BFF接口请求前缀
};
```

#### 2.3.3 客户端全局 TS 类型

`/src/lib/types/app.d.ts`：

```ts
// ==================== 客户端全局TS类型 ==================== //

// 模型类型
export interface Model {
    name?: string;
    label?: string;
    description?: string;
    apiKeyKey?: string;
    chatApiUrl?: string;
    parserType?: string;
    requestOptions?: string;
    enabled?: number;
}

// 会话类型
export interface Session {
    id: string;
    title: string;
    createTime: string;
    messages: Message[];
}

// 对话消息类型
export interface Message {
    id: string;
    role: "user" | "assistant";
    model: string;
    content: string;
    createTime: string;
    docs: Document[];
}

// 文档类型
export interface Document {
    id: string;
    fileName: string;
    fileType: string;
    sizeText: string;
    content: string;
    uploadTime: string;
}

// 会话请求类型
export interface Chat {
    id: string;
    model: string;
    content: string;
    chatHistorys: ChatHistory[];
    docs: Document[];
    hasDocHistorys: boolean;
}

// 对话历史类型
export interface ChatHistory {
    role: "user" | "assistant";
    content: string;
}
```

#### 2.3.4 状态封装

##### 2.3.4.1 通用状态

`/src/store/useCommonStore.ts`：

```ts
"use client";

// ==================== 通用状态 ==================== //

// ========== React、Next、Utils ========== //
import { create } from "zustand";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { ModalType, CommonModalProps } from "@/components/features/common/CommonModal";
import type { Document } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

interface CommonStore {
    // 侧边栏
    collapsed: boolean;
    isSidebarMobileOpen: boolean;
    setCollapsed: (collapsed: boolean) => void;
    setIsSidebarMobileOpen: (collapsed: boolean) => void;
    // 通用弹窗
    commonModal: CommonModalProps;
    setCommonModal: (commonModal: CommonModalProps) => void;
    resetCommonModal: () => void;
    // 文档预览
    previewDoc: Document | null;
    isPreviewDocOpen: boolean;
    setPreviewDoc: (previewDoc: Document | null) => void;
    setIsPreviewDocOpen: (isPreviewDocOpen: boolean) => void;
}

const initialState = {
    // 侧边栏
    collapsed: false,
    isSidebarMobileOpen: false,
    // 通用弹窗
    commonModal: {
        open: false,
        onOpenChange: null,
        type: "info" as ModalType,
        title: "",
        description: "",
        children: null,
        confirmText: "确定",
        cancelText: "取消",
        showCancel: true,
        confirmLoading: false,
        onConfirm: null,
        onCancel: null,
    },
    // 文档预览
    previewDoc: null,
    isPreviewDocOpen: false,
};

export const useCommonStore = create<CommonStore>((set) => ({
    ...initialState,
    // 侧边栏
    setCollapsed: (collapsed: boolean) => set({ collapsed: collapsed }),
    setIsSidebarMobileOpen: (isSidebarMobileOpen: boolean) => set({ isSidebarMobileOpen: isSidebarMobileOpen }),
    // 通用弹窗
    setCommonModal: (commonModal: CommonModalProps) => set({ commonModal: commonModal }),
    resetCommonModal: () => set({ commonModal: initialState.commonModal }),
    // 文档预览
    setPreviewDoc: (previewDoc: Document | null) => set({ previewDoc: previewDoc }),
    setIsPreviewDocOpen: (isPreviewDocOpen: boolean) => set({ isPreviewDocOpen: isPreviewDocOpen }),
}));
``` 

##### 2.3.4.2 模型状态

`/src/store/useModelStore.ts`：

```ts
"use client";

// ==================== 模型状态 ==================== //

// ========== React、Next、Utils ========== //
import { create } from "zustand";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { Model } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

interface ModelStore {
    modelList: Model[];
    setModelList: (modelList: Model[]) => void;
}

const initialState = {
    modelList: [],
};

export const useModelStore = create<ModelStore>((set) => ({
    ...initialState,
    setModelList: (modelList: Model[]) => set({ modelList: modelList }),
}));
```

##### 2.3.4.3 会话状态

`/src/store/useSessionStore.ts`：

```ts
"use client";

// ==================== 会话状态 ==================== //

// ========== React、Next、Utils ========== //
import { create } from "zustand";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { Session } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

interface SessionStore {
    // 会话列表
    sessionList: Session[];
    setSessionList: (sessionList: Session[]) => void;
    // 当前会话详情
    currentSession: Session | null;
    setCurrentSession: (collacurrentSessionpsed: Session | null) => void;
    // 会话重命名
    editId: string;
    setEditId: (editId: string) => void;
    editName: string;
    setEditName: (editName: string) => void;
    resetEdit: () => void;
}

const initialState = {
    // 会话列表
    sessionList: [],
    // 当前会话详情
    currentSession: null,
    // 会话重命名
    editId: "",
    editName: "",
};

export const useSessionStore = create<SessionStore>((set) => ({
    ...initialState,
    // 会话列表
    setSessionList: (sessionList: Session[]) => set({ sessionList: sessionList }),
    // 当前会话详情
    setCurrentSession: (currentSession: Session | null) => set({ currentSession: currentSession }),
    // 会话重命名
    setEditId: (editId: string) => set({ editId: editId }),
    setEditName: (editName: string) => set({ editName: editName }),
    resetEdit: () => set({ editId: "", editName: "" }),
}));
```

##### 2.3.4.4 会话请求状态

`/src/store/useChatStore.ts`：

```ts
"use client";

// ==================== 会话请求状态 ==================== //

// ========== React、Next、Utils ========== //
import { create } from "zustand";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { Chat } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

interface ChatStore {
    chat: Chat;
    setChat: (chat: Chat) => void;
    isDocUploaded: boolean;
    setIsDocUploaded: (isDocUploaded: boolean) => void;
    isAutoSend: boolean; // 是否自动发送，首页过来需要设置 true
    setIsAutoSend: (isAutoSend: boolean) => void;
    resetChat: (model?: string) => void;
    isLoading: boolean;
    setIsLoading: (isLoading: boolean) => void;
    error: string;
}

const initialState = {
    chat: {
        id: "",
        model: "",
        content: "",
        chatHistorys: [],
        docs: [],
        hasDocHistorys: false,
    },
    isDocUploaded: true,
    isAutoSend: false,
    isLoading: false,
    error: "",
};

export const useChatStore = create<ChatStore>((set) => ({
    ...initialState,
    setChat: (chat: Chat) => set({ chat: chat }),
    setIsDocUploaded: (isDocUploaded: boolean) => set({ isDocUploaded: isDocUploaded }),
    setIsAutoSend: (isAutoSend: boolean) => set({ isAutoSend: isAutoSend }),
    setIsLoading: (isLoading: boolean) => set({ isLoading: isLoading }),
    resetChat: (model?: string) =>
        set({
            ...initialState,
            chat: {
                id: "",
                model: model || "",
                content: "",
                chatHistorys: [],
                docs: [],
                hasDocHistorys: false,
            },
        }),
}));
```

#### 2.3.5 客户端请求工具封装

`/src/lib/utils/request.ts`：

```ts
"use client";

// ==================== 客户端请求工具封装（提供超时，重试等功能，兼容 后端接口 和 Next BFF 接口） ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
import { FETCH_CONFIG } from "@/lib/constants/app";
// ========== Hooks ========== //
// ========== Services ========== //

type FetchClientOptions = Omit<RequestInit, "body"> & {
    body?: Record<string, any>;
    timeout?: number;
    isBFF?: boolean;
    signal?: AbortSignal;
};

export async function request(
    path: string, // 接口路径，不带域名、前缀
    options: FetchClientOptions = {},
): Promise<any> {
    const {
        timeout = FETCH_CONFIG.TIMEOUT,
        isBFF = false, // 默认走正常后端接口
        signal = null,
        body,
        headers = {},
        ...restOptions
    } = options;

    const url = !isBFF ? `${process.env.NEXT_PUBLIC_API_BASE_URL}${FETCH_CONFIG.PREFIX}${path}` : `${FETCH_CONFIG.BFF_PREFIX}${path}`;

    // 封装超时逻辑
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeout);

    try {
        const res = await fetch(url, {
            ...restOptions,
            headers: {
                "Content-Type": "application/json",
                ...headers,
            },
            body: body ? JSON.stringify(body) : undefined,
            signal: signal ? signal : controller.signal,
        });

        if (!res.ok) throw new Error(`请求失败：${res.status} ${res.statusText}`);

        return res;
    } catch (error) {
        throw new Error((error as Error).message);
    } finally {
        clearTimeout(timeoutId);
    }
}
```


#### 2.3.6 客户端服务层封装

##### 2.3.6.1 模型列表服务层

`/src/services/modelService.ts`：

```ts
"use client";

// ==================== 模型列表服务层 ==================== //

// ========== React、Next、Utils ========== //
import { request } from "@/lib/utils/request";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

export const modelService = {
    // 获取模型列表
    async getModel(id: string): Promise<any> {
        return (await request(`/model?id=${id || ""}`)).json();
    },
    // 获取模型
    async getModelList(): Promise<any> {
        return (await request(`/model`)).json();
    },
};
```

##### 2.3.6.2 会话列表服务层


`/src/services/sessionService.ts`：

```ts
"use client";

// ==================== 会话列表服务层 ==================== //

// ========== React、Next、Utils ========== //
import { request } from "@/lib/utils/request";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { Message } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

export const sessionService = {
    // 新增会话
    async createSession(data: { title: string }): Promise<any> {
        return (await request(`/session`, { method: "POST", body: data })).json();
    },
    // 删除会话
    async deleteSession(id: string): Promise<any> {
        return (await request(`/session?id=${id}`, { method: "DELETE" })).json();
    },
    // 更新会话 （重命名）
    async updateSession(id: string, data: { title: string }): Promise<any> {
        return (await request(`/session?id=${id}`, { method: "PATCH", body: data })).json();
    },
    // 更新会话（新增会话聊天数据）
    async updateSessionMessage(id: string, data: { message: Message }): Promise<any> {
        return (await request(`/session?id=${id}`, { method: "PATCH", body: data })).json();
    },
    // 获取单个会话
    async getSession(id: string): Promise<any> {
        return (await request(`/session?id=${id || ""}`)).json();
    },
    // 获取会话列表
    async getSessionList(): Promise<any> {
        return (await request(`/session`)).json();
    },
};
```


##### 2.3.6.3 会话请求服务层

`/src/services/chatService.ts`：

```ts
"use client";

// ==================== 会话请求服务层 ==================== //

// ========== React、Next、Utils ========== //
import { request } from "@/lib/utils/request";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { Chat } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

export const chatService = {
    // 发送会话
    async sendChat(data: { chatParams: Chat; signal: AbortSignal }): Promise<any> {
        return await request(`/chat`, { method: "POST", body: data });
    },
};
```

#### 2.3.7 SWR Hook 组件

`/src/components/hooks/common/useSwrApi.ts`：

```ts
"use client";

// ==================== SWR Hook 组件 ==================== //

// ========== React、Next、Utils ========== //
import useSWR from "swr";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //
import { modelService } from "@/services/modelService";
import { sessionService } from "@/services/sessionService";

// 基础配置
const SWR_CONFIG = {
    revalidateOnReconnect: true, // 网络恢复重新请求
    shouldRetryOnError: true, // 失败自动重试
    errorRetryCount: 3, // 失败自动重试次数
    errorRetryInterval: 1000, // 失败重试间隔时间（毫秒）
    dedupingInterval: 2000, // 2秒内相同请求自动去重（避免重复调用接口）
    revalidateOnFocus: false, // 切回页面不重新请求
    refreshInterval: 0, // 关闭自动轮询
};

// 获取模型列表
export function useGetModelList() {
    const { data, error, isLoading } = useSWR(
        "/model/getList",
        async () => {
            return (await modelService.getModelList()).data;
        },
        {
            ...SWR_CONFIG,
            // revalidateOnFocus: true, // 切回页面重新请求
            fallbackData: [], // 初始兜底数据（防止首次渲染报错）
        },
    );
    return {
        fetchedModelList: data,
        fetchedModelListLoading: isLoading,
        fetchedModelListError: error,
    };
}

// 获取会话列表
export function useGetSessionList() {
    const { data, error, isLoading, mutate } = useSWR(
        "/session/getList",
        async () => {
            return (await sessionService.getSessionList()).data;
        },
        {
            ...SWR_CONFIG,
            revalidateOnFocus: true, // 切回页面重新请求
            fallbackData: [], // 初始兜底数据（防止首次渲染报错）
        },
    );
    return {
        fetchedSessionList: data,
        fetchedSessionListLoading: isLoading,
        fetchedSessionListError: error,
        refreshSessionList: mutate,
    };
}
```


### 2.4 BFF 开发

#### 2.4.1 BFF 全局应用常量

`/src/bff/lib/constants/app.ts`：

```ts
// ==================== BFF全局应用常量 ==================== //

import { SupportedModel } from "@/bff/lib/db/modelConfig";

// BFF请求请求默认配置
export const FETCH_CONFIG = {
    BFF_API_BASE_URL: process.env.NEXT_PUBLIC_BFF_API_BASE_URL || "",
    TIMEOUT: 600000, // BFF请求默认超时时间
    RETRY_TIMES: 1, // 网络波动重试1次
    PREFIX: "/api", // 接口请求前缀
    BFF_PREFIX: "/api", // BFF接口请求前缀
};

// 大模型密钥映射（环境变量读取，无硬编码）
export const MODEL_API_KEY: Record<SupportedModel, string> = {
    "deepseek-chat": process.env.DEEPSEEK_API_KEY || "",
    "doubao-seed-2-0-pro-260215": process.env.DOUBAO_API_KEY || "",
    "qwen3.6-plus-2026-04-02": process.env.QIANWEN_API_KEY || "",
};
```

#### 2.4.2 BFF 全局 TS 类型

`/src/bff/lib/types/app.d.ts`：

```ts
// ==================== BBF全局TS类型 ==================== //

// 模型类型
export interface ModelBFF {
    name?: string;
    label?: string;
    description?: string;
    apiKeyKey?: string;
    chatApiUrl?: string;
    parserType?: string;
    requestOptions?: string;
    enabled?: number;
}

// 会话类型
export interface SessionBFF {
    id?: string;
    title: string;
    createTime?: string;
    messages?: MessageBFF[];
}

// 对话消息类型
export interface MessageBFF {
    id: string;
    role: "user" | "assistant";
    model: string;
    content: string;
    createTime: string;
    docs: DocumentBFF[];
}

// 文档类型
export interface DocumentBFF {
    id: string;
    fileName: string;
    fileType: string;
    sizeText: string;
    content: string;
    uploadTime: string;
}

// 会话请求类型
export interface ChatBFF {
    id: string;
    model: string;
    content: string;
    chatHistorys: ChatHistoryBFF[];
    docs: DocumentBFF[];
    hasDocHistorys: boolean;
}

// 对话历史类型
export interface ChatHistoryBFF {
    role: "user" | "assistant";
    content: string;
}

// 大模型会话请求类型
export interface ModelChatBFF {
    model: string;
    chatApiUrl: string;
    apiKey: string;
    content: string;
}
```

#### 2.4.3 数据库初始化

##### 2.4.3.1 安装依赖

###### 2.4.3.1.1 PostgreSQL 数据库安装

- PostgreSQL + pgvector 安装：参考 <a href="https://templechann.com/post/postgresql-manual" target="_blank">《PostgreSQL 使用手册》</a>

###### 2.4.3.1.2 数据库代码连接依赖安装

```shell
pnpm install pg
pnpm install -D  @types/pg
```

##### 2.4.3.2 模型配置文件

`/src/bff/lib/db/modelConfig.ts`：

```ts
// ==================== 模型配置文件 ==================== //

// ==================== 大模型统一配置中心 ==================== //
// 作用：集中管理所有大模型的API地址、密钥映射、解析器类型等配置
// 扩展新模型：仅需在 MODEL_CONFIG_MAP 中新增配置项即可

// 定义支持的模型类型（强类型约束，避免拼写错误）
export type SupportedModel = "deepseek-chat" | "doubao-seed-2-0-pro-260215" | "qwen3.6-plus-2026-04-02";

/**
 * 单个模型的核心配置结构
 * @property apiKeyKey 对应 MODEL_API_KEY 常量中的key（用于获取API密钥）
 * @property chatApiUrl 模型的聊天API地址
 * @property parserType 该模型对应的流式解析器类型（与解析器工厂一一对应）
 * @property requestOptions 额外请求配置（请求头、超时等）
 */
export interface ModelConfig {
    label: string;
    description: string;
    apiKeyKey: SupportedModel;
    chatApiUrl: string;
    parserType: SupportedModel;
    requestOptions?: {
        headers?: Record<string, string>; // 请求头配置
    };
    enabled: number;
}

/**
 * 所有支持模型的配置映射表
 * 新增模型时：
 * 1. 在 SupportedModel 类型中添加模型标识
 * 2. 在该对象中新增对应模型的配置
 */
export const MODEL_CONFIG_MAP: Record<SupportedModel, ModelConfig> = {
    // DeepSeek 模型配置（原有模型，适配现有逻辑）
    "deepseek-chat": {
        label: "DeepSeek",
        description: "调用 DeepSeek-V3.2（非思考模式）模型",
        apiKeyKey: "deepseek-chat", // 对应 MODEL_API_KEY["deepseek-chat"]
        chatApiUrl: "https://api.deepseek.com/v1/chat/completions", // DeepSeek官方流式API地址
        parserType: "deepseek-chat", // 使用deepseek专属解析器
        requestOptions: {
            headers: {}, // 固定请求头
        },
        enabled: 1,
    },
    // 豆包模型配置（新增，需替换为实际API地址）
    "doubao-seed-2-0-pro-260215": {
        label: "字节豆包",
        description: "调用 Doubao-Seed-2.0-pro（非思考模式）模型",
        apiKeyKey: "doubao-seed-2-0-pro-260215", // 需在 MODEL_API_KEY 中配置该key的密钥
        chatApiUrl: "https://ark.cn-beijing.volces.com/api/v3/chat/completions", // 豆包流式API示例地址
        parserType: "doubao-seed-2-0-pro-260215", // 使用doubao专属解析器
        requestOptions: {
            headers: {},
        },
        enabled: 1,
    },
    // 千问模型配置（新增，阿里云千问官方地址）
    "qwen3.6-plus-2026-04-02": {
        label: "通义千问",
        description: "调用 Qwen3.6-Plus（非思考模式）模型",
        apiKeyKey: "qwen3.6-plus-2026-04-02", // 需在 MODEL_API_KEY 中配置该key的密钥
        chatApiUrl: "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions", // 千问流式API地址
        parserType: "qwen3.6-plus-2026-04-02", // 使用qwen专属解析器
        requestOptions: {
            headers: {},
        },
        enabled: 1,
    },
};

// 获取指定模型的配置（封装成函数，统一异常处理）
export const getModelConfig = (model: SupportedModel): ModelConfig => {
    const config = MODEL_CONFIG_MAP[model];
    if (!config) {
        throw new Error(`[模型配置异常] 未找到 ${model} 的配置，请检查 modelConfig.ts`);
    }
    return config;
};
```

##### 2.4.3.3 数据库初始化脚本

> 在应用入口文件中显式调用，如根布局组件。

```shell
pnpm install pg
```

`/src/bff/lib/db/initDB.ts`：

```ts
// ==================== 数据库初始化脚本 ==================== //

// ========== React、Next、Utils ========== //
import { Pool, PoolClient, QueryResult } from "pg";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// 模型厂商配置数据
import { MODEL_CONFIG_MAP, SupportedModel } from "@/bff/lib/db/modelConfig";
// ========== Hooks ========== //
// ========== Services ========== //

//  ========== 数据库连接池管理 dBPools ========== //
// 数据库连接池配置
// 连接池大小根据业务QPS调整，生产环境建议10-20；连接字符串优先从环境变量注入，避免硬编码敏感信息
const DB_POOL_CONFIGS = {
    // 默认库（postgres）：仅用于创建业务库/向量库，初始化完成后关闭
    default: {
        connectionString: `${process.env.POSTGRES_URL}/postgres`,
        max: 5,
        idleTimeoutMillis: 30000,
    },
    // 业务库：存储模型配置、会话、消息等
    tai_chat_db: {
        connectionString: `${process.env.POSTGRES_URL}/tai_chat_db`,
        max: 10, // 最大连接数（本地5 / 生产10~20，绝对不超过20）
        min: 2, // 最小空闲连接（保持2个活跃，避免反复重连）
        idleTimeoutMillis: 30000, // 空闲30秒自动释放（关键！解决ECONNRESET）
        connectionTimeoutMillis: 5000, // 连接超时5秒，快速失败
        maxUses: 1000, // 单个连接最多使用1000次（防内存泄漏）
        keepAlive: true, // 开启心跳保活
        keepAliveInitialDelayMillis: 10000, // 10秒发一次心跳
        // ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false,
        ssl: false,
    },
    // 向量库：存储RAG相关向量数据
    tai_rag_db: {
        connectionString: `${process.env.POSTGRES_URL}/tai_rag_db`,
        max: 10,
        min: 2,
        idleTimeoutMillis: 30000,
        maxUses: 1000,
        keepAlive: true,
        keepAliveInitialDelayMillis: 10000,
        // ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false,
        ssl: false,
    },
};
// 连接池对象，后面会导出给业务使用
const dBPools = {
    default: new Pool(DB_POOL_CONFIGS.default), // 默认库连接池：仅用于创建业务库/向量库，初始化完成后关闭
    tai_chat_db: null as Pool | null, // 业务库
    tai_rag_db: null as Pool | null, // 向量库连接池
};

//  ========== 数据库初始化配置 DB_SCHEMA_CONFIGS ========== //
// 向量库核心配置
// 向量维度需匹配 embedding 模型（all-MiniLM-L6-v2 对应 384），向量索引分片数 建议为 数据量 平方根的 1-3 倍
const VECTOR_CONFIG = {
    dimension: 384, // 向量维度
    ivfflatLists: 100, // 向量索引分片数
};
// 数据库初始化配置项类型
interface DBSchemaConfig {
    dbName: keyof typeof DB_POOL_CONFIGS; // 库名，关联连接池配置
    createTableSQL: string[]; // 该库需要执行的建表/建索引SQL列表
}
// 数据库表结构初始化SQL配置
// 1. 所有表名/索引名统一前缀，避免冲突
// 2. 索引按需创建，避免冗余
// 3. 外键约束带级联删除，保证数据一致性
const DB_SCHEMA_CONFIGS: DBSchemaConfig[] = [
    {
        dbName: "tai_chat_db",
        createTableSQL: [
            `
        -- 模型配置表：存储可用的大模型元信息
        CREATE TABLE IF NOT EXISTS chat_models (
          id TEXT PRIMARY KEY,                 -- 模型唯一ID，主键保证唯一性
          name TEXT NOT NULL,                  -- 模型内部名称（与接口对接使用）
          label TEXT NOT NULL,                 -- 模型展示名称
          description TEXT NOT NULL,           -- 模型功能描述
          api_key_key VARCHAR(50) NOT NULL,  -- 密钥映射键名
          chat_api_url TEXT NOT NULL,            -- 模型对话接口地址
          parser_type VARCHAR(50) NOT NULL,  -- 解析器类型
          request_options TEXT NOT NULL,     -- 请求头配置
          enabled SMALLINT DEFAULT 1,          -- 启用状态：0=禁用 1=启用
          CHECK (enabled IN (0, 1))            -- 约束状态值只能是0/1，避免非法值
        );
        -- 索引：按启用状态查询模型，提升列表筛选效率
        CREATE INDEX IF NOT EXISTS idx_chat_models_enabled 
        ON chat_models(enabled);
      `,
            `
        -- 会话表：存储用户的聊天会话信息
        CREATE TABLE IF NOT EXISTS chat_sessions (
          id TEXT PRIMARY KEY,                 -- 会话唯一ID
          title TEXT NOT NULL,                 -- 会话标题
          create_time TEXT NOT NULL             -- 创建时间（字符串格式，兼容前端时间处理）
        );
        -- 索引：按创建时间倒序查询会话，提升会话列表加载效率
        CREATE INDEX IF NOT EXISTS idx_chat_sessions_create_time 
        ON chat_sessions (create_time DESC);
      `,
            `
        -- 对话消息表：存储会话下的单条聊天消息
        CREATE TABLE IF NOT EXISTS chat_messages (
          id TEXT PRIMARY KEY,                   -- 消息唯一ID
          session_id TEXT NOT NULL,              -- 关联会话ID
          role TEXT NOT NULL,                    -- 角色：user（用户）/assistant（助手）
          model TEXT NOT NULL,                   -- 生成消息使用的模型名称
          content TEXT NOT NULL,                 -- 消息内容
          create_time TEXT NOT NULL,              -- 消息创建时间
          docs TEXT NOT NULL,                    -- 检索到的文档列表（JSON字符串）
          CHECK (role IN ('user', 'assistant')), -- 约束角色值，避免非法角色
          -- 外键约束：关联会话表，删除会话时自动删除关联消息（级联删除）
          FOREIGN KEY (session_id) REFERENCES chat_sessions(id) ON DELETE CASCADE
        );
        -- 复合索引：按会话ID+创建时间查询消息，提升会话消息加载效率
        CREATE INDEX IF NOT EXISTS idx_chat_messages_session_time 
        ON chat_messages (session_id, create_time ASC);
      `,
        ],
    },
    {
        dbName: "tai_rag_db",
        createTableSQL: [
            `
        -- 启用PostgreSQL向量扩展（需数据库用户有创建扩展权限）
        CREATE EXTENSION IF NOT EXISTS vector;
        
        -- 向量表：存储RAG检索所需的文本向量数据
        CREATE TABLE IF NOT EXISTS rag_vectors (
          id UUID PRIMARY KEY,                  -- 向量唯一ID（UUID保证分布式环境唯一性）
          vector vector(${VECTOR_CONFIG.dimension}) NOT NULL, -- 向量数据，维度匹配embedding模型
          metadata JSONB NOT NULL,              -- 向量元数据（如sessionId、文档ID等，JSONB支持灵活查询）
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 向量创建时间，默认当前时间
        );

        -- 索引：按会话ID查询向量，提升会话维度的检索效率
        CREATE INDEX IF NOT EXISTS idx_rag_vectors_session 
        ON rag_vectors ((metadata->>'sessionId'));
        
        -- 向量索引：基于IVFFLAT算法的余弦相似度索引，提升向量检索性能
        -- lists参数：建议为数据量平方根的1-3倍，生产环境需根据数据量调优
        CREATE INDEX IF NOT EXISTS idx_rag_vectors_vector 
        ON rag_vectors USING ivfflat (vector vector_cosine_ops) WITH (lists = ${VECTOR_CONFIG.ivfflatLists});
      `,
        ],
    },
];

//  ========== 建表/建索引SQL执行方法 executeSQL ========== //
async function executeSQL(
    client: PoolClient, // client 数据库连接客户端（从连接池获取）
    sql: string, // 待执行的SQL语句
    desc: string, // SQL操作描述（用于日志溯源）
    params: any[] = [], // SQL参数列表，默认空数组
): Promise<QueryResult> {
    try {
        return await client.query(sql, params);
    } catch (error) {
        throw new Error(`建表/建索引SQL执行失败: ${(error as Error).message}`);
    }
}

//  ========== 数据库初始化方法 initDBSchema ========== //
async function initDBSchema(): Promise<void> {
    let defaultClient: PoolClient | null = null;

    try {
        // 获取默认库连接（postgres）
        defaultClient = await dBPools.default.connect();

        // 串行遍历数据库配置
        for (const schemaConfig of DB_SCHEMA_CONFIGS) {
            const { dbName, createTableSQL } = schemaConfig;

            // 检查数据库是否存在
            const existsResult = await defaultClient.query(`SELECT 1 FROM pg_database WHERE datname = $1`, [dbName]);

            // 不存在则创建（生产环境建议由运维提前创建，此处仅用于开发/测试环境）
            if (existsResult.rows.length === 0) {
                await defaultClient.query(`CREATE DATABASE ${dbName}`);
            }

            // 初始化当前库的连接池并连接
            dBPools[dbName] = new Pool(DB_POOL_CONFIGS[dbName]);
            const currentClient = await dBPools[dbName]!.connect();

            // 串行执行建表/建索引SQL
            for (const sql of createTableSQL) {
                await executeSQL(currentClient, sql, `[${dbName}] 建表/建索引`);
            }
            // 释放当前库客户端（归还到连接池）
            currentClient.release();
            console.log(`${dbName} 数据库表结构初始化完成 ！`);
        }
        console.log("表结构初始化全部完成 ！ \n");
    } catch (error) {
        throw new Error(`表结构初始化失败: ${(error as Error).message}`);
    } finally {
        // 释放默认库客户端 + 关闭默认池（初始化完成后不再使用）
        if (defaultClient) {
            defaultClient.release();
        }
        await dBPools.default.end();
    }
}

//  ========== 初始化基础数据方法 initDBBaseData ========== //
async function initDBBaseData(): Promise<void> {
    // 校验业务库连接池是否初始化
    if (!dBPools.tai_chat_db) {
        throw new Error("tai_chat_db 数据库连接池未初始化，无法写入基础数据 ！");
    }
    let chatClient: PoolClient | null = null;
    try {
        // 获取业务库连接
        chatClient = await dBPools.tai_chat_db.connect();

        // ===== 模型基础数据处理 =====
        const models = Object.entries(MODEL_CONFIG_MAP).map(([model, config]) => ({
            id: model as SupportedModel,
            name: model as SupportedModel,
            ...config, // 展开原有所有配置
        }));
        const total = models.length;
        // 无数据则跳过
        if (total === 0) {
            console.log("模型基础数据为空，跳过写入 ！");
            return;
        }
        // 构造 PostgreSQL 的插入语句
        // 动态生成占位符（PostgreSQL 使用 $1/$2... 而非 ?）
        const columns = ["id", "name", "label", "description", "api_key_key", "chat_api_url", "parser_type", "request_options", "enabled"];
        const placeholders = models.map((_, idx) => `(${columns.map((_, colIdx) => `$${idx * columns.length + colIdx + 1}`).join(", ")})`).join(", ");
        // 扁平化参数列表，匹配占位符顺序
        const args = models.flatMap((item) => [item.id, item.name, item.label, item.description, item.apiKeyKey, item.chatApiUrl, item.parserType, JSON.stringify(item.requestOptions), item.enabled]);
        // 执行插入（主键冲突时忽略，避免重复写入）
        const insertSQL = `
            INSERT INTO chat_models (${columns.join(", ")})
            VALUES ${placeholders}
            ON CONFLICT (id) DO NOTHING; -- PostgreSQL 兼容的去重插入
        `;
        await executeSQL(chatClient, insertSQL, "[tai_chat_db] 模型表基础数据写入", args);
        console.log(`成功写入 ${total} 条模型基础数据 ！`);

        // ===== 其他基础数据处理... =====

        console.log("基础数据初始化全部完成 ！ \n");
    } catch (error) {
        throw new Error(`基础数据初始化失败：${(error as Error).message}`);
    } finally {
        if (chatClient) {
            chatClient.release();
        }
    }
}

//  ========== 进程生命周期终止管理（避免资源泄漏） ========== //
process.on("SIGTERM", async () => {
    console.log("[进程终止] 开始关闭数据库连接池...");
    // 关闭所有业务库连接池
    await Promise.all(
        Object.values(dBPools)
            .filter(Boolean)
            .map((pool) => pool!.end()),
    );
    console.log("[进程终止] 所有连接池已关闭，退出进程");
    // 完成了所有任务，退出
    process.exit(0);
});

//  ========== 数据库初始化统一入口 initDatabase ========== //
export async function initDatabase(): Promise<typeof dBPools | undefined> {
    // 构建阶段直接跳过，不执行任何数据库操作
    if (process.env.SKIP_DB_INIT) {
        console.log("[构建模式] 跳过数据库初始化");
        return;
    }

    try {
        console.log("[数据库初始化] 执行表结构初始化 ...");
        await initDBSchema(); // 先初始化表结构
        console.log("[数据库初始化] 执行基础数据初始化 ...");
        await initDBBaseData(); // 再写入基础数据
        console.log("[数据库初始化] 初始化全部完成 !");
        return dBPools;
    } catch (error) {
        console.error("[数据库初始化失败] 数据库初始化异常，终止应用", error);
        process.exit(1); // 初始化失败终止应用，避免异常运行
    }
}

// ========== 初始化执行 ========== //
// 在 BFF 任意一个入口文件中显式调用 initDatabase()，如 `src\app\api\model\route.ts`
// 因为是全局模块，只会执行一次
initDatabase();

// ========== 导出连接池 ========== //
export default dBPools;
```

#### 2.4.4 BFF 请求工具封装

`/src/bff/lib/utils/request.ts`：

```ts
// ==================== BFF 请求工具封装（提供超时，重试等功能） ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
import { FETCH_CONFIG } from "@/bff/lib/constants/app";
// ========== Hooks ========== //
// ========== Services ========== //

type FetchBFFOptions = Omit<RequestInit, "body"> & {
    body?: Record<string, any>;
    timeout?: number;
    retryTimes?: number;
};

export async function request(
    url: string, // 接口路径，需要完整路径
    options: FetchBFFOptions = {},
): Promise<any> {
    const { timeout = FETCH_CONFIG.TIMEOUT, retryTimes = FETCH_CONFIG.RETRY_TIMES, body, headers = {}, ...restOptions } = options;

    // 封装超时逻辑
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeout);

    try {
        const res = await fetch(url, {
            ...restOptions,
            headers: {
                "Content-Type": "application/json",
                ...headers,
            },
            body: body ? JSON.stringify(body) : undefined,
            signal: controller.signal,
        });

        // 响应校验
        if (!res.ok) {
            const errorText = await res.text();
            throw new Error(`[模型请求失败] ${body?.model} API返回异常：${res.status} ${errorText}`);
        }

        return res;
    } catch (error) {
        // 重试逻辑（仅临时网络错误重试）
        if (retryTimes > 0 && (error as Error).name === "AbortError") {
            return request(url, { ...options, retryTimes: retryTimes - 1 });
        }
        throw new Error(`BFF 第三方服务异常: ${(error as Error).message}`);
    } finally {
        clearTimeout(timeoutId);
    }
}
```

#### 2.4.5 BFF 接口异常处理工具封装

`/src/bff/lib/utils/errorHandler.ts`：

```ts
// ==================== BFF 接口异常处理工具封装 ==================== //

// ========== React、Next、Utils ========== //
import { NextResponse } from "next/server";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

export function withErrorHandler(fn: (...args: any[]) => Promise<NextResponse>): typeof fn {
    {
        return async (...args: any[]) => {
            try {
                return await fn(...args);
            } catch (error) {
                return NextResponse.json({ code: 500, message: (error as Error).message, error: (error as Error).message }, { status: 500 });
            }
        };
    }
}
```

#### 2.4.6 API 开发
##### 2.4.6.1 BFF 模型列表接口

`/src/app/api/model/route.ts`：

```ts
// ==================== BFF 模型列表接口 ==================== //

// ========== React、Next、Utils ========== //
// 初始化BFF数据库，只在这里引用一次即可
import "@/bff/lib/db/initDB";
// 预下载模型，只在这里引用一次即可
import "@/bff/lib/utils/rag-tool";
import { NextResponse } from "next/server";
import { withErrorHandler } from "@/bff/lib/utils/error-handler";
// 获取数据库连接池对象
import dBPools from "@/bff/lib/db/initDB";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { PoolClient } from "pg";
import type { Model } from "@/lib/types/app";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

// GET 获取模型列表，支持 id 查询
export const GET = withErrorHandler(async (request: Request): Promise<NextResponse> => {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get("id");
    let data: any;
    let result: Model[] | Model = [];

    // 取业务库连接池
    const chatPool = dBPools.tai_chat_db;
    // 取向量库连接池
    // const ragPool = dBPools.tai_rag_db;
    // 校验业务库连接池是否初始化
    if (!chatPool) {
        throw new Error("tai_chat_db 数据库连接池未初始化 ！");
    }
    // 声明连接变量
    let dbClient: PoolClient | null = null;

    try {
        // 获取数据库连接
        dbClient = await chatPool.connect();

        if (id) {
            // 检查模型是否存在
            const { rowCount } = await dbClient.query("SELECT id FROM chat_models WHERE id = $1", [id]);
            if (rowCount === 0) {
                return NextResponse.json({ code: 404, message: "模型不存在" }, { status: 404 });
            }

            data = await dbClient.query(`SELECT id, name, label, description, api_key_key, chat_api_url, parser_type, request_options, enabled FROM chat_models WHERE enabled = 1 AND id = $1`, [id]);
            result = {
                apiKeyKey: data.rows[0]?.api_key_key || "",
                chatApiUrl: data.rows[0]?.chat_api_url || "",
                parserType: data.rows[0]?.parser_type || "",
                requestOptions: JSON.parse(data.rows[0]?.request_options || JSON.stringify({})),
            };
        } else {
            data = await dbClient.query(`SELECT id, name, label, description, chat_api_url, enabled FROM chat_models WHERE enabled = 1`);
            result = data.rows
                ? data.rows.map((model: any) => {
                      return {
                          name: model.name,
                          label: model.label,
                          description: model.description,
                      };
                  })
                : [];
        }
        return NextResponse.json({ code: 200, data: result, message: "获取模型列表成功" });
    } catch (error) {
        throw new Error(`获取模型列表失败: ${(error as Error).message}`);
    } finally {
        // 关键：无论成功/失败，都释放连接
        if (dbClient) {
            dbClient.release();
        }
    }
});
```

##### 2.4.6.2 BFF 会话列表接口

`/src/app/api/session/route.ts`：

```ts
// ==================== BFF 会话列表接口 ==================== //

// ========== React、Next、Utils ========== //
import { NextResponse } from "next/server";
import { withErrorHandler } from "@/bff/lib/utils/error-handler";
import { v4 as uuidv4 } from "uuid";
// 获取数据库连接池对象
import dBPools from "@/bff/lib/db/initDB";
import { parseJson } from "@/bff/lib/utils/common-tools";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { PoolClient } from "pg";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

//  POST - 新增会话
export const POST = withErrorHandler(async (request: Request): Promise<NextResponse> => {
    const title: string = (await request.json()).title;
    let result: string = "";
    let data: any;

    // 取业务库连接池
    const chatPool = dBPools.tai_chat_db;
    // 校验业务库连接池是否初始化
    if (!chatPool) {
        throw new Error("tai_chat_db 数据库连接池未初始化 ！");
    }
    // 声明连接变量
    let dbClient: PoolClient | null = null;

    try {
        // 获取数据库连接
        dbClient = await chatPool.connect();

        // 校验
        if (!title) {
            return NextResponse.json({ code: 400, message: "会话数据标题不能为空" }, { status: 400 });
        }

        // 插入 chat_sessions 表
        data = await dbClient.query(`INSERT INTO chat_sessions (id, title, create_time) VALUES ($1, $2, $3) RETURNING id`, [uuidv4(), title, new Date().toISOString()]);

        result = data.rows[0].id;
        return NextResponse.json({ code: 200, data: { id: result }, message: "新增会话成功" });
    } catch (error) {
        throw new Error(`新增会话失败: ${(error as Error).message}`);
    } finally {
        // 关键：无论成功/失败，都释放连接
        if (dbClient) {
            dbClient.release();
        }
    }
});

// DELETE - 删除会话
export const DELETE = withErrorHandler(async (request: Request): Promise<NextResponse> => {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get("id");

    // 取业务库连接池
    const chatPool = dBPools.tai_chat_db;
    // 校验业务库连接池是否初始化
    if (!chatPool) {
        throw new Error("tai_chat_db 数据库连接池未初始化 ！");
    }
    // 声明连接变量
    let dbClient: PoolClient | null = null;

    try {
        // 获取数据库连接
        dbClient = await chatPool.connect();

        // 前置校验
        if (!id) {
            return NextResponse.json({ code: 400, message: "会话ID不能为空" }, { status: 400 });
        }
        const currentSessionData = await dbClient.query("SELECT id FROM chat_sessions WHERE id = $1", [id]);
        if (currentSessionData.rowCount === 0) {
            return NextResponse.json({ code: 404, message: "会话不存在" }, { status: 404 });
        }

        // 删除会话（messages表会通过外键级联删除）
        await dbClient.query("DELETE FROM chat_sessions WHERE id = $1", [id]);

        return NextResponse.json({ code: 200, message: "删除会话成功" });
    } catch (error) {
        throw new Error(`删除会话失败: ${(error as Error).message}`);
    } finally {
        // 关键：无论成功/失败，都释放连接
        if (dbClient) {
            dbClient.release();
        }
    }
});

// PATCH - 修改会话，包括重命名、新增聊天数据
export const PATCH = withErrorHandler(async (request: Request): Promise<NextResponse> => {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get("id");
    const { title, message } = await request.json();

    // 取业务库连接池
    const chatPool = dBPools.tai_chat_db;
    // 校验业务库连接池是否初始化
    if (!chatPool) {
        throw new Error("tai_chat_db 数据库连接池未初始化 ！");
    }
    // 声明连接变量
    let dbClient: PoolClient | null = null;

    try {
        // 获取数据库连接
        dbClient = await chatPool.connect();

        // 前置校验
        if (!id) {
            return NextResponse.json({ code: 400, message: "会话ID不能为空" }, { status: 400 });
        }
        const currentSessionData = await dbClient.query("SELECT id FROM chat_sessions WHERE id = $1", [id]);
        if (currentSessionData.rowCount === 0) {
            await dbClient.query("ROLLBACK");
            return NextResponse.json({ code: 404, message: "会话不存在" }, { status: 404 });
        }

        await dbClient.query("BEGIN");

        if (title) {
            // 更新会话（重命名）
            await dbClient.query(`UPDATE chat_sessions SET title = $1 WHERE id = $2`, [title, id]);
        } else if (message) {
            console.log("插入", message.id, id, message.role, message.model, message.content, message.createTime, message.docs?.length ? JSON.stringify(message.docs) : "");
            // 更新会话（新增会话聊天数据）

            // 批量插入 chat_messages 表
            const placeholders = "$1, $2, $3, $4, $5, $6, $7";
            const args = [message.id, id, message.role, message.model, message.content, message.createTime, message.docs?.length ? JSON.stringify(message.docs) : ""];
            await dbClient.query(`INSERT INTO chat_messages (id, session_id, role, model, content, create_time, docs) VALUES (${placeholders})`, args);
        }

        await dbClient.query("COMMIT");

        return NextResponse.json({ code: 200, message: "更新会话成功" });
    } catch (error) {
        // 出错回滚
        if (dbClient) await dbClient.query("ROLLBACK");
        throw new Error(`更新会话失败: ${(error as Error).message}`);
    } finally {
        // 关键：无论成功/失败，都释放连接
        if (dbClient) {
            dbClient.release();
        }
    }
});

//  GET - 获取单个会话详情 或 会话列表，支持 id 查询
export const GET = withErrorHandler(async (request: Request): Promise<NextResponse> => {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get("id");
    let result: any[] | any = [];
    const messages: any[] = [];
    let data: any;

    // 取业务库连接池
    const chatPool = dBPools.tai_chat_db;
    // 校验业务库连接池是否初始化
    if (!chatPool) {
        throw new Error("tai_chat_db 数据库连接池未初始化 ！");
    }
    // 声明连接变量
    let dbClient: PoolClient | null = null;

    try {
        // 获取数据库连接
        dbClient = await chatPool.connect();

        if (id) {
            // 获取单个会话详情

            // 前置校验
            const { rowCount } = await dbClient.query("SELECT id FROM chat_sessions WHERE id = $1", [id]);
            if (rowCount === 0) {
                return NextResponse.json({ code: 404, message: "会话不存在" }, { status: 404 });
            }

            data = await dbClient.query(
                `
                SELECT 
                    s.id,
                    s.title,
                    s.create_time,
                    COALESCE(
                    json_agg(
                        json_build_object(
                        'id', m.id,
                        'role', m.role,
                        'model', m.model,
                        'content', m.content,
                        'create_time', m.create_time,
                        'docs', m.docs
                        )
                    ) FILTER (WHERE m.id IS NOT NULL),
                    '[]'::json
                    ) AS messages
                FROM chat_sessions s
                LEFT JOIN chat_messages m ON s.id = m.session_id
                WHERE s.id = $1
                GROUP BY s.id, s.title, s.create_time
                `,
                [id],
            );

            const row = data.rows[0];

            result = {
                id: row.id,
                title: row.title,
                createTime: row.create_time,
                messages: row.messages || [],
            };

            result.messages = result.messages.map((msg: { docs: string }) => ({
                ...msg,
                // 解析 docs（兼容空值/错误格式）
                docs: parseJson(msg.docs),
            }));
        } else {
            // 获取会话列表
            data = await dbClient.query(`SELECT id, title, create_time FROM chat_sessions ORDER BY create_time DESC`);
            result = data.rows
                ? data.rows.map((session: any) => {
                      return {
                          id: session.id,
                          title: session.title,
                          createTime: session.create_time,
                          messages,
                      };
                  })
                : [];
        }

        return NextResponse.json({ code: 200, data: result, message: "获取会话成功" });
    } catch (error) {
        throw new Error(`获取会话失败: ${(error as Error).message}`);
    } finally {
        // 关键：无论成功/失败，都释放连接
        if (dbClient) {
            dbClient.release();
        }
    }
});
```


##### 2.4.6.3 BFF 会话聊天接口

`/src/app/api/chat/route.ts`：

```ts
// ==================== BFF 会话聊天接口 ==================== //

// ========== React、Next、Utils ========== //
import { NextResponse } from "next/server";
import { withErrorHandler } from "@/bff/lib/utils/error-handler";
import nextRag from "@/bff/lib/utils/rag-tool";
import { v4 as uuidv4 } from "uuid";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { ChatBFF } from "@/bff/lib/types/app";
// ========== Stroe、Constants ========== //
import { MODEL_API_KEY } from "@/bff/lib/constants/app";
// ========== Hooks ========== //
// ========== Services ========== //
import { modelService } from "@/bff/services/modelService";
import { sessionService } from "@/bff/services/sessionService";
import { chatService } from "@/bff/services/chatService";
import { MODEL_CONFIG_MAP, SupportedModel } from "@/bff/lib/db/modelConfig";
import { getStreamParser } from "@/bff/lib/utils/modelStreamParser";

// 发送会话
export const POST = withErrorHandler(async (request: Request): Promise<NextResponse> => {
    const chatParams: ChatBFF = (await request.json()).chatParams;

    // 类型校验：确保模型在支持列表中（避免非法模型请求）
    const models = Object.entries(MODEL_CONFIG_MAP).map(([model]) => model);
    if (!models.includes(chatParams.model)) {
        throw new Error(`[参数异常] 不支持的模型类型：${chatParams.model}`);
    }

    const model = chatParams.model as SupportedModel;

    // 调用 RAG 获取处理后的 prompt
    const { prompt } = await nextRag.smartChat({
        sessionId: chatParams.id,
        userQuery: chatParams.content,
        docs: chatParams.docs,
        chatHistorys: chatParams.chatHistorys,
        hasDocHistorys: chatParams.hasDocHistorys,
    });

    // 从统一配置中心获取模型配置
    const modelConfig = (await modelService.getModelConfig(model)).data;
    // 根据配置获取API密钥（兼容原有MODEL_API_KEY常量）
    const apiKey = MODEL_API_KEY[modelConfig.apiKeyKey as SupportedModel];

    if (!apiKey) {
        throw new Error(`[配置异常] 未配置 ${model} 的API密钥，请检查 MODEL_API_KEY 常量`);
    }

    const modelResponse = await chatService.sendChat({
        model,
        chatApiUrl: modelConfig.chatApiUrl,
        apiKey,
        content: prompt,
        requestOptions: modelConfig.requestOptions,
    });
    // 统一流式响应处理
    const stream = new ReadableStream({
        async start(controller) {
            // 防御性校验：确保响应体存在
            if (!modelResponse.body) {
                console.error(`[流异常] ${model} 返回空响应体`);
                controller.close();
                return;
            }

            const reader = modelResponse.body.getReader(); // 获取流读取器
            const decoder = new TextDecoder("utf-8"); // 复用解码器（避免重复创建）
            let fullText: string = ""; // 拼接完整回复内容（用于持久化）
            const parser = getStreamParser(model); // 获取当前模型的解析器

            try {
                // 通用流读取循环（所有模型共用此逻辑）
                while (true) {
                    const { done: readerDone, value } = await reader.read();
                    // 流读取完成，退出循环
                    if (readerDone) break;

                    // 调用解析器处理二进制chunk，获取标准化结果
                    const parseResults = parser(value, decoder);
                    // 遍历解析结果，推送给前端
                    for (const result of parseResults) {
                        // 跳过结束标识
                        if (result.done) continue;
                        // 有内容则推送给前端
                        if (result.content) {
                            fullText += result.content;
                            controller.enqueue(result.content); // 仅推送纯文本给前端
                        }
                    }
                }
            } catch (error) {
                const errorMsg = `${model} 模型服务异常，请稍后重试`;
                fullText = errorMsg;
                controller.enqueue(errorMsg);
                console.error(`[流处理异常] ${model} 流读取失败：`, error);
            } finally {
                // 关闭流（必须执行，否则前端会一直等待）
                controller.close();

                // ========== 原有逻辑：持久化助手回复 ========== //
                await sessionService.updateSessionMessage(chatParams.id, {
                    message: {
                        id: uuidv4(),
                        role: "assistant",
                        model: chatParams.model,
                        content: fullText,
                        createTime: new Date().toISOString(),
                        docs: [],
                    },
                });
            }
        },
    });
    // 返回标准 SSE 流
    return new NextResponse(stream, {
        headers: {
            "Content-Type": "text/event-stream",
            "Cache-Control": "no-cache",
            Connection: "keep-alive",
            "X-Accel-Buffering": "no", // 禁用 Nginx 缓冲
        },
    });
});
```


#### 2.4.7 BFF 服务层封装
##### 2.4.7.1 BFF 模型列表服务层

> 给 BFF 提供搜索指定模型配置信息的能力。

`/src/bff/services/modelService.ts`：

```ts
// ==================== BFF 模型列表服务层 ==================== //
// 给 BFF 提供搜索指定模型配置信息的能力

// ========== React、Next、Utils ========== //
import { request } from "@/bff/lib/utils/request";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
import { FETCH_CONFIG } from "@/bff/lib/constants/app";
import { SupportedModel } from "@/bff/lib/db/modelConfig";
// ========== Hooks ========== //
// ========== Services ========== //

export const modelService = {
    // 新增：获取模型完整配置（推荐新逻辑使用）
    async getModelConfig(model: SupportedModel): Promise<any> {
        return (await request(`${FETCH_CONFIG.BFF_API_BASE_URL}${FETCH_CONFIG.BFF_PREFIX}/model?id=${model}`)).json();
    },
};
```
##### 2.4.7.2 BFF 会话列表服务层

`/src/bff/services/sessionService.ts`：

```tsx
// ==================== BFF 会话列表服务层 ==================== //

// ========== React、Next、Utils ========== //
import { request } from "@/bff/lib/utils/request";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import { MessageBFF } from "@/bff/lib/types/app";
// ========== Stroe、Constants ========== //
import { FETCH_CONFIG } from "@/bff/lib/constants/app";
// ========== Hooks ========== //
// ========== Services ========== //

export const sessionService = {
    // 更新会话（新增会话聊天数据）
    async updateSessionMessage(id: string, data: { message: MessageBFF }): Promise<any> {
        return (await request(`${FETCH_CONFIG.BFF_API_BASE_URL}${FETCH_CONFIG.BFF_PREFIX}/session?id=${id}`, { method: "PATCH", body: data })).json();
    },
};
```


##### 2.4.7.3 BFF 会话请求服务层

> 给 BFF 提供通过前端的会查请求信息、结合搜索的模型配置信息，组装参数去访问它对应模型的会话API，获取会话结果后返回给前端。
 
`/src/bff/services/chatService.ts`：

```ts
// ==================== BFF 会话请求服务层  ==================== //
// 给 BFF 提供通过前端的会查请求信息、结合搜索的模型配置信息，组装参数去访问它对应模型的会话API，获取会话结果后返回给前端

// ========== React、Next、Utils ========== //
import { request } from "@/bff/lib/utils/request";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import { SupportedModel } from "@/bff/lib/db/modelConfig";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

interface SendChatParams {
    model: SupportedModel;
    chatApiUrl: string;
    apiKey: string;
    content: string;
    requestOptions?: {
        headers?: Record<string, string>;
    };
}

export const chatService = {
    // 发送会话
    async sendChat({ model, chatApiUrl, apiKey, content, requestOptions }: SendChatParams): Promise<any> {
        // 统一请求头（基础头 + 模型专属头）
        const headers = {
            Authorization: `Bearer ${apiKey}`, // 统一的鉴权格式（大部分模型遵循）
            ...requestOptions?.headers, // 模型专属头覆盖基础头
        };
        // 不同模型的请求参数适配（核心差异点）
        let requestBody: Record<string, any> = {};
        switch (model) {
            case "deepseek-chat":
                // DeepSeek参数格式（OpenAI兼容）
                requestBody = {
                    model: "deepseek-chat", // DeepSeek模型标识
                    messages: [{ role: "user", content }], // 对话消息
                    stream: true, // 开启流式响应
                };
                break;

            case "doubao-seed-2-0-pro-260215":
                // 豆包参数格式（示例，需根据实际文档调整）
                requestBody = {
                    model: "doubao-seed-2-0-pro-260215",
                    messages: [
                        {
                            content: [
                                {
                                    text: content,
                                    type: "text",
                                },
                            ],
                            role: "user",
                        },
                    ],
                    reasoning_effort: "medium", // 思考程度, minimal、low、medium、high 四种模式，其中 minimal 为不思考
                    stream: true, // 开启流式响应
                };
                break;

            case "qwen3.6-plus-2026-04-02":
                // 千问参数格式（阿里云DashScope标准）
                requestBody = {
                    model: "qwen3.6-plus-2026-04-02", // 千问模型标识
                    messages: [{ role: "user", content }], // 对话消息
                    stream: true, // 开启流式响应
                };
                break;
        }

        // 发送POST请求（流式响应）
        const response = await request(chatApiUrl, {
            method: "POST",
            headers,
            body: requestBody,
        });

        return response;
    },
};

```

###### 2.4.7.3.1 RAG 工具封装

```shell
pnpm install @langchain/core @langchain/textsplitters @xenova/transformers
```


`/src/bff/lib/utils/ragTool.ts`：

```ts
// ==================== RAG 工具封装 ==================== //

// ========== React、Next、Utils ========== //
import { Embeddings } from "@langchain/core/embeddings";
import { RecursiveCharacterTextSplitter } from "@langchain/textsplitters";
import { pipeline, env } from "@xenova/transformers";
import { PoolClient } from "pg";
import { v4 as uuidv4 } from "uuid";
// 获取数据库连接池对象
import dBPools from "@/bff/lib/db/initDB";
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
import type { EmbeddingsParams } from "@langchain/core/embeddings";
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

//  ========== 全局常量定义 ========== //
/** 文本分块大小 */
const CHUNK_SIZE = 800;
/** 文本分块重叠长度 */
const CHUNK_OVERLAP = 80;
/** 默认检索返回条数 */
const DEFAULT_TOP_K = 3;
/** 特征提取模型 */
const EMBEDDING_MODEL = "Xenova/all-MiniLM-L6-v2";
/** 零样本分类模型 */
const CLASSIFY_MODEL = "Xenova/distilbert-base-uncased-mnli";
/** 检索关键词匹配库 */
const RETRIEVAL_KEYWORDS = ["历史", "上下文", "之前", "刚才", "会话", "文档", "记录", "总结", "回忆", "上一句"];

//  ========== 类型接口定义 ========== //

// 会话文本存储参数
export interface StoreSessionParams {
    sessionId: string;
    docs: Array<{ content?: string }>;
}

// 智能检索分类参数
export interface ClassifyParams {
    userQuery: string;
    chatHistorys?: Array<{ role: string; content: string }>;
}

// 向量检索参数
export interface RetrieveParams {
    sessionId: string;
    userQuery: string;
    topK?: number;
}

// 智能聊天核心参数
export interface SmartChatParams {
    sessionId: string;
    userQuery: string;
    docs?: Array<{ content?: string }> | null;
    chatHistorys?: Array<{ role: string; content: string }>;
    hasDocHistorys?: any;
}

// 聊天接口返回结果
export interface ChatResult {
    sessionId: string;
    userQuery: string;
    needRetrieval: boolean;
    prompt: string;
}

//  ========== 本地嵌入模型实现 ========== //
// 继承 LangChain Embeddings 基类，适配向量数据库交互
// 基于 ONNX 本地模型 的文本向量生成类
class LocalOnnxEmbeddings extends Embeddings {
    private readonly model: any;

    constructor(model: any, params?: EmbeddingsParams) {
        super(params ?? {});
        this.model = model;
    }

    // 批量生成文档向量
    async embedDocuments(texts: string[]): Promise<number[][]> {
        return Promise.all(texts.map((text) => this.embedSingleText(text)));
    }

    // 生成查询文本向量
    async embedQuery(text: string): Promise<number[]> {
        return this.embedSingleText(text);
    }

    // 单文本向量生成核心逻辑
    private async embedSingleText(text: string): Promise<number[]> {
        const output = await this.model(text, { pooling: "mean", normalize: true });
        return Array.from(output.data);
    }
}

//  ========== RAG核心工具类 ========== //
// 功能：文本分块、向量生成、pgvector 存储与检索、智能上下文判断
export class NextBffRagTool {
    private isInitialized: boolean;
    private readonly textSplitter: RecursiveCharacterTextSplitter;
    private embeddingModel: any;
    private classifyModel: any;
    private embeddingsInstance!: LocalOnnxEmbeddings;

    constructor() {
        this.isInitialized = false;
        this.textSplitter = new RecursiveCharacterTextSplitter({
            chunkSize: CHUNK_SIZE,
            chunkOverlap: CHUNK_OVERLAP,
        });

        // 首次调用会下载模型，然后缓存
        env.remoteHost = "https://hf-mirror.com";
        env.allowRemoteModels = true;
        env.cacheDir = "./tmp/.cache";
    }

    //  全局初始化方法（单例执行）
    //  加载 AI 模型，避免重复初始化
    public async initialize(): Promise<void> {
        if (this.isInitialized) return;

        try {
            console.log("开始下载模型...");
            this.embeddingModel = await pipeline("feature-extraction", EMBEDDING_MODEL);
            this.classifyModel = await pipeline("zero-shot-classification", CLASSIFY_MODEL);
            console.log("模型下载成功");
            this.embeddingsInstance = new LocalOnnxEmbeddings(this.embeddingModel);
            this.isInitialized = true;
        } catch (error) {
            console.error("模型初始化失败", error);
            throw new Error(`模型初始化失败: ${(error as Error).message}`);
        }
    }

    // 预加载快捷方法
    private async preloadModels(): Promise<void> {
        await this.initialize();
    }

    //  调用数据库连接池
    private async getDatabaseClient(): Promise<PoolClient> {
        // 取业务库连接池
        const chatPool = dBPools.tai_rag_db;
        // 校验业务库连接池是否初始化
        if (!chatPool) {
            throw new Error("tai_rag_db 数据库连接池未初始化 ！");
        }
        // 声明连接变量
        let dbClient: PoolClient | null = null;

        dbClient = await chatPool.connect();
        return dbClient;
    }

    // 存储会话文本到向量数据库
    // 流程：文本清洗 → 分块 → 向量化 → 批量入库
    public async storeSessionText(params: StoreSessionParams) {
        const { sessionId, docs } = params;
        if (!sessionId || !Array.isArray(docs) || docs.length === 0) {
            throw new Error("sessionId 为必填项，text 必须为非空数组");
        }
        await this.initialize();

        const fullText = docs
            .map((item) => item?.content)
            .filter((content) => typeof content === "string" && content.trim())
            .join("\n\n");
        if (!fullText) {
            return { success: true, chunkCount: 0 };
        }

        const chunks = await this.textSplitter.splitText(fullText);
        const vectors = await this.embeddingsInstance.embedDocuments(chunks);

        const client = await this.getDatabaseClient();
        try {
            const values = chunks.map((chunk, index) => [uuidv4(), `[${vectors[index].join(",")}]`, JSON.stringify({ sessionId, text: chunk })]);
            const query = `
                INSERT INTO rag_vectors (id, vector, metadata)
                VALUES ${values.map((_, i) => `($${i * 3 + 1}, $${i * 3 + 2}::vector, $${i * 3 + 3}::jsonb)`).join(", ")}
            `;
            await client.query(query, values.flat());
            return { success: true, chunkCount: chunks.length };
        } finally {
            // 关键：无论成功/失败，都释放连接
            if (client) {
                client.release();
            }
        }
    }

    // 智能判断是否需要检索上下文
    // 规则：关键词匹配 + AI 零样本分类
    public async classifyNeedRetrieval(params: ClassifyParams): Promise<boolean> {
        const { userQuery, chatHistorys = [] } = params;
        if (!userQuery) return false;

        if (RETRIEVAL_KEYWORDS.some((key) => userQuery.includes(key))) {
            return true;
        }

        await this.initialize();
        const context = `用户问题：${userQuery} | 历史对话：${JSON.stringify(chatHistorys)}`;
        const result = await this.classifyModel(context, ["需要检索上下文", "不需要检索"]);
        return result.labels[0] === "需要检索上下文";
    }

    // 向量相似度检索
    // 根据用户问题匹配当前会话最相关的上下文
    public async retrieveSessionContext(params: RetrieveParams): Promise<string[]> {
        const { sessionId, userQuery, topK = DEFAULT_TOP_K } = params;

        await this.initialize();
        const queryVector = await this.embeddingsInstance.embedQuery(userQuery);

        const client = await this.getDatabaseClient();
        try {
            const res = await client.query(
                `
                    SELECT metadata->>'text' AS text
                    FROM rag_vectors
                    WHERE metadata->>'sessionId' = $1
                    ORDER BY vector <-> $2::vector
                    LIMIT $3
                `,
                [sessionId, `[${queryVector.join(",")}]`, topK * 2],
            );

            return (
                res.rows
                    .map((row) => row.text)
                    .filter(Boolean)
                    .slice(0, topK) || []
            );
        } finally {
            // 关键：无论成功/失败，都释放连接
            if (client) {
                client.release();
            }
        }
    }

    // 检查当前会话是否存在向量数据
    // public async hasSessionVector(sessionId: string): Promise<boolean> {
    //     await this.initialize();
    //     const client = await this.getDatabaseClient();

    //     try {
    //         const res = await client.query("SELECT 1 FROM rag_vectors WHERE metadata->>'sessionId' = $1 LIMIT 1", [sessionId]);
    //         return res.rows.length > 0;
    //     } catch (error) {
    //         console.error("会话向量查询失败", error);
    //         return false;
    //     } finally {
    //         // 关键：无论成功/失败，都释放连接
    //         if (client) {
    //             client.release();
    //         }
    //     }
    // }

    // 清空指定会话的所有向量数据
    public async clearSession(sessionId: string) {
        const client = await this.getDatabaseClient();

        try {
            await client.query("DELETE FROM rag_vectors WHERE metadata->>'sessionId' = $1", [sessionId]);
            return { success: true, msg: "会话数据已清空" };
        } finally {
            // 关键：无论成功/失败，都释放连接
            if (client) {
                client.release();
            }
        }
    }

    // 核心对外接口：智能聊天
    // 整合存储、判断、检索全流程
    public async smartChat(params: SmartChatParams): Promise<ChatResult> {
        const { sessionId, userQuery, docs, chatHistorys = [], hasDocHistorys } = params;
        await this.initialize();

        // const hasVector = await this.hasSessionVector(sessionId);
        let needRetrieval: boolean;

        if (docs?.length) {
            needRetrieval = true;
            await this.storeSessionText({ sessionId, docs });
        } else if (!chatHistorys.length || !hasDocHistorys) {
            needRetrieval = false;
        } else {
            needRetrieval = await this.classifyNeedRetrieval(params);
        }
        const context = needRetrieval ? await this.retrieveSessionContext({ sessionId, userQuery }) : [];

        // 拼接大模型输入内容
        const promptDocs = context?.length ? `【参考文档】\n${context.map((item, i) => `文档片段${i + 1}：\n${item}`).join("\n\n")}\n\n` : "";
        const promptHistory = `【历史对话】\n${chatHistorys.map((h) => `【${h.role}】${h.content}`).join("\n")}\n\n`;
        const promptQuestion = `【用户问题】\n${userQuery}\n\n`;
        const ask = `请根据${promptDocs ? "参考文档和" : ""}历史对话，精准回答用户问题，不要编造。`;
        const prompt = `${promptDocs}${promptHistory}${promptQuestion}${ask}`;
        return { sessionId, needRetrieval, userQuery, prompt };
    }
}

//  ========== 单例导出 ========== //
// 全局单例实例
// 避免重复加载模型，提升性能
const nextRag = new NextBffRagTool();

nextRag.initialize();

export default nextRag;
```

###### 2.4.7.3.2 大模型流式响应解析器工厂

`/src/bff/lib/utils/modelStreamParser.ts`：

```ts
// ==================== 流式解析器工厂 ==================== //

// ==================== 大模型流式响应解析器工厂 ==================== //
// 作用：集中管理不同模型的流式响应解析逻辑，统一输出格式
// 扩展新模型：仅需实现对应解析器函数，并加入 parserMap 映射

import { SupportedModel } from "@/bff/lib/db/modelConfig";

/**
 * 解析器统一返回格式
 * @property content 解析出的纯文本片段
 * @property done 是否解析完成（[DONE]标识）
 */
export interface StreamParserResult {
    content: string; // 前端需要的纯文本内容
    done: boolean; // 是否结束解析
}

/**
 * 解析器函数接口（所有模型解析器必须遵循该接口）
 * @param chunk 流式返回的二进制数据块
 * @param decoder 文本解码器（复用避免重复创建）
 * @returns 解析结果数组（单chunk可能包含多个消息行）
 */
export type StreamParser = (chunk: Uint8Array, decoder: TextDecoder) => StreamParserResult[];

// ==================== 各模型解析器实现（隔离不同模型的解析逻辑） ==================== //

/**
 * DeepSeek 流式解析器（适配原有逻辑）
 * DeepSeek响应格式：data: {"choices":[{"delta":{"content":"xxx"}}]}
 */
const deepseekParser: StreamParser = (chunk, decoder) => {
    const results: StreamParserResult[] = [];
    // 解码二进制数据为字符串（stream: true 保留未完成的字符）
    const chunkStr = decoder.decode(chunk, { stream: true });
    // 按行分割（流式响应每行是一个消息）
    const lines = chunkStr.split("\n").filter((line) => line.trim() !== "");

    // console.log("lines", lines);

    for (const line of lines) {
        // 过滤非data开头的行（避免空行/注释行）
        if (!line.startsWith("data: ")) continue;
        // 移除前缀，获取纯JSON字符串
        const data = line.replace("data: ", "");

        // 处理结束标识
        if (data === "[DONE]") {
            results.push({ content: "", done: true });
            continue;
        }

        // 解析JSON并提取内容（异常容错）
        try {
            const json = JSON.parse(data);
            // 解析关键
            const content = json.choices?.[0]?.delta?.content || "";
            results.push({ content, done: false });
        } catch (e) {
            console.error(`[DeepSeek解析异常] ${(e as Error).message}，原始数据：${data}`);
            results.push({ content: "", done: false }); // 解析失败返回空内容，不中断流
        }
    }
    return results;
};

/**
 * 豆包流式解析器（适配豆包实际响应格式）
 * 豆包响应格式示例：data: {"delta":{"content":"xxx"}}
 */
const doubaoParser: StreamParser = (chunk, decoder) => {
    const results: StreamParserResult[] = [];
    const chunkStr = decoder.decode(chunk, { stream: true });
    const lines = chunkStr.split("\n").filter((line) => line.trim() !== "");

    // console.log("lines", lines);

    for (const line of lines) {
        if (!line.startsWith("data: ")) continue;
        const data = line.replace("data: ", "");

        if (data === "[DONE]") {
            results.push({ content: "", done: true });
            continue;
        }

        try {
            const json = JSON.parse(data);
            // 解析关键
            const content = json.choices?.[0]?.delta?.content || "";
            results.push({ content, done: false });
        } catch (e) {
            console.error(`[豆包解析异常] ${(e as Error).message}，原始数据：${data}`);
            results.push({ content: "", done: false });
        }
    }
    return results;
};

/**
 * 千问流式解析器（适配千问实际响应格式）
 * 千问响应格式示例：data: {"output":{"text":"xxx"}}
 */
const qwenParser: StreamParser = (chunk, decoder) => {
    const results: StreamParserResult[] = [];
    const chunkStr = decoder.decode(chunk, { stream: true });
    const lines = chunkStr.split("\n").filter((line) => line.trim() !== "");

    // console.log("lines", lines);

    for (const line of lines) {
        if (!line.startsWith("data: ")) continue;
        const data = line.replace("data: ", "");

        if (data === "[DONE]") {
            results.push({ content: "", done: true });
            continue;
        }

        try {
            const json = JSON.parse(data);
            // 解析关键
            const content = json.choices?.[0]?.delta?.content || "";
            results.push({ content, done: false });
        } catch (e) {
            console.error(`[千问解析异常] ${(e as Error).message}，原始数据：${data}`);
            results.push({ content: "", done: false });
        }
    }
    return results;
};

/**
 * 解析器工厂函数（根据模型类型获取对应解析器）
 * @param model 模型类型
 * @returns 该模型对应的解析器函数
 * @throws 未实现解析器时抛出错误
 */
export const getStreamParser = (model: SupportedModel): StreamParser => {
    // 解析器映射表（新增模型时，只需在这里添加映射）
    const parserMap: Record<SupportedModel, StreamParser> = {
        "deepseek-chat": deepseekParser,
        "doubao-seed-2-0-pro-260215": doubaoParser,
        "qwen3.6-plus-2026-04-02": qwenParser,
    };

    const parser = parserMap[model];
    if (!parser) {
        throw new Error(`[解析器异常] 未实现 ${model} 的流式解析器，请检查 modelStreamParser.ts`);
    }
    return parser;
};
```





#### 2.4.8 BFF 通用工具

`/src/bff/lib/utils/common-tools.ts`：

```ts
// ==================== 通用工具 ==================== //

// ========== React、Next、Utils ========== //
// ========== Components、CSS ========== //
// ========== Icon、Type ========== //
// ========== Stroe、Constants ========== //
// ========== Hooks ========== //
// ========== Services ========== //

// 工具函数：万能解析（永不报错）
export const parseJson = (str: string) => {
    try {
        if (!str) return [];
        const res = JSON.parse(str);
        return Array.isArray(res) ? res : [];
    } catch {
        return [];
    }
};
```

### 2.5 自动化部署

#### 2.5.1 CI/CD 脚本

`/.github/workflows/tai_deploy.yml`：

```yml
name: Deploy to Server

on:
    push:
        branches:
            - main

# 强制使用 Node.js 24，消除所有警告
env:
    FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true

# 只有3步：拉代码 → 配置SSH → 连服务器部署，完事！
jobs:
    deploy:
        runs-on: ubuntu-latest
        steps:
            - name: Checkout code
              uses: actions/checkout@v6

            - name: Install SSH key
              uses: webfactory/ssh-agent@v0.9.1
              with:
                  ssh-private-key: ${{ secrets.TAI_SSH_PRIVATE_KEY }}

            - name: Add known hosts
              run: ssh-keyscan ${{ secrets.TAI_SERVER_IP }} > ~/.ssh/known_hosts

            - name: Deploy to server
              run: |
                  ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -o ServerAliveCountMax=10 ${{ secrets.TAI_USER }}@${{ secrets.TAI_SERVER_IP }} << 'EOF'
                  export POSTGRES_DB="${{ secrets.POSTGRES_DB }}"
                  export POSTGRES_USER="${{ secrets.POSTGRES_USER }}"
                  export POSTGRES_PASSWORD="${{ secrets.POSTGRES_PASSWORD }}"
                  export POSTGRES_HOST=${{ secrets.POSTGRES_HOST }}
                  export POSTGRES_PORT=${{ secrets.POSTGRES_PORT }}
                  export DEEPSEEK_API_KEY="${{ secrets.DEEPSEEK_API_KEY }}"
                  export DOUBAO_API_KEY="${{ secrets.DOUBAO_API_KEY }}"
                  export QIANWEN_API_KEY="${{ secrets.QIANWEN_API_KEY }}"
                  export POSTGRES_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}"
                  bash /usr/local/src/tai/deploy.sh
                  EOF

```



#### 2.5.2 部署脚本

`/deploy.sh`：

```sh
#!/bin/bash
##############################################################################
# 项目一键部署脚本 (OpenCloudOS 9 / Next.js 服务端构建版)
# 功能：代码拉取 → 图片压缩 → Node环境安装 → 项目构建 → Docker部署
# 特性：严格错误捕获、失败立即退出、全流程可视化、适配GitHub Actions
##############################################################################

# ====================== 脚本核心配置：严格错误模式（必开） ======================
set -euo pipefail

# 定义固定常量
readonly PROJECT_DIR="/usr/local/src/tai"
readonly GIT_REPO_URL="https://github.com/templechan/tai.git"  # 仓库地址
readonly GIT_BRANCH="main"                    # 部署分支
readonly NODE_VERSION="v20.18.0"
readonly NODE_BIN_URL="https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz"

# ==============================================
# 【步骤 1/8】基础环境清理：删除旧项目目录
# ==============================================
echo -e "\033[1;34m[1/8] 初始化项目目录（保留缓存）...\033[0m"
mkdir -p "${PROJECT_DIR}"
cd "${PROJECT_DIR}"
echo -e "\033[1;32m✅ 项目目录准备完成\033[0m"

# ==============================================
# 【步骤 2/8】安装Git（如未安装）+ 配置用户信息
# ==============================================
echo -e "\033[1;34m[2/8] 检查并安装Git工具...\033[0m"
if ! command -v git &> /dev/null; then
    echo "未检测到Git，开始安装..."
    dnf install -y git
    git config --global user.email "templechan@126.com"
    git config --global user.name "templechan"
    echo -e "\033[1;32m✅ Git安装&配置完成\033[0m"
else
    echo -e "\033[1;32m✅ Git已存在，跳过安装\033[0m"
fi

# ==============================================
# 【步骤 3/8】克隆项目代码（核心步骤：失败直接 退出）
# ==============================================
# 配置GitHub国内加速镜像（解决拉取慢/失败）
echo -e "\033[1;34m[3/7] 配置镜像并拉取项目代码...\033[0m"
git config --global url."https://gh.sevencdn.com/".insteadOf https://
# git config --global url."https://ghproxy.net/".insteadOf https://
# 如果失效，则删除旧的，设置的新的，记得先测试下是否有效
# git config --global --unset url."https://gh.sevencdn.com/".insteadOf https://

# 首次部署=克隆，后续=增量更新
if [ ! -d ".git" ]; then
    # 核心：克隆代码，失败直接退出脚本，Actions标记部署失败
    echo -e "\033[1;34m[3/8] 正在拉取GitHub代码（main分支）...\033[0m"
    if ! git clone -b "${GIT_BRANCH}" "${GIT_REPO_URL}" "${PROJECT_DIR}"; then
        echo -e "\033[1;31m❌ 代码拉取失败！部署终止\033[0m"
        exit 1
    fi
else
    git stash push -m "auto stash"
    git pull origin main
fi
echo -e "\033[1;32m✅ 代码拉取成功\033[0m"

# 进入项目目录（克隆成功才会执行）
cd "${PROJECT_DIR}"

# ==============================================
# 【步骤 4/8】安装图片压缩依赖（ImageMagick）
# ==============================================
echo -e "\033[1;34m[4/8] 检查并安装图片压缩工具...\033[0m"
if ! command -v mogrify &> /dev/null; then
    echo "安装ImageMagick+依赖包..."
    dnf install -y ImageMagick bc parallel
    sed -i '/<policy domain="coder" rights=".*" pattern="PNG,JPG,JPEG,WEBP"/d;/<policymap>/a \  <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />;s/<policy domain="resource" name="memory" value="[^"]*"/<policy domain="resource" name="memory" value="256MiB"/;s/<policy domain="resource" name="disk" value="[^"]*"/<policy domain="resource" name="disk" value="1GiB"/;s/<policy domain="resource" name="width" value="[^"]*"/<policy domain="resource" name="width" value="8KP"/;s/<policy domain="resource" name="height" value="[^"]*"/<policy domain="resource" name="height" value="8KP"/;s/<policy domain="resource" name="thread" value="[^"]*"/<policy domain="resource" name="thread" value="2"/;s/<policy domain="resource" name="throttle" value="[^"]*"/<policy domain="resource" name="throttle" value="1"/;s/<policy domain="resource" name="map" value="[^"]*"/<policy domain="resource" name="map" value="256MiB"/' /etc/ImageMagick-7/policy.xml
    echo -e "\033[1;32m✅ 图片压缩工具安装完成\033[0m"
else
    echo -e "\033[1;32m✅ 图片压缩工具已存在，跳过安装\033[0m"
fi

# ==============================================
# 【步骤 5/8】自动批量压缩项目图片
# ==============================================
# 进度交互版
# start=$SECONDS; find ./public/assets/images/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 2 --bar 'f="{}";old_size=$(stat -c %s "$f");if [ $old_size -gt 102400 ]; then q=$(echo "scale=0;80-40*l($old_size/102400)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<15?15:q>60?60:q));ext="${f##*.}";case "$ext" in png) mogrify -strip -quality $q -define png:compression-level=9 -colors 128 "$f" 2>/dev/null ;; jpg|jpeg) mogrify -strip -quality $q -sampling-factor 4:2:0 -density 72x72 "$f" 2>/dev/null ;; webp) mogrify -strip -quality $((q-5)) -define webp:method=6 "$f" 2>/dev/null ;; esac;new_size=$(stat -c %s "$f");save=$((old_size-new_size));echo "$save" >> /tmp/img_save.txt;fi'; touch /tmp/img_save.txt; total_save=$(awk '{sum+=$1}END{print sum+0}' /tmp/img_save.txt 2>/dev/null); count=$(wc -l < /tmp/img_save.txt 2>/dev/null); rm -f /tmp/img_save.txt; cost=$((SECONDS - start)); min=$((cost / 60)); sec=$((cost % 60)); echo -e "\n\033[1;32m=== 压缩完成 ===\033[0m"; echo "✅ 压缩数量：${count:-0} 张"; echo "✅ 节省空间：$((total_save/1024)) KB ($((total_save/1024/1024)) MB)"; echo -e "✅ 耗时：${min}分${sec}秒"; echo -e "\033[1;32m================\033[0m"
echo -e "\033[1;34m[5/8] 开始自动压缩项目图片资源...\033[0m"
start=$SECONDS
touch /tmp/img_save.txt
find ./public/assets/images/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 2 'f="{}";old_size=$(stat -c %s "$f");if [ $old_size -gt 102400 ]; then q=$(echo "scale=0;80-40*l($old_size/102400)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<15?15:q>60?60:q));ext="${f##*.}";case "$ext" in png) mogrify -strip -quality $q -define png:compression-level=9 -colors 128 "$f" 2>/dev/null ;; jpg|jpeg) mogrify -strip -quality $q -sampling-factor 4:2:0 -density 72x72 "$f" 2>/dev/null ;; webp) mogrify -strip -quality $((q-5)) -define webp:method=6 "$f" 2>/dev/null ;; esac;new_size=$(stat -c %s "$f");save=$((old_size-new_size));echo "$save" >> /tmp/img_save.txt;fi' 2>/dev/null

total_save=$(awk '{sum+=$1}END{print sum+0}' /tmp/img_save.txt 2>/dev/null)
count=$(wc -l < /tmp/img_save.txt 2>/dev/null)
rm -f /tmp/img_save.txt
cost=$((SECONDS-start))
min=$((cost/60))
sec=$((cost%60))

echo -e "\033[1;32m=== 图片压缩完成 ===\033[0m"
echo -e "压缩数量：${count:-0} 张"
echo -e "节省空间：$((total_save/1024)) KB ($((total_save/1024/1024)) MB)"
echo -e "耗时：${min}分${sec}秒"
echo -e "\033[1;32m====================\033[0m"

# ==============================================
# 【步骤 6/8】安装Node.js + pnpm
# ==============================================
echo -e "\033[1;34m[6/8] 检查并安装Node.js运行环境...\033[0m"
if ! command -v node &> /dev/null; then
    echo "安装官方Node.js ${NODE_VERSION}..."
    curl -fsSL "${NODE_BIN_URL}" -o node.tar.xz
    tar -xf node.tar.xz --strip-components=1 -C /usr/local
    rm -f node.tar.xz
    echo -e "\033[1;32m✅ Node.js安装完成\033[0m"
else
    echo -e "\033[1;32m✅ Node.js已存在，跳过安装\033[0m"
fi

echo "安装pnpm包管理器..."
npm install -g pnpm --force
echo -e "\033[1;32m✅ pnpm安装完成\033[0m"

# ==============================================
# 【步骤 7/8】项目构建
# ==============================================
echo -e "\033[1;34m[7/8] 开始构建Next.js项目...\033[0m"
export SHARP_DOWNLOAD_BINARY=true
export SKIP_DB_INIT=true

echo "安装项目依赖..."
pnpm approve-builds --all
pnpm install --frozen-lockfile

echo "开始生产构建（静默模式，解除阻塞）..."
# 关闭Next.js终端动画 + 静默输出，彻底解决SSH卡住
export NEXT_TELEMETRY_DISABLED=1
export NEXT_DISABLE_TERMINAL_OUTPUT=1
pnpm build >/dev/null 2>&1 || true
sync && echo -e "\n"

echo -e "\033[1;32m✅ 项目构建完成\033[0m"

# ==============================================
# 【步骤 8/8】Docker环境配置 + 启动
# ==============================================
echo -e "\033[1;34m[8/8] 检查并配置Docker容器环境...\033[0m"
if ! command -v docker &> /dev/null; then
    echo "卸载旧版Docker组件..."
    dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

    echo "启用系统软件仓库..."
    sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/OpenCloudOS.repo
    dnf clean all && dnf makecache

    echo "配置阿里云Docker镜像源..."
    dnf install -y dnf-plugins-core
    dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

    echo "安装Docker引擎..."
    dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "启动Docker并设置开机自启..."
    systemctl start docker
    systemctl enable docker
    echo -e "\033[1;32m✅ Docker安装完成\033[0m"
else
    echo -e "\033[1;32m✅ Docker已存在，跳过安装\033[0m"
fi

echo "配置Docker镜像代理..."
tee /etc/docker/daemon.json <<EOF
{
"registry-mirrors": [
    "https://docker.1ms.run",
    "https://dockerproxy.net",
    "https://proxy.vvvv.ee",
    "https://dockerproxy.link"
]
}
EOF
systemctl daemon-reload
echo -e "\033[1;32m✅ Docker镜像配置完成\033[0m"

echo -e "\033[1;34m正在启动项目服务...\033[0m"
docker compose up -d --build

echo -e ""
echo -e "============================================================"
echo -e "\033[1;32m🎉 项目部署全部完成！服务已后台运行\033[0m"
echo -e "============================================================"

# 强制返回0退出码，告诉GitHub Actions：部署成功
exit 0
```

#### 2.5.3 Docker 文件

`/Dockerfile`：

```dockerfile
# 运行阶段
FROM node:20-slim
WORKDIR /app

COPY ./.next/standalone ./
COPY ./.next/static ./.next/static
COPY ./public ./public

# 安装缺失的onnx运行库
RUN apt-get update && apt-get install -y --no-install-recommends wget && \
    wget --no-check-certificate https://ghproxy.net/https://github.com/microsoft/onnxruntime/releases/download/v1.14.0/onnxruntime-linux-x64-1.14.0.tgz && \
    tar -zxvf onnxruntime-linux-x64-1.14.0.tgz && \
    cp onnxruntime-linux-x64-1.14.0/lib/libonnxruntime.so.1.14.0 /usr/local/lib/ && \
    ldconfig && \
    rm -rf onnxruntime-linux-x64-1.14.0* && \
    apt-get purge -y wget && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=production
ENV PORT=91
# EXPOSE 3000

CMD ["node", "server.js"]
```

`/docker-compose.yml`：

```yml
services:
    tai:
        # 等价于 docker build -t tai . （自动构建当前目录的Dockerfile）
        build: .
        image: tai:latest
        container_name: tai
        # 开机/崩溃自动重启
        restart: always
        environment:
            # 直接读取系统环境变量（从 GitHub Secrets 传递过来）
            # 数据库配置
            - POSTGRES_URL=${POSTGRES_URL}
            # API密钥
            - DEEPSEEK_API_KEY=${DEEPSEEK_API_KEY}
            - DOUBAO_API_KEY=${DOUBAO_API_KEY}
            - QIANWEN_API_KEY=${QIANWEN_API_KEY}
        volumes:
            - ./tmp/.cache:/app/tmp/.cache
        # 等待数据库启动后再启动应用
        depends_on:
            - db
        # 加入Docker内部网络，互通
        networks:
            - app-network
        # 端口映射 主机91 → 容器91
        ports:
            - "91:91"
    # ======================
    # PostgreSQL + pgvector 数据库（自带插件）
    # ======================
    db:
        # 官方镜像，内置 pgvector 插件，开箱即用
        image: ankane/pgvector:latest
        container_name: ankane-pgvector
        restart: always
        # 加载环境变量
        environment:
            # 直接读取系统环境变量
            - POSTGRES_DB=${POSTGRES_DB}
            - POSTGRES_USER=${POSTGRES_USER}
            - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
        volumes:
            - postgres_data:/var/lib/postgresql/data
        # 可选：暴露端口给本地数据库工具连接（调试用）
        ports:
            - "5432:5432"
        networks:
            - app-network
# Docker 内部网络（应用和数据库互通）
networks:
    app-network:
        driver: bridge
# 数据库持久化卷
volumes:
    postgres_data:

```