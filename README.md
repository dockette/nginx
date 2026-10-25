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

Nginx with SSL, HSTS and HTTP/2 on `debian:trixie-slim`, installed from the nginx.org mainline packages. It starts with
no default virtual host. Mount a server configuration into `/etc/nginx/sites.d` to listen on ports 80 and 443.

## Features

- Nginx mainline with the `xslt`, `geoip`, `image-filter` and `njs` modules
- Ports `80` and `443`
- SSL, gzip, charset and logging defaults in `/etc/nginx/conf.d`
- Pregenerated Diffie-Hellman files (`dhparam2048.pem` and `dhparam4096.pem`)
- Empty `/etc/nginx/sites.d`, example sites in [.examples/sites.d](https://github.com/dockette/nginx/tree/master/.examples/sites.d)
  (including a 444 `default_server`, not installed automatically)

You should have A+ on [SSL Server Test](https://www.ssllabs.com/ssltest/).

![](https://raw.githubusercontent.com/dockette/nginx/master/.docs/ssllabs.png "SSL Server Test")

## Usage

```sh
docker run -p 80:80 -p 443:443 -v /path/to/site:/etc/nginx/sites.d/site --name nginx dockette/nginx:latest
```

## Configuration

Main files:

- [nginx.conf](https://github.com/dockette/nginx/blob/master/nginx.conf)
- [mime.types](https://github.com/dockette/nginx/blob/master/mime.types)
- [dhparam2048.pem](https://github.com/dockette/nginx/blob/master/dhparam2048.pem)
- [dhparam4096.pem](https://github.com/dockette/nginx/blob/master/dhparam4096.pem)

Folders:

- `/etc/nginx/conf.d`: the http config, loaded manually in the main `http` section of
  [nginx.conf](https://github.com/dockette/nginx/blob/master/nginx.conf). You can extend only the parts you need. Do not
  put your own configuration here.
  - [basic.conf](https://github.com/dockette/nginx/blob/master/conf.d/basic.conf)
  - [charset.conf](https://github.com/dockette/nginx/blob/master/conf.d/charset.conf)
  - [gzip.conf](https://github.com/dockette/nginx/blob/master/conf.d/gzip.conf)
  - [logging.conf](https://github.com/dockette/nginx/blob/master/conf.d/logging.conf)
  - [ssl.conf](https://github.com/dockette/nginx/blob/master/conf.d/ssl.conf)
- `/etc/nginx/sites.d`: sites, one file per site.
- `/etc/nginx/site.conf.d`: small fragments shared across sites.
- `/etc/nginx/user.conf.d`: your own global `http` configuration, loaded automatically.

By default Nginx uses the 2048 bit dhparam file. The 4096 bit file is also there. Both are for development: for staging
and production, generate your own.

## Versions

| Version | Release |
|---------|---------|
| `dockette/nginx:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/nginx:latest` | latest build of `master` |

Releases are listed on [GitHub](https://github.com/dockette/nginx/releases).

## Development

```sh
make build     # build linux/amd64 and linux/arm64
make test      # run nginx -v and nginx -t
make run       # run the image on ports 80 and 443
make version   # print VERSION
make release   # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
