FROM nginx:alpine

COPY conf/. /etc/nginx/

RUN mkdir /app && cp /usr/share/nginx/html/* /app/

#修改时区
ENV TZ=Asia/Shanghai

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add -U tzdata && \
    apk add --no-cache nginx-mod-http-lua && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

WORKDIR /app