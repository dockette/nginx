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

## Site configuration

```nginx
# PHP backend
upstream website {
    server php:9000;
}

# Redirect HTTP -> HTTPS
server {
       listen 80;
       server_name $DOMAINS;
       return 301 https://$host$request_uri;
}

# HTTPS + SPDY + HTSTS (with all subdomains for 1 year)
server {
        listen 443 ssl spdy;
        server_name $DOMAINS;

        add_header Content-Security-Policy upgrade-insecure-requests;
        add_header Alternate-Protocol 443:npn-spdy/3; # SPDY hlavicka

        # Nginx > 1.7.5
        add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload' always;

        ssl_certificate /srv/certs/$DOMAIN/fullchain.pem;
        ssl_certificate_key /srv/certs/$DOMAIN/privkey.pem;
        ssl_session_timeout 5m;

        index index.php index.html;
        root /var/www;

        location / {
          try_files $uri $uri/ =404;
        }

        location ~* \.php$ {
          include fastcgi.conf;
          fastcgi_pass website;
        }
} 
```

## Result

You should have A+ on [SSL Server Test](https://www.ssllabs.com/ssltest/).

![](https://raw.githubusercontent.com/dockette/nginx/master/docs/ssllabs.png "SSL Server Test")


