FROM nginx:1.12.2
RUN apt-get update && apt install wget -y
ENV NGINX_VERSION 1.12.2
#Install nginx-opentracing module
RUN wget -O - \
  https://github.com/opentracing-contrib/nginx-opentracing/releases/download/v0.8.0/linux-amd64-nginx-$NGINX_VERSION-ngx_http_module.so.tgz | \
  tar zxf - -C /usr/lib/nginx/modules

#Insatll zipkin plugin
RUN wget -O - \
  https://github.com/rnburn/zipkin-cpp-opentracing/releases/download/v0.5.2/linux-amd64-libzipkin_opentracing_plugin.so.gz | \
  gunzip -c > /usr/local/lib/libzipkin_opentracing_plugin.so
RUN apt-get remove wget -y