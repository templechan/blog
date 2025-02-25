FROM hugomods/hugo
RUN hugo new site blog
WORKDIR /blog
# 不适用于Docker部署
# CMD ["hugo", "server", "--bind", "0.0.0.0", "-b", "http://212.64.16.86", "-p", "81"]
# 功能性容器
CMD ["hugo"]