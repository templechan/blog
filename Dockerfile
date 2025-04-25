FROM hugomods/hugo:std-base-0.146.7
RUN hugo new site blog
WORKDIR /blog
# 212.64.16.86 为 云服务器 的 公网IP
# 这里不能使用域名，否则 Hugo 生成的 动态链接 会变成 https://域名:80，导致 端口 重复，文章跳转会出错
CMD ["hugo", "server", "--baseURL", "http://212.64.16.86", "-p", "80"]
