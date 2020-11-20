FROM nginx:alpine

COPY conf/. /etc/nginx/

RUN mkdir /app && cp /usr/share/nginx/html/* /app/

#修改时区
ENV TZ=Asia/Shanghai

RUN apk add -U tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

WORKDIR /app