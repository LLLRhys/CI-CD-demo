# 构建阶段，Dockerfile支持多阶段构建
# AS XXX 可以给阶段起一个名字，后续可以通过这个名字来引用这个阶段
FROM golang:1.24.13-alpine3.23 AS builder

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o app

# 运行阶段（更轻量），多阶段构建，最后的镜像只保留最后一段构建的结果
FROM alpine:3.23

WORKDIR /app
COPY --from=builder /app/app .
COPY --from=builder /app/static ./static

EXPOSE 8080

CMD ["./app"]