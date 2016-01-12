FROM daocloud.io/centos:7
MAINTAINER "Xiong Zhengdong" <haibxz@gmail.com>

# ADD http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm /tmp/
# ADD https://openresty.org/download/ngx_openresty-1.7.10.1.tar.gz /tmp/
ADD bundles/* /tmp/

RUN rpm -ivh /tmp/epel-release-7-5.noarch.rpm
RUN yum update -y && \
  yum install -y readline-devel pcre-devel openssl-devel gcc \
  gcc+ gcc-c++ autoconf automake libtool \
  bzip2 unzip git vim tmux nginx

ENV OPENRESTY_VERSION 1.7.10.1
ENV OPENRESTY_PREFIX /opt/openresty
ENV NGINX_PREFIX $OPENRESTY_PREFIX/nginx
ENV VAR_PREFIX /var/nginx
ENV LUAJIT_DIR $OPENRESTY_PREFIX/luajit
ENV LUAJIT_INCLUDE $LUAJIT_DIR/include/luajit-2.1

RUN echo "Install openresty ..." \
  && cd /tmp/ngx_openresty-$OPENRESTY_VERSION \
  && ./configure --prefix=/opt/openresty \
    --with-pcre-jit \
    --with-ipv6 \
    --with-lua51 \
    --with-luajit \
    --without-http_redis2_module \
    --with-http_iconv_module \
  && make -j2 && make install

# Protoc and python runtime
# To avoid GFW, we're now get gtest from github instead of curl from google.
RUN echo "Install protobuf compiler ..." \
  && cd /tmp/protobuf-2.5.0 \
  && git clone https://github.com/bilxio/gtest.git \
  && ./autogen.sh && ./configure && make && make install \
  && echo "Install protobuf python runtime ..." \
  && cd ./python \
  && python setup.py build \
  && python setup.py install

# Lua output plugin for protoc
# RUN git clone https://github.com/sean-lin/protoc-gen-lua.git
RUN echo "Install protoc-gen-lua ..." \
  && cd /tmp/protoc-gen-lua/protobuf \
  && rm -f pb.so \
  && PKG_CONFIG_PATH=${OPENRESTY_PREFIX}/luajit/lib/pkgconfig make \
  && cp pb.so ${OPENRESTY_PREFIX}/lualib/ \
  && cd ../plugin && ln -sf `pwd`/protoc-gen-lua /usr/local/bin/

RUN echo "Install luarocks ..." \
  && cd /tmp/luarocks-2.1.0 \
  && ./configure --prefix=/usr/local/luarocks \
    --with-lua-include=$LUAJIT_INCLUDE \
  && make build && make install \
  && ln -sf /usr/local/luarocks/bin/luarocks /usr/local/bin/

WORKDIR ${NGINX_PREFIX}

EXPOSE 22 80 8080
CMD ["nginx", "-g", "daemon off; error_log /dev/stderr info;"]
