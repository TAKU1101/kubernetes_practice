FROM    alpine:latest

# update
RUN     apk update

# install
RUN     apk add --no-cache \
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

# wordpress
RUN     wget https://ja.wordpress.org/latest-ja.tar.gz
RUN     tar -zxvf latest-ja.tar.gz
RUN     rm -f latest-ja.tar.gz
COPY    ./srcs/wp-config.php ./wordpress
# RUN     chown -R www-data:www-data ./wordpress
RUN     chmod 640 ./wordpress/wp-config.php
RUN     rm -f ./wordoress/wp-config-sample.php

EXPOSE  5050

CMD     php -S 0.0.0.0:80 -t /wordpress
