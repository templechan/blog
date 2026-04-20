# 阶段1：Hugo 构建环境（临时镜像，用完丢弃）
FROM hugomods/hugo:std-base-0.159.0 AS builder
WORKDIR /app
COPY . .
RUN hugo --minify

# 阶段2：生产运行环境（仅保留静态文件 + Nginx，超小体积）
FROM nginx:alpine-slim
COPY --from=builder /app/public/ /usr/share/nginx/html/
EXPOSE 80
