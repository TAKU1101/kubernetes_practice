build_image()
{
    echo images: $1
    docker build -t ${1}_image srcs/${1}/
}

build_all_images()
{
    for image in "nginx" "wordpress" "mysql" "phpmyadmin" "ftps" "grafana" "influxdb"
    do
        build_image $image
    done
}

build_all_images
