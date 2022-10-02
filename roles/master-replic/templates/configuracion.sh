echo "[mysqld]" >> /etc/my.cnf
echo "datadir=/var/lib/mysql" >> /etc/my.cnf
echo "socket=/var/lib/mysql/mysql.sock" >> /etc/my.cnf
echo "server_id=1" >> /etc/my.cnf
echo "log-basename=master" >> /etc/my.cnf
echo "log-bin" >> /etc/my.cnf
echo "binlog-format=row" >> /etc/my.cnf
echo "binlog-do-db=laravel" >> /etc/my.cnf