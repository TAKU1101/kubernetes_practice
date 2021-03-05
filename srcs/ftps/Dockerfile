FROM    alpine:latest

RUN     apk add --no-cache \
        # ftps
        vsftpd \
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

RUN     mkdir -p /etc/ftps/ftp_user
RUN     adduser --home=/etc/ftps/ftp_user -D ftp_user
RUN     echo "ftp_user:password" | chpasswd

COPY    srcs/vsftpd.conf etc/vsftpd/

EXPOSE  21 30000-30010

CMD     vsftpd /etc/vsftpd/vsftpd.conf