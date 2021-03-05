FROM    alpine:latest

RUN     apk add --no-cache \
        # nginx
        influxdb \
        # other
        wget \
        vim \
        openssl \
        openssh

EXPOSE  8086

CMD     /usr/sbin/influxd