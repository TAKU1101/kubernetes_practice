FROM    alpine:latest

# apk update
RUN     apk update

# copy setupfile
COPY    srcs/nginx.conf /etc/nginx/nginx.conf
COPY    srcs/main.sh /
COPY    srcs/index.html /var/www/nginx/

# apk install
RUN     apk add --no-cache \
        # nginx
        nginx \
        # other
        wget \
        vim \
        openssl \
        openssh

# setup ssl
RUN     openssl req -newkey rsa:4096 \
        -x509 \
        -sha256 \
        -days 10 \
        -nodes \
        -out /etc/ssl/example.pem \
        -keyout /etc/ssl/example.key \
        -subj "/C=JP/ST=Tokyo/L=kodaira/O=42tokyo/OU=42tokyo/CN=localhost"

# setup nginx
RUN     mkdir -p /run/nginx

# telegraf setup
RUN     mkdir -p /etc/telegraf/
COPY    srcs/telegraf.conf /etc/telegraf
RUN     apk add --no-cache \
        telegraf

# setup port
EXPOSE  22 80 443

CMD     sh ./main.sh
# CMD     nginx -g "daemon off;"