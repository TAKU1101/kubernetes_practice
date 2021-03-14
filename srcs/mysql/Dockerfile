FROM    alpine:latest

# apk update
RUN     apk update

# copy setupfile
COPY    srcs/main.sh /
COPY    srcs/my.cnf /etc/my.cnf
COPY    srcs/wordpress.sql /

# apk install
RUN     apk add --no-cache \
        # mysql
        mariadb \
        mariadb-client\
        # other
        wget \
        vim \
        openssl \
        openssh

# telegraf setup
RUN     mkdir -p /etc/telegraf/
COPY    srcs/telegraf.conf /etc/telegraf
RUN     apk add --no-cache \
        telegraf

# setup port
EXPOSE  3306

CMD     sh main.sh
