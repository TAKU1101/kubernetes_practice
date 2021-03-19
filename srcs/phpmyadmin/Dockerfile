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

# setup phpMyAdmin
RUN     wget https://files.phpmyadmin.net/phpMyAdmin/4.8.3/phpMyAdmin-4.8.3-all-languages.tar.gz
RUN     tar -xvzf phpMyAdmin-4.8.3-all-languages.tar.gz
RUN     mv phpMyAdmin-4.8.3-all-languages phpmyadmin
COPY    srcs/config.inc.php /phpmyadmin
RUN     rm -f phpMyAdmin-4.8.3-all-languages.tar.gz
RUN     mkdir -p /var/www
RUN     mv phpmyadmin /var/www

# setup nginx
RUN     mkdir -p /run/nginx

# telegraf setup
RUN     mkdir -p /etc/telegraf/
COPY    srcs/telegraf.conf /etc/telegraf
RUN     apk add --no-cache \
        telegraf

# setup port
EXPOSE  5000

CMD     sh ./main.sh
# CMD     /usr/bin/php -S 0.0.0.0:80 -t /phpmyadmin
