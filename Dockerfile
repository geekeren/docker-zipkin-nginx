FROM nginx
RUN apt-get update && apt install wget -y
RUN wget -O - https://github.com/rnburn/zipkin-cpp-opentracing/releases/download/v0.5.2/linux-amd64-libzipkin_opentracing_plugin.so.gz | gunzip -c > /usr/local/lib/libzipkin_opentracing_plugin.so
RUN apt-get remove wget -y
