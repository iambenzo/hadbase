#!/bin/bash

# run N slave containers
tag=$1
N=$2

if [ $# != 2  ]
then
	echo "Set first parametar as image version tag(e.g. 0.1) and second as number of nodes"
	exit 1
fi

# delete old master container and start new master container
docker rm -f master.hadbase.dkr &> /dev/null
echo "start master container..."
docker run -d -t --restart=always --dns 127.0.0.1 -P --name master.hadbase.dkr -h master.hadbase.dkr -w /root iambenzo/hadbase-master:$tag&> /dev/null

# get the IP address of master container
FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" master.hadbase.dkr)

# delete old slave containers and start new slave containers
i=1
while [ $i -le $N ]
do
	docker rm -f slave$i.hadbase.dkr &> /dev/null
	echo "start slave$i container..."
	docker run -d -t --restart=always --dns 127.0.0.1 -P --name slave$i.hadbase.dkr -h slave$i.hadbase.dkr -e JOIN_IP=$FIRST_IP iambenzo/hadbase-slave:$tag &> /dev/null
	((i++))
done


# create a new Bash session in the master container
docker exec -it master.hadbase.dkr bash
