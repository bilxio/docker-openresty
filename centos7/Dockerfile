FROM daocloud.io/centos:7
MAINTAINER "Xiong Zhengdong" <haibxz@gmail.com>

# ADD http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm /tmp/
# ADD https://openresty.org/download/ngx_openresty-1.7.10.1.tar.gz /tmp/
ADD bundles/* /tmp/

RUN rpm -ivh /tmp/epel-release-7-5.noarch.rpm
RUN yum update -y
RUN yum install -y readline-devel pcre-devel openssl-devel gcc nginx

ENV OPENRESTY_VERSION 1.9.3.1
ENV OPENRESTY_PREFIX /opt/openresty
ENV NGINX_PREFIX /opt/openresty/nginx
ENV VAR_PREFIX /var/nginx

WORKDIR ${NGINX_PREFIX}

EXPOSE 22 80 8080
CMD ["nginx", "-g", "daemon off; error_log /dev/stderr info;"]
