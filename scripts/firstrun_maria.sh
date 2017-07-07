#!/bin/bash

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

MARIADB_NEW=true

#
#  MariaDB setup
#
firstrun_maria() {

	# First install mariadb
	if [[ ! -d ${DATA_DIR}/mysql ]]; then
	    echo "===> MariaDB not install..."

        echo "===> Initializing maria database... "
	   	mysql_install_db --user=mysql --ldata=${DATA_DIR}
        echo "===> System databases initialized..."

	   	# Start mariadb
                /usr/bin/mysqld_safe --user mysql > /dev/null 2>&1 &

        echo "===> Waiting for MariaDB to start..."

		STA=1
		while [[ STA -ne 0 ]]; do
            printf "."
			sleep 5
			mysql -uroot -e "status" > /dev/null 2>&1
			STA=$?
		done
        echo "===> Start OK..."

tfile=/tmp/temp.sql

cat << EOF > $tfile
USE mysql;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
UPDATE user SET password=PASSWORD("$MYSQL_ROOT_PASSWORD") WHERE user='root';
FLUSH PRIVILEGES;
EOF

if [[ $MYSQL_DATABASE != "" ]]; then
    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile
    echo "FLUSH PRIVILEGES;" >> $tfile

    if [[ $MYSQL_USER != "" ]]; then
        echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'127.0.0.1' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
        echo "FLUSH PRIVILEGES;" >> $tfile
    fi
fi

mysql -u root < $tfile

sleep 2

mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
rm -f $tfile

        if [[ -e ${DATA_DIR}/mysql.sock ]]; then
            rm -f ${DATA_DIR}/mysql.sock
        fi

        MARIADB_NEW=false

	   	echo "===> Using an existing volume of MariaDB"
	fi
}

firstrun_maria
