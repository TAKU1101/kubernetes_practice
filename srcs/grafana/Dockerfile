FROM    alpine:latest

# apk update
RUN     apk update

# copy setupfile
COPY    srcs/main.sh /

# apk install
RUN     apk add --no-cache \
        # grafana
        grafana \
        # other
        wget \
        vim \
        openssl \
        openssh

# grafana setup
RUN     mkdir -p /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards
RUN     mkdir -p /usr/share/grafana/conf/provisioning/datasources
COPY    srcs/datasource.yaml /usr/share/grafana/conf/provisioning/datasources

# copy grafana data
COPY    srcs/ftps.json /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/grafana.json /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/influxdb.json /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/mysql.json /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/nginx.json /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/phpmyadmin.json /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/wordpress.json /usr/share/grafana/conf/provisioning/dashboards

# telegraf setup
RUN     mkdir -p /etc/telegraf/
COPY    srcs/telegraf.conf /etc/telegraf
RUN     apk add --no-cache \
        telegraf

# setup port
EXPOSE  3000

# CMD     tail -f /dev/null
CMD     sh ./main.sh
# CMD     grafana-server --homepath=/usr/share/grafana