# telegraf start (deamon)
telegraf &

# nginx start
nginx

# php start (-S: start built-in web server in port, -t: Built-in web server directory) 
/usr/bin/php -S 0.0.0.0:5050 -t /var/www/wordpress