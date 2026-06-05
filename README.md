<h1 align=center>Dockette / Nginx</h1>

<p align=center>
   <a href="https://github.com/dockette/nginx/actions"><img src="https://github.com/dockette/nginx/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/nginx"><img src="https://img.shields.io/docker/pulls/dockette/nginx.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Nginx with SSL / HSTS and HTTP2 module.
</p>

-----

## Default

Without any custom site configuration, Nginx starts with no default virtual host. Mount a server configuration into `/etc/nginx/sites.d` to listen on ports 80/443.

## Usage

```sh
docker run \
    -p 80:80 \
    -p 443:443 \
    -v /path/to/site:/etc/nginx/sites.d/site \
    --name nginx \
    dockette/nginx:latest
```

## Configuration

There are 2 main files:

- [nginx.conf](https://github.com/dockette/nginx/blob/master/nginx.conf)
- [mime.types](https://github.com/dockette/nginx/blob/master/mime.types)

Diffie-Hellman files:

- [dhparam2048.pem](https://github.com/dockette/nginx/blob/master/dhparam2048.pem)
- [dhparam4096](https://github.com/dockette/nginx/blob/master/dhparam4096.pem)

Modules:

- nginx-module-xslt
- nginx-module-geoip
- nginx-module-image-filter
- nginx-module-njs

### Http config

There are many files in `/etc/nginx/conf.d`.

- [basic.conf](https://github.com/dockette/nginx/blob/master/conf.d/basic.conf)
- [charset.conf](https://github.com/dockette/nginx/blob/master/conf.d/charset.conf)
- [gzip.conf](https://github.com/dockette/nginx/blob/master/conf.d/gzip.conf)
- [logging.conf](https://github.com/dockette/nginx/blob/master/conf.d/logging.conf)
- [ssl.conf](https://github.com/dockette/nginx/blob/master/conf.d/ssl.conf)

These files are loaded manully in the main `http` section. You can extend only part of these files which you need.

Please do not place your custom configurations to this folder. There is a folder `/etc/nginx/user.conf.d` for this reason.

Take a look at [nginx.conf](https://github.com/dockette/nginx/blob/master/nginx.conf).

### Sites

Sites are loaded from folder `/etc/nginx/sites.d`.

The image ships an empty `/etc/nginx/sites.d` folder. Example site configurations are available in [.examples/sites.d](https://github.com/dockette/nginx/tree/master/.examples/sites.d), including a 444 `default_server`, but they are not installed automatically.

### Sites config

For little fragments shared accross sites you can use folder `/etc/nginx/site.conf.d`.

### User config

Your custom global http section configuration, `/etc/nginx/user.conf.d`. These files are loaded automatic from `http` section.

Take a look at [nginx.conf](https://github.com/dockette/nginx/blob/master/nginx.conf).

### SSL

By default nginx uses 2048 bits dhparam cypher. There is also 4096 bits pregenerated file. 

This approach is for developing, for your stagging / production, please generate your own dhparam.

## Tip

You should have A+ on [SSL Server Test](https://www.ssllabs.com/ssltest/).

![](https://raw.githubusercontent.com/dockette/nginx/master/.docs/ssllabs.png "SSL Server Test")

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
