
--micro-main
docker service create \
 --replicas 1 \
 --name micro-main \
 --network ov_net \
 -e ACB_MODE=Test \
 --mount type=bind,source=/var/www/v3/micro-main/appsettings.json,destination=/publish/appsettings.json \
 docker.local:5000/web/micro-main:3.0

--micro-user
 docker service create \
 --replicas 1 \
 --name micro-user \
 --network ov_net \
 -e ACB_MODE=Test \
 --mount type=bind,source=/var/www/v3/micro-user/appsettings.json,destination=/publish/appsettings.json \
 docker.local:5000/web/micro-user:3.0

 --micro-sword
 docker service create \
 --replicas 1 \
 --name micro-sword \
 --network ov_net \
 -e ACB_MODE=Test \
 --mount type=bind,source=/var/www/v3/micro-sword/appsettings.json,destination=/publish/appsettings.json \
 docker.local:5000/web/micro-sword:3.0

--micro-story
 docker service create \
 --replicas 1 \
 --name micro-story \
 --network ov_net \
 -e ACB_MODE=Test \
 --mount type=bind,source=/var/www/v3/micro-story/appsettings.json,destination=/publish/appsettings.json \
 docker.local:5000/web/micro-story:3.0

--micro-market
 docker service create \
 --replicas 1 \
 --name micro-market \
 --network ov_net \
 -e ACB_MODE=Test \
 --mount type=bind,source=/var/www/v3/micro-market/appsettings.json,destination=/publish/appsettings.json \
 docker.local:5000/web/micro-market:3.0

 --gateway-app
 docker service create \
 --replicas 1 \
 --name gateway-app \
 --network ov_net \
 -e ACB_MODE=Test \
 -p 6311:5000 \
 --mount type=bind,source=/var/www/v3/gateway-app/appsettings.json,destination=/publish/appsettings.json \
 docker.local:5000/web/gateway-app:3.0

 --gateway-management
 docker service create \
 --replicas 1 \
 --name gateway-management \
 --network ov_net \
 -e ACB_MODE=Test \
 -p 6312:5000 \
 --mount type=bind,source=/var/www/v3/gateway-management/appsettings.json,destination=/publish/appsettings.json \
 docker.local:5000/web/gateway-management:3.0