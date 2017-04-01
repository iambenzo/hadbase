echo Building Base Image

docker pull iambenzo/hadbase-base:latest

echo Building Master Image

docker pull iambenzo/hadbase-master:latest

echo Building Slave Image

docker pull iambenzo/hadbase-slave:latest

echo Done

cmd /k docker images
