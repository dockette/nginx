# Nginx

[![Docker Stars](https://img.shields.io/docker/stars/dockette/nginx.svg?style=flat)](https://hub.docker.com/r/dockette/nginx/)
[![Docker Pulls](https://img.shields.io/docker/pulls/dockette/nginx.svg?style=flat)](https://hub.docker.com/r/dockette/nginx/)

Nginx with SSL / SPDY / HSTS

## Default

Without any volumes Nginx listen IPv4 and IPv6 on both ports 80/443 and serve 444 No content.

## Usage

```sh
docker run 
    -p 80:80 
    -p 443:433
    -v /home/nginx/sites:/etc/nginx/sites-enabled
    -v /home/nginx/dhparam2048.pem:/etc/nginx/dhparam2048.pem
    --name nginx
    dockette/nginx:latest
```

Pass `dhparam2048.pem` is optional, if it is not provided container makes it by self (it takes lo-ooo-ng time).

## Result

You should have A+ on [SSL Server Test](https://www.ssllabs.com/ssltest/).

![](https://raw.githubusercontent.com/dockette/nginx/master/docs/ssllabs.png "SSL Server Test")


