FROM dockette/debian:jessie

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
    echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt-get update && apt-get install -y ca-certificates nginx && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# Nginx configuration
ADD ./nginx.conf /etc/nginx/
ADD ./mime.types /etc/nginx/
ADD ./sites/default /etc/nginx/sites-enabled/default

# Scripts
ADD ./generate-dhparam2048.sh /generate-dhparam2048.sh
ADD ./start.sh /entrypoint.sh

RUN chmod 775 /generate-dhparam2048.sh && chmod 775 /entrypoint.sh

EXPOSE 80 443

CMD ["/entrypoint.sh"]
