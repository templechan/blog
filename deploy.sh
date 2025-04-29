cd /usr/local/src
rm -rf /usr/local/src/blog

if [ ! "$(command -v git)" ]; then
    dnf install -y git
    git config --global user.email "templechan@126.com"
    git config --global user.name "templechan"
    # 设置 GitHub 国内镜像源
    # git config --global url."https://bgithub.xyz/".insteadOf https://github.com/
fi

# 如果失效，则删除旧的，设置的新的
# git config --global --unset url."https://bgithub.xyz/".insteadOf https://github.com/
# git config --global url."https://kkgithub.com/".insteadOf https://github.com/
git clone -b main https://github.com/templechan/blog.git

if [ -d /usr/local/src/blog ]; then
    cd /usr/local/src/blog
    if [ ! "$(command -v mogrify)" ]; then
        # 安装图片压缩包 ImageMagick
        dnf install -y ImageMagick-7.1.1.26-2.oc9 bc parallel
        # 配置ImageMagick策略文件
        sed -i '/<policy domain="coder" rights="read|write"/!b;n;c\ \ <policy domain="coder" rights="read|write" pattern="PNG,JPG,JPEG,WEBP" />' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="memory"/s/value=".*"/value="1GiB"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="disk"/s/value=".*"/value="4GiB"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="width"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
        sed -i '/<policy domain="resource" name="height"/s/value=".*"/value="32KP"/' /etc/ImageMagick-7/policy.xml
    fi

    # 手动压缩图片资源（会覆盖源文件，注意保留源文件）
    # 压缩规则: 
    # 1. 超过 500KB 的图片才会压缩
    # 2. 根据 图片大小 动态控制压缩比例，最后都控制在 300KB 左右
    # 3. 可压缩 PNG,JPG,JPEG,WEBP 的图片
    find ./static/img/ \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \) -type f -print0 | parallel -0 -j 4 --bar 'f="{}";s=$(stat -c%s "$f");if [ $s -gt 512000 ];then q=$(echo "scale=0;60-30*l($s/512000)/l(10)" | bc -l | awk "{print int(\$1+0.5)}");q=$((q<10?10:q>75?75:q));case "${f##*.}" in png) p="-quality $((q-25)) -define png:compression-level=9 -colors 128" ;; jpg|jpeg) p="-quality $((q-10)) -sampling-factor 4:2:0" ;; webp) p="-quality $((q-20)) -define webp:method=6" ;; esac;mogrify $p "$f";fi'
    

    if [ ! "$(docker ps -a -f "name=blog" --quiet)" ]; then
        if [ ! "$(docker images -q blog)" ]; then
            # 构建镜像
            docker build -t blog .
        fi
        # 创建并运行容器
        docker run -d --restart=always -p 81:80 -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static -v ./public:/blog/public -v ./static/sitemap/:/blog/public/*.xml --name blog blog
    else
        docker restart blog
    fi

    # 等待 5 秒，确保容器已启动
    sleep 5
    # 修复 RSS
    sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/index.xml
    sed -i 's#http://212.64.16.86:80#https://blog.climbtw.com#g' ./public/sitemap.xml
    # 修复站点的动态链接
    sed -i 's#http://212\.64\.16\.86:80#https://blog.climbtw.com#g' \
    ./public/index.html \
    ./public/categories/solutions/index.html \
    ./public/categories/tech/index.html

    # 推送索引到 Algolia
    # 检查 npm 是否存在
    if ! command -v npm &> /dev/null; then
        # 下载并安装 nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

        # 加载 nvm（确保当前 shell 环境能使用 nvm）
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        nvm install 20.19.1
        nvm use 20.19.1

        if ! npm list atomic-algolia --depth=0 2>/dev/null | grep -q atomic-algolia; then
            npm install atomic-algolia
        fi
        npx atomic-algolia
    fi

    # Nginx 如果配置好了，可直接访问网站查看部署更新
fi