# kubernetes_practice

We will build 7 services locally using minikube and docker.

### What you need.
minikube (assumed to run in a VM)
docker

Run the following

```shell
> . /setup.sh
```

Connect to 192.168.10.10.

### service

#### nginx
port: 80, 443, 22
This is the nginx server.
Port 80 is for http, port 443 is for https, and port 22 is for ssl communication.
192.168.10.10/wordpress will be redirected to the wordpress server,
192.168.10.10/phpmyadmin will be connected to the phpmyadmin server by reverse proxy

#### wordpress
port: 5050
This is the wordpress server
mysql references the server database

#### phpmyadmin
port: 5000
Server for phpmyadmin.
Browse the mysql server database

#### mysql
port: 3036
Server for mysql.
Stores wordpress data
Can also be referenced from phpmyadmin

#### grafana
port: 3000
You can see the cpu usage of the 7 containers
Refers to data from influxdb server

#### influxdb
port: 8086
The cpu usage of the 7 containers is observed by teegraf and stored in this server.

#### ftps
port: 21
A server that can perform ftps communication

### other

The influxdb and mysql database servers will keep the data permanently even if the pod disappears.
All containers will be restarted even if the required process crashes for some reason.
