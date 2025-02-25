cd /usr/local/src
rm -rf /usr/local/src/blog
dnf install -y git
git config --global user.email "templechan@126.com"
git config --global user.name "templechan"
# 使用 ssh 克隆会快一些
git clone -b main git@github.com:templechan/blog.git

# 手动压缩图片资源（会覆盖源文件，注意保留源文件，同一个文件多次压缩会严重失真）
# 也可指定具体文件名压缩
dnf install -y ImageMagick
mogrify -resize 20% -quality 70 ./static/img/*.{png}

# 删除容器
docker stop blog && docker rm blog
# 删除镜像
docker rmi blog
# 构建镜像
docker build -t blog .
# 创建并运行容器
# 不适用于Docker部署
# docker run -d --restart=always -p 80:81 -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static --name blog blog
# 功能性容器
docker run -d -v ./themes:/blog/themes -v ./hugo.toml:/blog/hugo.toml -v ./content:/blog/content -v ./static:/blog/static -v ./public:/blog/public --name blog blog 

# Nginx 如果配置好了，可直接访问网站查看部署更新