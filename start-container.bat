echo Removing old master container

docker rm -f master.hadbase.dkr

echo Starting Master Container...

docker run -d -t --restart=always --dns 127.0.0.1 -P --name master.hadbase.dkr -h master.hadbase.dkr -w /root iambenzo/hadbase-master:latest

echo Getting Master IP Address

FOR /F "tokens=* delims= " %%A IN ('docker inspect --format="{{.NetworkSettings.IPAddress}}" master.hadbase.dkr') DO SET firstIP=%%A

echo Master IP: %firstIP%

echo Starting Slave 1

docker rm -f slave1.hadbase.dkr

docker run -d -t --restart=always --dns 127.0.0.1 -P --name slave1.hadbase.dkr -h slave1.hadbase.dkr -e JOIN_IP=%firstIP% iambenzo/hadbase-slave:latest

echo Starting Slave 2

docker rm -f slave2.hadbase.dkr

docker run -d -t --restart=always --dns 127.0.0.1 -P --name slave2.hadbase.dkr -h slave2.hadbase.dkr -e JOIN_IP=%firstIP% iambenzo/hadbase-slave:latest

cmd /k docker exec -it master.hadbase.dkr bash
