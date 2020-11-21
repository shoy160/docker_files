FROM rocketmq-base:4.7.1

EXPOSE 9876

RUN mv ${ROCKETMQ_HOME}/bin/runserver-customize.sh ${ROCKETMQ_HOME}/bin/runserver.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/runserver.sh \
 && chmod +x ${ROCKETMQ_HOME}/bin/mqnamesrv

CMD cd ${ROCKETMQ_HOME}/bin \
 && export JAVA_OPT=" -Duser.home=/opt" \
 && dos2unix runserver.sh \
 && /bin/bash mqnamesrv