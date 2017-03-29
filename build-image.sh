#!/bin/bash

image=$1
tag='latest'


if [ $1 = 0 ]
then
	echo "Please use image name as the first argument!"
	exit 1
fi

# founction for delete images
function docker_rmi()
{
	echo -e "\n\ndocker rmi iambenzo/$1:$tag"
	docker rmi iambenzo/$1:$tag
}


# founction for build images
function docker_build()
{
	cd $1
	echo -e "\n\ndocker build -t iambenzo/$1:$tag ."
	/usr/bin/time -f "real  %e" docker build -t iambenzo/$1:$tag .
	cd ..
}

echo -e "\ndocker rm -f slave1.hadbase.dkr slave2.hadbase.dkr master.hadbase.dkr"
docker rm -f slave1.hadbase.dkr slave2.hadbase.dkr master.hadbase.dkr

docker images >images.txt

#all image is based on dnsmasq. master and slaves are based on base image.
if [ $image == "hadbase-base" ]
then
	docker_rmi hadbase-master
	docker_rmi hadbase-slave
	docker_rmi hadbase-base
	docker_build hadbase-base
	docker_build hadbase-master
	docker_build hadbase-slave
elif [ $image == "hadbase-master" ]
then
	docker_rmi hadbase-master
	docker_build hadbase-master
elif [ $image == "hadbase-slave" ]
then
	docker_rmi hadbase-slave
	docker_build hadbase-slave
else
	echo "The image name is wrong!"
fi

#docker_rmi hadbase-base

echo -e "\nimages before build"
cat images.txt
rm images.txt

echo -e "\nimages after build"
docker images
