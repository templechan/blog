cd /usr/local/src
rm -rf /usr/local/src/blog

if ! command -v git &> /dev/null; then
    dnf install -y git
    git config --global user.email "templechan@126.com"
    git config --global user.name "templechan"
    # 设置 GitHub 国内镜像源
    git config --global url."https://bgithub.xyz/".insteadOf https://github.com/
    # 如果失效，则删除旧的，设置的新的，记得先测试下是否有效
    # git config --global --unset url."https://bgithub.xyz/".insteadOf https://github.com/
    # git config --global url."https://kkgithub.com/".insteadOf https://github.com/
fi

git clone -b main https://github.com/templechan/blog.git

if [ -d /usr/local/src/blog ] && [ -n "$(ls -A /usr/local/src/blog)" ]; then
    cd /usr/local/src/blog
    if ! command -v mogrify &> /dev/null; then
        # 安装图片压缩包 ImageMagick
        dnf install -y ImageMagick bc parallel
        # 配置ImageMagick策略文件
        sed -i '/<policy domain="coder" rights="read|write"/!b;n;c\ \ <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="memory"/s/value=".*"/value="1GiB"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="disk"/s/value=".*"/value="4GiB"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="width"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="height"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
    fi

    # 手动压缩图片资源（会覆盖源文件，注意保留源文件）
    # 压缩规则: 
    # 1. 超过 512KB 的图片才会压缩
    # 2. 根据 图片大小 动态控制压缩比例，最后都控制在 300KB 左右
    # 3. 可压缩 PNG,JPG,JPEG,WEBP 的图片
    find ./static/img/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 4 --bar 'f="{}";s=$(stat -c %s "$f");if [ $s -gt 512000 ];then q=$(echo "scale=0;60-30*l($s/512000)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<10?10:q>75?75:q));case "${f##*.}" in png) p="-quality $((q-25)) -define png:compression-level=9 -colors 128" ;; jpg|jpeg) p="-quality $((q-10)) -sampling-factor 4:2:0" ;; webp) p="-quality $((q-20)) -define webp:method=6" ;; esac;mogrify $p "$f";fi'
    
    if ! command -v docker &> /dev/null; then
        # 卸载旧版 Docker
        dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
        # 自动启用仓库
        sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/OpenCloudOS.repo
        # 保存后，清除重建缓存
        dnf clean all && dnf makecache

        # 设置 Docker 国内软件源
        dnf install -y dnf-plugins-core
        # dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

        # 安装 Docker
        dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        # 设置 Docker 国内镜像代理
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

        # 启动 Docker
        systemctl start docker
        # 设置 Docker 自启
        systemctl enable docker
    fi

    if [ "$(docker ps -a -f "name=blog" --quiet)" ]; then
        docker rm blog
    fi
    if [ "$(docker images -q blog)" ]; then
        docker rmi blog
    fi

    docker compose up -d
fi