#!/bin/bash

tag="latest"

# N is the node number of the cluster
N=$1

if [ $# = 0 ]
then
	echo "Please use the node number of the cluster as the argument!"
	exit 1
fi

cd hadbase-master

# change the slaves file
echo "master.hadbase.dkr" > files/slaves
i=1
while [ $i -lt $N ]
do
	echo "slave$i.hadbase.dkr" >> files/slaves
	((i++))
done

# delete master container
docker rm -f master.hadbase.dkr

# delete hadbase-master image
docker rmi iambenzo/hadbase-master:$tag

# rebuild hadoop-docker image
pwd
docker build -t iambenzo/hadbase-master:$tag .
