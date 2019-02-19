FROM nginx
RUN apt-get update && apt install wget -y

#Install nginx-opentracing module
RUN wget -O - \
  https://github.com/opentracing-contrib/nginx-opentracing/releases/download/v0.4.0/linux-amd64-nginx-1.14.0-ngx_http_module.so.tgz | \
  tar zxf - -C /usr/lib/nginx/modules

#Insatll zipkin plugin
RUN wget -O - \
  https://github.com/rnburn/zipkin-cpp-opentracing/releases/download/v0.5.2/linux-amd64-libzipkin_opentracing_plugin.so.gz | \
  gunzip -c > /usr/local/lib/libzipkin_opentracing_plugin.so
RUN apt-get remove wget -y