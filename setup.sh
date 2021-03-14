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
    kubectl apply -f srcs/yamls/nginx.yaml
    kubectl apply -f srcs/yamls/metallb-config.yaml
    kubectl apply -f srcs/yamls/wordpress.yaml
    kubectl apply -f srcs/yamls/ftps.yaml
    kubectl apply -f srcs/yamls/grafana.yaml
    kubectl apply -f srcs/yamls/influxdb.yaml
    kubectl apply -f srcs/yamls/mysql.yaml
    kubectl apply -f srcs/yamls/phpmyadmin.yaml
    # kubectl apply -f srcs/yamls/nginx_pod.yaml
    # kubectl apply -f srcs/yamls/nginx_service.yaml
}

build_all_images
minikube_setup
