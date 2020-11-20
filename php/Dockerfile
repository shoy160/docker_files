FROM slpcat/nginx-php7.1:alpine

WORKDIR /app

COPY . .

COPY vhost.conf /opt/docker/etc/nginx/vhost.conf

EXPOSE 8081 8082 8083
