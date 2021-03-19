FROM    alpine:latest

# apk update
RUN     apk update

# copy setupfile
COPY    srcs/main.sh /

# apk install
RUN     apk add --no-cache \
        # nginx
        nginx \
        # php
        php7 \
        php7-fpm \
        php7-opcache \
        php7-gd \
        php7-mysqli \
        php7-zlib \
        php7-curl \
        php7-mbstring \
        php7-json \
        php7-session \
        # other
        wget \
        vim \
        openssl \
        openssh

# setup wordpress
RUN	mkdir -p /usr/share/webapps/
RUN     wget https://ja.wordpress.org/latest-ja.tar.gz
RUN     tar -zxvf latest-ja.tar.gz
RUN     rm -f latest-ja.tar.gz
COPY    ./srcs/wp-config.php ./wordpress
# RUN     chown -R www-data:www-data ./wordpress
RUN     chmod 640 ./wordpress/wp-config.php
RUN     rm -f ./wordoress/wp-config-sample.php
RUN     mkdir -p /var/www
RUN     mv /wordpress /var/www

# setup nginx
RUN     mkdir -p /run/nginx

# telegraf setup
RUN     mkdir -p /etc/telegraf/
COPY    srcs/telegraf.conf /etc/telegraf
RUN     apk add --no-cache \
        telegraf

# setup port
EXPOSE  5050

# CMD     tail -f /dev/null
CMD     sh ./main.sh
# CMD     php -S 0.0.0.0:80 -t /wordpress
