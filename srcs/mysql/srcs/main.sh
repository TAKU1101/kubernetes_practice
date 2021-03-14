# Create a new MySQL permissions table
mysql_install_db -u root

# mysql start (deamon) (run/mysqld/mysqld.sock is missing, but mysqld will not run without it)
mkdir -p run/mysqld/
touch run/mysqld/mysqld.sock
mysqld -u root & sleep 5

# create wordpress database
mysql -u root -e "CREATE DATABASE wordpress;"

# setup wordpress database
mysql wordpress -u root < wordpress.sql

# user, permission setup
mysql -u root -e "CREATE USER 'wp_user'@'%' identified by 'password'; GRANT ALL PRIVILEGES ON *.* TO 'wp_user'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"

# telegraf start (deamon)
telegraf &

# loop
tail -f /dev/null