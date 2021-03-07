mysql_install_db

mkdir -p run/mysqld/
touch run/mysqld/mysqld.sock
mysqld -u root & sleep 3

mysql -e "CREATE DATABASE wpdb;"
mysql -e "CREATE USER 'wpuser'@'localhost' identified by 'dbpassword';"
mysql -e "GRANT ALL PRIVILEGES ON wpdb.* TO 'wpuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# mysql -u root

telegraf &

tail -f /dev/null