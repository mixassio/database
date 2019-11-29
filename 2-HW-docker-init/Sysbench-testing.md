# Настройка БД

```
➜  database git:(master) ✗ sudo systemctl status mysql
● mysql.service - MySQL Community Server
   Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2019-11-29 14:57:31 MSK; 2min 7s ago
 Main PID: 21665 (mysqld)
    Tasks: 27 (limit: 4915)
   CGroup: /system.slice/mysql.service
           └─21665 /usr/sbin/mysqld --daemonize --pid-file=/run/mysqld/mysqld.pid

ноя 29 14:57:30 me-bondarev systemd[1]: Starting MySQL Community Server...
ноя 29 14:57:31 me-bondarev systemd[1]: Started MySQL Community Server.
➜  database git:(master) ✗ mysql
ERROR 1045 (28000): Access denied for user 'me-bondarev'@'localhost' (using password: NO)
➜  database git:(master) ✗ /usr/bin/mysql -u root -p
Enter password:
ERROR 1698 (28000): Access denied for user 'root'@'localhost'
➜  database git:(master) ✗ sudo /usr/bin/mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.7.28-0ubuntu0.18.04.4 (Ubuntu)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> CREATE SCHEMA sbtest;
Query OK, 1 row affected (0.00 sec)

mysql> CREATE USER sbtest@'%' IDENTIFIED BY 'password';
Query OK, 0 rows affected (0.00 sec)

mysql> GRANT ALL PRIVILEGES ON sbtest.* to sbtest@'%';
Query OK, 0 rows affected (0.00 sec)

mysql> exit
Bye
```

# Подготовка к тестам

```
➜  database git:(master) ✗ sysbench oltp_read_write --table-size=10000 --mysql-user=sbtest --mysql-password=password --db-driver=mysql prepare
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)

Creating table 'sbtest1'...
Inserting 10000 records into 'sbtest1'
Creating a secondary index on 'sbtest1'...

```

# Запуск тестов и вывод результатов

```
➜  database git:(master) ✗ sysbench oltp_read_write --table-size=10000 --threads=10 --max-requests=500 --mysql-user=sbtest --mysql-password=password --db-driver=mysql run
WARNING: --max-requests is deprecated, use --events instead
sysbench 1.0.11 (using system LuaJIT 2.1.0-beta3)

Running the test with following options:
Number of threads: 10
Initializing random number generator from current time


Initializing worker threads...

Threads started!

SQL statistics:
    queries performed:
        read:                            7000
        write:                           2000
        other:                           1000
        total:                           10000
    transactions:                        500    (98.85 per sec.)
    queries:                             10000  (1976.98 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          5.0522s
    total number of events:              500

Latency (ms):
         min:                                 50.04
         avg:                                100.19
         max:                                333.96
         95th percentile:                    189.93
         sum:                              50095.18

Threads fairness:
    events (avg/stddev):           50.0000/1.10
    execution time (avg/stddev):   5.0095/0.02

➜  database git:(master) ✗
```
