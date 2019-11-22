#开源API网关Kong

-----

> Kong 是一个在 Nginx 运行的 Lua 应用程序，由 lua-nginx-module 实现。Kong 和 OpenResty 一起打包发行，其中已经包含了 lua-nginx-module。OpenResty 不是 Nginx 的分支，而是一组扩展其功能的模块。

#### 1. 两个主要组件

- Kong Server，基于 nginx 的服务器，用来接收 API 请求。
- Apache Cassandra，用来存储操作数据。

#### 2. 安装部署 (测试环境：http://konga.local/#!/dashboard, host : 192.168.0.231 konga.local)，当前版本：v1.3.0

#### a. 基础安装 (Docker为例)

Kong 支持多种常见的操作环境下安装部署， 如： CentOS，Debian，Ubuntu，Docker，K8S 等，安装详情参见官方文档 [Kong 各环境安装部署](https://konghq.com/install/)，支持数据库模式和非数据库模式部署。

以 Docker 为例部署脚本

- 数据库模式

```
# 创建kong专属网络
> docker network create kong-net
# 创建数据库
>docker run -d --name kong-database \
    --network=kong-net \
    -p 5432:5432 \
    -e "POSTGRES_USER=kong" \
    -e "POSTGRES_DB=kong" \
    postgres:9.6

# 初始化数据
> docker run --rm \
    --network=kong-net \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    kong:latest kong migrations bootstrap

# 运行Kong
# 端口：8000 Http，8443 Https,8001 Admin API Http,8444 Admin API https
> docker run -d --name kong \
     --network=kong-net \
     -e "KONG_DATABASE=postgres" \
     -e "KONG_PG_HOST=kong-database" \
     -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 8001:8001 \
     -p 8444:8444 \
     kong:latest
```

- 文件存储模式

```
# 创建专属网络
> docker network create kong-net

# 创建Docker卷
> docker volume create kong-vol

# 查看卷
> docker volume inspect kong-vol

# 运行Kong,kong.yml为配置文件
# 端口：8000 Http，8443 Https,8001 Admin API Http,8444 Admin API https
> docker run -d --name kong \
     --network=kong-net \
     -v "kong-vol:/usr/local/kong/declarative" \
     -e "KONG_DATABASE=off" \
     -e "KONG_DECLARATIVE_CONFIG=/usr/local/kong/declarative/kong.yml" \
     -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
     -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
     -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
     -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
     -p 8000:8000 \
     -p 8443:8443 \
     -p 8001:8001 \
     -p 8444:8444 \
     kong:latest
```

##### b. kong 仪表板

```
# konga (推荐)
> docker run -p 1337:1337
    --network {{kong-network}} \ // optional
    -e "TOKEN_SECRET={{somerandomstring}}" \
    -e "DB_ADAPTER=the-name-of-the-adapter" \ // 'mongo','postgres','sqlserver'  or 'mysql'
    -e "DB_HOST=your-db-hostname" \
    -e "DB_PORT=your-db-port" \ // Defaults to the default db port
    -e "DB_USER=your-db-user" \ // Omit if not relevant
    -e "DB_PASSWORD=your-db-password" \ // Omit if not relevant
    -e "DB_DATABASE=your-db-name" \ // Defaults to 'konga_database'
    -e "DB_PG_SCHEMA=my-schema"\ // Optionally define a schema when integrating with prostgres
    -e "NODE_ENV=production" \ // or 'development' | defaults to 'development'
    --name konga \
    pantsel/konga

# kong-dashboard
> docker run --name=kong-dashboard -p 8080:8080 pgbi/kong-dashboard start \
  --kong-url http://kong:8001
  --basic-auth user1=password1 user2=password2
```

#### 3. 基础功能(konga为例)

![Konga菜单](https://www.tapd.cn/tfl/captures/2019-10/tapd_personalword_1122492131001000980_base64_1571022295_46.png)

__应用级菜单__
1. Connections Kong连接，用于配置Kong的AdminAPI地址，配置成功之后，将会开启Kong级菜单。
2. Snapshots 快照，用于存储Kong节点快照，可快速恢复节点配置。

__API网关菜单__
1. Consumers API网关消费者，用于各类认证以及限流控制等;
2. Services 服务，用于配置上游服务的信息，主要包括服务名称、上游的Host以及Port等;
3. Routes 路由，用于配置下游的路由信息，定义服务的出口路径，主要包括路由名称、Host、Path、Methods以及Http/Https等;
4. Plugins 插件,可配置于Service或Route,主要包括认证、安全、限流、监控、日志以及自定义几大模块，官方提供了较为全面的基础插件功能；
5. Upstreams 类nginx中的Upstream，用于配置上游的服务信息；
6. Certificates 证书管理。

 __服务配置__
1.添加服务： Services -> Create Services
实例：
![Config Service](https://www.tapd.cn/tfl/captures/2019-10/tapd_personalword_1122492131001000980_base64_1571276554_85.png)

 !!#999999 说明：由于这里的Kong部署在K8S环境中，所以可以直接使用K8S中的服务名+端口号来定义服务的Host和Port。!!

2.添加路由： Services -> Service Detail -> Routes -> Add Route 
实例：

![Config Route](https://www.tapd.cn/tfl/captures/2019-10/tapd_personalword_1122492131001000980_base64_1571276789_84.png)

配置完成之后，我们就可以访问我们的服务了。
```
# https://192.168.0.231:31617/config 或 http://192.168.0.231:32740/config Host: config.kong
> curl -ik -H "Host":"config.kong" https://192.168.0.231:31617/config/basic/dev
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
Connection: keep-alive
Date: Thu, 17 Oct 2019 02:05:16 GMT
Server: Kestrel
X-Kong-Upstream-Latency: 3
X-Kong-Proxy-Latency: 10007
Via: kong/1.3.0

{"logLevel":"Debug",...}
```
__插件配置__
插件添加有两个入口：
1.服务插件 Servcies -> Service Detail -> Plugins -> Add Plugin
2.路由插件 Routes -> Route Detail -> Plugins -> Add Plugin

 !!#cc0000 认证!! 
```
# 1.Basic 认证
# Header: Authorization Basic base64(username:password)

# 2.Jwt认证
# 支持三种认证参数传递:uri param，cookie and header,可自定义键名
# key claim一般为iss
# jwt生成 & 校验：https://jwt.io/

# 3.OAuth2认证
# 认证地址：oauth2/authorize
# 获取token地址： oauth2/token
# 刷新token地址： oauth2/token
```

!!#cc0000 安全!! 
```
# 1. Acl 访问控制列表
# 2. Cors  跨域资源共享
# 3. Ip Restriction IP限制
# 4. Bot Detection 机器人检测
```

!!#cc0000 限流!! 
```
# 1. Rate Limiting 速率限制
# 2. Response Ratelimiting 响应速率限制
# 3. Request Size Limiting  请求大小限制
# 4. Request Termination 请求阻断/终止
```

 !!#cc0000 日志!! 

 !!#cc0000 监控!! 

 !!#cc0000 请求转发!! 

 !!#cc0000 自定义!! 

#### 4. Admin API
[AdminAPI](https://docs.konghq.com/1.3.x/admin-api/)
