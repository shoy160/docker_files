FROM openjdk:8-alpine

ARG version=4.7.1

ENV ROCKETMQ_VERSION ${version}
ENV ROCKETMQ_HOME  /opt/rocketmq-${ROCKETMQ_VERSION}
RUN mkdir -p /opt/rocketmq/logs /opt/rocketmq/store

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update bash curl unzip gettext nmap-ncat openssl dos2unix  \  
    && rm -f /bin/sh && ln -s /bin/bash /bin/sh \  
    && curl http://ftp.cuhk.edu.hk/pub/packages/apache.org/rocketmq/${ROCKETMQ_VERSION}/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip -o /opt/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip \
    && unzip -d /opt /opt/rocketmq-all-${ROCKETMQ_VERSION}-bin-release.zip \
    && mv /opt/rocketmq-all-${ROCKETMQ_VERSION}-bin-release ${ROCKETMQ_HOME} \
    && rm -rf /opt/rocketmq-all* \
    && rm -rf /var/cache/apk/*

COPY scripts/ ${ROCKETMQ_HOME}/bin/
VOLUME /opt/rocketmq/logs /opt/rocketmq/store