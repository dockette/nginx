FROM dockette/debian:buster

LABEL maintainer="Milan Sulc <sulcmil@gmail.com>"

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install --no-install-recommends --no-install-suggests -y gnupg1 apt-transport-https ca-certificates && \
    # APP PART
    apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
    echo "deb http://nginx.org/packages/mainline/debian/ buster nginx" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
        nginx \
        nginx-module-xslt \
        nginx-module-geoip \
        nginx-module-image-filter \
        nginx-module-njs \
        gettext-base && \
    rm /etc/nginx/conf.d/default.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    # CLEANING PART
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# Nginx configuration
ADD ./nginx.conf    /etc/nginx/nginx.conf
ADD ./mime.types    /etc/nginx/mime.types
ADD ./conf.d        /etc/nginx/conf.d
ADD ./site.conf.d   /etc/nginx/site.conf.d
ADD ./sites.d       /etc/nginx/sites.d

# Default cypher (please rewrite it by your own)
ADD ./dhparam2048.pem /etc/nginx/dhparam2048.pem
ADD ./dhparam4096.pem /etc/nginx/dhparam4096.pem

EXPOSE 80 443

WORKDIR /srv

CMD ["nginx", "-g", "daemon off;"]
