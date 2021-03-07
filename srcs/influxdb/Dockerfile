FROM    alpine:latest

# apk update
RUN     apk update

# copy setupfile
COPY    srcs/main.sh /

# apk install
RUN     apk add --no-cache \
        # nginx
        influxdb \
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

#setup port
EXPOSE  8086

CMD     sh ./main.sh
# CMD     /usr/sbin/influxd