MariaDB
什么是MariaDB？

MariaDB数据库管理系统是MySQL的一个分支，主要由开源社区在维护，采用GPL授权许可 MariaDB的目的是完全兼容MySQL，包括API和命令行，使之能轻松成为MySQL的代替品。在存储引擎方面，使用XtraDB（英语：XtraDB）来代替MySQL的InnoDB。 MariaDB由MySQL的创始人Michael Widenius（英语：Michael Widenius）主导开发，他早前曾以10亿美元的价格，将自己创建的公司MySQL AB卖给了SUN，此后，随着SUN被甲骨文收购，MySQL的所有权也落入Oracle的手中。MariaDB名称来自Michael Widenius的女儿Maria的名字。

MariaDB基于事务的Maria存储引擎，替换了MySQL的MyISAM存储引擎，它使用了Percona的 XtraDB，InnoDB的变体，分支的开发者希望提供访问即将到来的MySQL 5.4 InnoDB性能。这个版本还包括了 PrimeBase XT (PBXT) 和 FederatedX存储引擎。

https://zh.wikipedia.org/wiki/MariaDB
 
如何使用此镜像。

运行镜像并绑定到3306端口：
    docker run -d -p 3306:3306 centos-mariadb:5.5

Container的挂载目录为 /var/lib/mysql

环境变量

    MYSQL_ROOT_PASSWORD：root用户的密码，设置每个服务器启动时。默认为空密码，这是很方便的进行开发，但你应该将其设置为生产的东西。
    MYSQL_DATABASE：如果不存在，数据库自动创建。如果没有提供，不创建一个数据库。
    MYSQL_USER：创建一个用户可以访问由指定的数据库MYSQL_DATABASE。
    MYSQL_PASSWORD：输入密码MYSQL_USER。默认为空密码。
