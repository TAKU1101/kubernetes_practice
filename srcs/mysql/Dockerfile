FROM    alpine:latest

RUN     apk update

COPY    srcs/my.cnf /etc/my.cnf
COPY    srcs/main.sh /

RUN     apk add --no-cache \
        # mysql
        mysql \
        mysql-client \
        # other
        wget \
        vim \
        openssl \
        openssh

EXPOSE  3306

CMD     sh main.sh
