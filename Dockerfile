FROM debian:jessie

# Install Nginx
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y ca-certificates nginx && \
    rm -rf /var/lib/apt/lists/*

# Nginx configuration
ADD ./nginx.conf /etc/nginx/
ADD ./mime.types /etc/nginx/

# Default sites
ADD ./sites/default /etc/nginx/sites-available/default

# Script for SSL cypther
ADD ./generate-dhparam2048.sh /generate-dhparam2048.sh
RUN chmod 775 /generate-dhparam2048.sh

# Startup script
ADD ./start.sh /start.sh
RUN chmod 775 /start.sh

VOLUME ["/etc/nginx/sites-available", "/etc/nginx/sites-enabled"]

EXPOSE 80 443

CMD ["/start.sh"]