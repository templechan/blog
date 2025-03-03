---
layout: post
title: "JS批量取消抖音关注脚本"
description: "支持 白名单 和 数量 控制，取消关注 1000 人大约需要 1 小时。"
author: "谌中钱"
date: "2025-03-03"
image: "/img/temple-404-bg.png"
categories: [ "Solutions" ]
---

<br />
<br />

- [源代码](#源代码)

# 源代码

> 支持 白名单 和 数量 控制，取消关注 1000 人大约需要 1 小时。

```javascript
/**
 * 批量取消抖音关注
 * 
 * @function batchUnfollow
 * @param (Array) whiteList - 白名单，存放忽略的用户名称（最好直接从关注列表复制出来）
 * @param (Number) nums - 取消关注数量，0 为无限制
 * @author 谌中钱
 * @email templechan@126.com
 * @date 2025-03-03
 * @notes 1. 需要登录到抖音创造中心（https://creator.douyin.com/），找到 互动管理 -> 关注管理，在页面上鼠标右键检查 -> 控制台，复制输入下面的 JS 脚本，回车即可
 * @notes 2. 如果抖音创造中心页面结构发生更新，则需要自行修改脚本，只保证脚本构建时有效
 * @notes 3. 中途会偶尔频繁访问报错，不必理会，过几分钟频繁解除后脚本会继续进行
 */

// 依赖管理
let scriptElement = document.createElement("script");

scriptElement.src = "https://code.jquery.com/jquery-3.7.1.min.js";
let jQueryScript = scriptElement;

let scripts = [jQueryScript];
scripts.forEach(script => document.head.appendChild(script));

// 白名单设置
// let whiteList = ["pp小公举", "归南"];
let whiteList = [];
// 取消关注数量，0 为无限制
let nums = 0;

let batchUnfollow = (whiteList = [], nums = 0) => {
    const startTime = new Date().getTime();
    let isStop = false;
    let cancelNums = 0;
    
    console.log("取消关注人数：", nums ? (nums + " 人") : "无限制");
    console.log("脚本启动 ", " ...");
    
    let timerId = setInterval(function () {
        // 找到关注列表的用户，并点击取消关注按钮，显示出确认弹窗
        let userContent = undefined;
        let user = undefined;
        let isNewCancelUser = false;
        let userName = "";

        if (whiteList.length != "") {
            userContent = $('.semi-table-row-cell');
            for (let i = 0; i < userContent.length; i++) {
                userName = userContent[i].children[1]?.innerHTML;
                if (userName) {
                    if (!whiteList.includes(userName)) {
                        user = userContent[i + 2]?.children[0];
                        // 再次确认
                        if (user?.innerHTML === "取消关注") {
                            user.click();
                            isNewCancelUser = true;
                            break;
                        }
                    }
                }
            }
            // 翻页
            if (!isNewCancelUser) {
                let nextPageElement = $('.semi-button')[1];
                if (nextPageElement.classList.contains("semi-button-primary")) {
                    nextPageElement.click();
                    isNewCancelUser = true;
                }
            }
        } else {
            userContent = $('.semi-table-row-cell a');
            for (let i = 0; i < userContent.length; i++) {
                user = userContent[i];
                if (user.innerHTML === "取消关注") {
                    user.click();
                    isNewCancelUser = true;
                    break;
                }
            }
        }
        
        // 找到确认弹窗的确认按钮，并点击，完成取消操作
        let buttons = $('.semi-button-content');
        [...buttons].forEach(button => {
            if (button.innerHTML === "确认") {
                button.click();
                cancelNums++;
                console.log("取消关注 ", userName || (cancelNums + "号 "), " ...");
            }
        });


        if (!isNewCancelUser || (nums !== 0 && cancelNums + 1 >= nums)) {
            if (isStop) {
                clearInterval(timerId);
                console.log("批量取消关注完成，取消关注人数：" + cancelNums +  " 人，耗时：", ((new Date().getTime() - startTime) / (1000 * 60)).toFixed(2), " 分钟");
            }
            isStop = true;
        }
    }, 5000); // 5秒执行一次，减少频繁访问报错
};

batchUnfollow(whiteList, nums);
```
