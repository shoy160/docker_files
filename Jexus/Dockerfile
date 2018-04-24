FROM debian:latest

#修改时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir /usr/jexus

COPY ./jexus /usr/jexus

# RUN apt-get update \
#         && apt-get -y install wget \
#         && cd /usr \
#         && wget http://www.linuxdot.net/down/jexus-5.8.3-x64.tar.gz \
#         && tar -zxvf jexus-5.8.3-x64.tar.gz \
#         && apt-get -y autoremove --purge wget \
#         && rm -rf /var/lib/apt/lists/* jexus-5.8.3-x64.tar.gz

EXPOSE 80
WORKDIR /usr/jexus
CMD /usr/jexus/jwss

#docker build -t icb-jexus .
#docker run --name icb-app-open -d -p 89:80 -v /var/www/acb.app:/var/www/default --restart always --privileged=true icb-jexus