build_image()
{
    echo images: $1
    docker build -t ${1}_image srcs/${1}/.
}

build_all_images()
{
    for image in "nginx" "wordpress" "mysql" "phpmyadmin" "ftps" "grafana" "influxdb"
    do
        build_image $image
    done
}

minikube_setup()
{
    systemctl stop nginx
    minikube delete
    minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535
    minikube addons enable metrics-server
	minikube addons enable dashboard
    minikube addons enable metallb
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
    # On first install only
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
    kubectl apply -f srcs/yamls/metallb-config.yaml
    kubectl apply -f srcs/yamls/nginx-service.yaml
    kubectl apply -f srcs/yamls/nginx-deployment.yaml
    kubectl apply -f srcs/yamls/wordpress-service.yaml
    kubectl apply -f srcs/yamls/wordpress-deployment.yaml
    kubectl apply -f srcs/yamls/ftps-service.yaml
    kubectl apply -f srcs/yamls/ftps-deployment.yaml
    kubectl apply -f srcs/yamls/grafana-service.yaml
    kubectl apply -f srcs/yamls/grafana-deployment.yaml
    kubectl apply -f srcs/yamls/phpmyadmin-service.yaml
    kubectl apply -f srcs/yamls/phpmyadmin-deployment.yaml
    kubectl apply -f srcs/yamls/influxdb-service.yaml
    kubectl apply -f srcs/yamls/influxdb-deployment.yaml
    kubectl apply -f srcs/yamls/influxdb-persistentVolumeClaim.yaml
    kubectl apply -f srcs/yamls/mysql-service.yaml
    kubectl apply -f srcs/yamls/mysql-deployment.yaml
    kubectl apply -f srcs/yamls/mysql-persistentVolumeClaim.yaml
}

grafana_dataset()
{
    echo $1
    name=$(kubectl get pods -o=name | grep $1 | sed "s/^.\{4\}//")
    cp srcs/grafana/srcs/dashboard.json srcs/grafana/srcs/$1.json
    sed -i "s/__dashboard_value__/$name/" srcs/grafana/srcs/$1.json
    sed -i "s/__dashboard_title__/$1/" srcs/grafana/srcs/$1.json
    kubectl exec -i $(kubectl get pods -o=name | grep grafana | sed "s/^.\{4\}//") -- /bin/sh -c "cat > /usr/share/grafana/conf/provisioning/dashboards/$1.json" < srcs/grafana/srcs/$1.json
}

grafana_all_dataset()
{
    for image in "nginx" "wordpress" "mysql" "phpmyadmin" "ftps" "grafana" "influxdb"
    do
        grafana_dataset $image
    done
}

build_all_images
minikube_setup
# grafana_all_dataset
