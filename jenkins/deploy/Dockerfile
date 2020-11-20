FROM openjdk:8-alpine

WORKDIR /publish
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk add -U tzdata \
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && apk del tzdata

EXPOSE 8080

ENV YZ_MODE "test"
ENV JAVA_OPTS ""
ENV JAVA_PARAMS ""
ENV DEF_JAVA_OPTS "-Djava.security.egd=file:/dev/./urandom -Duser.timezone=Asia/Shanghai -Dfile.encoding=utf-8"

ADD *-web/target/*.jar ./app.jar

ENTRYPOINT [ "sh", "-c", "java ${JAVA_OPTS} ${DEF_JAVA_OPTS} -jar app.jar ${JAVA_PARAMS} --spring.profiles.active=${YZ_MODE} --server.port=8080" ]
