#!/bin/bash
##############################################################################
# 个人项目一键部署脚本 (OpenCloudOS 9 / Hexo/Hugo 静态博客版)
# 功能：代码拉取 → 图片压缩 → Docker环境配置 → 容器部署
# 特性：严格错误中断、失败即退出、可视化流程、兼容GitHub Actions
##############################################################################

# ====================== 脚本核心配置：严格错误模式（必开） ======================
# 任意命令失败/变量未定义/管道错误，立即终止脚本，保证部署状态准确
set -euo pipefail

# 定义固定常量（统一管理，方便修改）
readonly PROJECT_DIR="/usr/local/src/blog"    # 项目目录
readonly GIT_REPO_URL="https://github.com/templechan/blog.git"  # 仓库地址
readonly GIT_BRANCH="main"                    # 部署分支

# ==============================================
# 【步骤 1/7】基础环境清理：删除旧项目目录
# ==============================================
echo -e "\033[1;34m[1/8] 初始化项目目录（保留缓存）...\033[0m"
mkdir -p "${PROJECT_DIR}"
cd "${PROJECT_DIR}"
echo -e "\033[1;32m✅ 项目目录准备完成\033[0m"

# ==============================================
# 【步骤 2/7】安装Git（如未安装）+ 配置用户信息
# ==============================================
echo -e "\033[1;34m[2/7] 检查并安装Git工具...\033[0m"
if ! command -v git &> /dev/null; then
    echo "未检测到Git，开始安装..."
    dnf install -y git
    # 配置Git全局用户信息
    git config --global user.email "templechan@126.com"
    git config --global user.name "templechan"
    echo -e "\033[1;32m✅ Git安装&配置完成\033[0m"
else
    echo -e "\033[1;32m✅ Git已存在，跳过安装\033[0m"
fi

# ==============================================
# 【步骤 3/7】配置GitHub国内镜像 + 克隆代码
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
# 【步骤 4/7】安装图片压缩工具（ImageMagick）
# ==============================================
echo -e "\033[1;34m[4/7] 检查并安装图片压缩工具...\033[0m"
if ! command -v mogrify &> /dev/null; then
    echo "安装ImageMagick+压缩依赖..."
    dnf install -y ImageMagick bc parallel
    # 配置图片读写权限+资源限制策略
    sed -i '/<policy domain="coder" rights=".*" pattern="PNG,JPG,JPEG,WEBP"/d;/<policymap>/a \  <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />;s/<policy domain="resource" name="memory" value="[^"]*"/<policy domain="resource" name="memory" value="256MiB"/;s/<policy domain="resource" name="disk" value="[^"]*"/<policy domain="resource" name="disk" value="1GiB"/;s/<policy domain="resource" name="width" value="[^"]*"/<policy domain="resource" name="width" value="8KP"/;s/<policy domain="resource" name="height" value="[^"]*"/<policy domain="resource" name="height" value="8KP"/;s/<policy domain="resource" name="thread" value="[^"]*"/<policy domain="resource" name="thread" value="2"/;s/<policy domain="resource" name="throttle" value="[^"]*"/<policy domain="resource" name="throttle" value="1"/;s/<policy domain="resource" name="map" value="[^"]*"/<policy domain="resource" name="map" value="256MiB"/' /etc/ImageMagick-7/policy.xml
    echo -e "\033[1;32m✅ 图片压缩工具安装完成\033[0m"
else
    echo -e "\033[1;32m✅ 图片压缩工具已存在，跳过安装\033[0m"
fi

# ==============================================
# 【步骤 5/7】自动批量压缩项目图片（适配Actions无交互版）
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
# 【步骤 6/7】安装/配置Docker环境 + 国内镜像加速
# ==============================================
echo -e "\033[1;34m[6/7] 检查并配置Docker容器环境...\033[0m"
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

# 配置Docker国内镜像加速（解决拉取镜像慢）
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
# 重载Docker配置
systemctl daemon-reload
echo -e "\033[1;32m✅ Docker镜像配置完成\033[0m"

# ==============================================
# 【步骤 7/7】清理旧容器/镜像 + 启动项目服务
# ==============================================
echo -e "\033[1;34m[7/7] 清理旧服务并启动项目...\033[0m"

# 构建并后台启动容器
docker compose up -d --build

# ==============================================
# 部署完成：全流程成功结束
# ==============================================
echo -e ""
echo -e "============================================================"
echo -e "\033[1;32m🎉 项目部署全部完成！服务已运行\033[0m"
echo -e "============================================================"


# 强制返回0退出码，告诉GitHub Actions：部署成功
exit 0