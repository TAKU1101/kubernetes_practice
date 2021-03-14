mysql_install_db -u root

mkdir -p run/mysqld/
touch run/mysqld/mysqld.sock
mysqld -u root & sleep 5

mysql -u root -e "CREATE DATABASE wordpress;"

mysql wordpress -u root < wordpress.sql

mysql -u root -e "CREATE USER 'wp_user'@'%' identified by 'password'; GRANT ALL PRIVILEGES ON *.* TO 'wp_user'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"

# mysql -u root

telegraf &

tail -f /dev/null