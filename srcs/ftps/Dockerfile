FROM    alpine:latest

# apk update
RUN     apk update

# apk install
RUN     apk add --no-cache \
        # ftps
        vsftpd \
        # other
        wget \
        vim \
        openssl \
        openssh

# copy setupfile
COPY    srcs/vsftpd.conf etc/vsftpd/
COPY    srcs/main.sh /

# ssl setup
RUN     openssl req -newkey rsa:4096 \
        -x509 \
        -sha256 \
        -days 10 \
        -nodes \
        -out /etc/vsftpd/server.crt \
        -keyout /etc/vsftpd/server.key \
        -subj "/C=JP/ST=Tokyo/L=kodaira/O=42tokyo/OU=42tokyo/CN=localhost"

# telegraf setup
RUN     mkdir -p /etc/telegraf/
COPY    srcs/telegraf.conf /etc/telegraf
RUN     apk add --no-cache \
        telegraf

# ftps setup
RUN     mkdir -p /etc/ftps/ftp_user
RUN     adduser --home=/etc/ftps/ftp_user -D ftp_user
RUN     echo "ftp_user:pass" | chpasswd
RUN     mkdir -p /etc/vsftpd
RUN     echo "ftp_user" >> /etc/vsftpd/user_list
RUN     echo "ftp_user" >> /etc/vsftpd/chroot_list

# port setup
EXPOSE  21 30021

CMD     sh ./main.sh
# CMD     tail -f /dev/null
# CMD     {telegraf &} && vsftpd /etc/vsftpd/vsftpd.conf