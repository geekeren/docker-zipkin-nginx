# docker-zipkin-nginx

[![Dockerhub](https://img.shields.io/docker/pulls/distracing/zipkin-nginx.svg)](https://hub.docker.com/r/distracing/zipkin-nginx/)
[![Dockerhub](https://img.shields.io/docker/cloud/automated/distracing/zipkin-nginx.svg)](https://hub.docker.com/r/distracing/zipkin-nginx/)
[![Dockerhub](https://img.shields.io/docker/cloud/build/distracing/zipkin-nginx.svg)](https://hub.docker.com/r/distracing/zipkin-nginx/)
[![License](https://img.shields.io/github/license/geekeren/docker-zipkin-nginx.svg)](https://github.com/geekeren/docker-zipkin-nginx/blob/master/LICENSE)

Dockerfile project for nginx supporting zipkin tracer



## Supported tags and respective Dockerfile links
- [`lastest`,`1.15` (nginx1.15/Dockerfile)](nginx1.15/Dockerfile)
- [`1.14` (nginx1.14/Dockerfile)](nginx1.14/Dockerfile)
- [`1.13` (nginx1.13/Dockerfile)](nginx1.13/Dockerfile)
- [`1.12` (nginx1.12/Dockerfile)](nginx1.12/Dockerfile)

## Usage
### Pull the docker image:
```
docker pull distracing/zipkin-nginx
```

### Run Docker with config files mounted
```
docker run -p 80:80 -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro -v $(pwd)/zipkin-nginx-config.json:/etc/zipkin-nginx/zipkin-nginx-config.json:ro distracing/zipkin-nginx:1.12
```

### Configuration

The following is example code of nginx.conf and zipkin configuration. A example using `docker-compose` can be got in this repo: https://github.com/geekeren/docker-zipkin-nginx-example

#### Nginx.conf
```
load_module modules/ngx_http_opentracing_module.so;
events {
    worker_connections  1024;
}

http {
    opentracing_load_tracer /usr/local/lib/libzipkin_opentracing_plugin.so /etc/zipkin-nginx/zipkin-nginx-config.json;
    opentracing on;
    opentracing_trace_locations off;

    log_format tracing
    'traceId=$opentracing_context_x_b3_traceid '
    'spanId=$opentracing_context_x_b3_spanid ';

    server {
        listen 80;
        opentracing_propagate_context;
        location ~ {
            access_log  /var/log/nginx/access.log tracing;
            proxy_pass https://wangbaiyuan.cn;
            break;
        }
    }
}

```
Getting More information at：

- https://github.com/opentracing-contrib/nginx-opentracing
- https://github.com/opentracing-contrib/nginx-opentracing/blob/ea9994d7135be5ad2e3009d0f270e063b1fb3b21/doc/Reference.md

#### zipkin-nginx-config.json

```
{
  "service_name": "zipkin-nginx",
  "sample_rate": 0
}
```

This zipkin configuration is created according to https://github.com/rnburn/zipkin-cpp-opentracing/blob/master/zipkin_opentracing/tracer_configuration.schema.json , you can go there to see more usages.
