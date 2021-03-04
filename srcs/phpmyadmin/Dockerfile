FROM    alpine:latest

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

# phpMyAdmin
RUN     wget https://files.phpmyadmin.net/phpMyAdmin/4.8.3/phpMyAdmin-4.8.3-all-languages.tar.gz
RUN     tar -xvzf phpMyAdmin-4.8.3-all-languages.tar.gz
RUN     mv phpMyAdmin-4.8.3-all-languages phpmyadmin
COPY    srcs/config.inc.php /phpmyadmin
RUN     rm -f phpMyAdmin-4.8.3-all-languages.tar.gz

EXPOSE  5000

CMD     /usr/bin/php -S 0.0.0.0:80 -t /phpmyadmin
