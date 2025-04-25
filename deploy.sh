cd /usr/local/src
rm -rf /usr/local/src/blog

if [ ! "$(command -v git)" ]; then
    dnf install -y git
    git config --global user.email "templechan@126.com"
    git config --global user.name "templechan"
    # 设置 GitHub 国内镜像源
    git config --global url."https://bgithub.xyz/".insteadOf https://github.com/
fi

git clone -b main https://github.com/templechan/blog.git

if [ -d /usr/local/src/blog ]; then
    cd /usr/local/src/blog
    if [ ! "$(command -v pngquant)" ]; then
        dnf install -y pngquant
    fi
    # 手动压缩图片资源（会覆盖源文件，注意保留源文件，同一个文件多次压缩会严重失真）
    # 压缩规则: 超过 1MB 的图片才会压缩
    find ./static/img/ -name "*.png" -type f -exec bash -c 'for f; do size=$(stat -c%s "$f"); [ $size -gt 1000000 ] && q=$((50-(size/10000))) && q=$((q<5?5:q)) && pngquant --ext .png --force --quality 5-${q} "$f"; done' _ {} +

    if [ ! "$(docker ps -a -f "name=blog" --quiet)" ]; then
        if [ ! "$(docker images -q blog)" ]; then
            # 构建镜像
            docker build -t blog .
        fi
        # 创建并运行容器
        docker run -d --restart=always -p 81:80 -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static -v ./public:/blog/public --name blog blog
    else
        docker restart blog
    fi
    # Nginx 如果配置好了，可直接访问网站查看部署更新
fi