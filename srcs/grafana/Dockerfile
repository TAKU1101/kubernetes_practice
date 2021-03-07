FROM    alpine:latest

RUN     mkdir -p /usr/share/grafana/conf/provisioning/dashboards
COPY    srcs/dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards
RUN     mkdir -p /usr/share/grafana/conf/provisioning/datasources
COPY    srcs/datasource.yaml /usr/share/grafana/conf/provisioning/datasources
# COPY    srcs/grafana.ini /etc

RUN     apk add --no-cache \
        # grafana
        grafana \
        # other
        wget \
        vim \
        openssl \
        openssh

EXPOSE  3000

CMD     grafana-server --homepath=/usr/share/grafana