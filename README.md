# hadbase
Quickly build arbitrary size Hadoop cluster with Docker. Includes Hadoop and HBase
------
This project is based on the work of [krejcmat](https://github.com/krejcmat/hadoop-hbase-docker/).

###### Version of products
| system          | version    |
| ----------------|:----------:|
| HBase           | 1.2.4      |

Used versions of Hadoop and HBase are officially compatible - fully tested.
As handler of HBase native Zookeeper is used. For large clusters, it is highly recommended to use external Zookeeper management (not included).

### Usage (Easymode)

#### Clone Git Repository
```
$ git clone https://github.com/iambenzo/hadbase.git
$ cd hadbase
```

###### Build From Source
```
$ ./build-image.sh hadbase-base
```

###### Check images
```
$ docker images

iambenzo/hadbase-master               latest              2f86a3daef76        48 minutes ago           1.091 GB
iambenzo/hadbase-slave                latest              ed119b77ecdf        53 minutes ago           1.091 GB
iambenzo/hadbase-base                 latest              00fd6c19004f        58 minutes ago           1.091 GB

```

#### Initialize Hadoop (Master and Slaves)
```
$ ./start-container.sh latest 2
```

#### Initialize Hbase database and run Hbase shell

###### Start Everything
```
$ cd ~
$ ./docker-entrypoint.sh

(hbase(main):001:0>)
```

###### Check status
```
(hbase(main):001:0>)$ status

2 servers, 0 dead, 1.0000 average load
```

#### Control Cluster From Web UI

###### Access From Parent Computer of Docker Container
Check IP address in master container
```
$ ip a

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
4: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.2/16 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:acff:fe11:2/64 scope link
       valid_lft forever preferred_lft forever

```
So your IP address is 172.17.0.2

To get the IP of your slave containers, you can ping the hostnames from the master

```
$ ping slave1.hadbase.dkr
```

Use your hosts file on the host machine to map the above IP addresses to the relevant hostnames. (IP addresses may be different)

```
172.17.0.2       master.hadbase.dkr
172.17.0.3       slave1.hadbase.dkr
172.17.0.4       slave2.hadbase.dkr
```


###### HBase usage
[python wrapper for HBase rest API](http://blog.cloudera.com/blog/2013/10/hello-starbase-a-python-wrapper-for-the-hbase-rest-api/)

[usage of Java API for Hbase](https://autofei.wordpress.com/2012/04/02/java-example-code-using-hbase-data-model-operations/)

[Hbase shell commands](https://learnhbase.wordpress.com/2013/03/02/hbase-shell-commands/)
