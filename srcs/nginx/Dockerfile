FROM    alpine:latest

COPY    srcs/nginx.conf /etc/nginx/nginx.conf
COPY    srcs/main.sh /

RUN     mkdir -p /run/nginx

RUN     apk update

RUN     apk add --no-cache \
        # nginx
        nginx \
        # other
        wget \
        vim \
        openssl \
        openssh

RUN     openssl req -newkey rsa:4096 \
        -x509 \
        -sha256 \
        -days 10 \
        -nodes \
        -out /etc/ssl/example.pem \
        -keyout /etc/ssl/example.key \
        -subj "/C=JP/ST=Tokyo/L=kodaira/O=42tokyo/OU=42tokyo/CN=localhost"

EXPOSE  22 80 433

CMD     nginx -g "daemon off;"