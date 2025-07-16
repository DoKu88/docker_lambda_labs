Notes for using Docker on Lambda Labs with large tar's since Dockerfile COPY command creates a layer & costs memory & time. 

========================================
GOOD COMMANDS: 06/07/2025
========================================

MUST RUN every new instance:
--------------------------------
sudo usermod -aG docker $USER

newgrp docker

sudo nvidia-ctk runtime configure --runtime=docker

sudo systemctl restart docker


========================================
DOCKER IMAGE REDUCED SIZE COMMANDS: 07/14/2025
========================================

We're going to first create a docker container that runs a local server
then curl the necessary tar's from that local server into our main container. 
This saves us a lot of TIME & MEMORY since we're not storing the tar within a layer
-----------------------------------------------------------------------------------

cd ./server

docker build -t my-python-server .
docker run -d -p 8000:8000 -v ./tars:/data my-python-server

cd ../app

docker build --no-cache --network=host -t sonic_07_14_2025 .

docker run -it --rm --runtime=nvidia --gpus all \
--hostname sonicHost_$(date +%m_%d_%H_%M_%S) --name sonicContainer_$(date +%m_%d_%H_%M_%S) \
-v /home/ubuntu/knucklesVirgina:/home/ubuntu/knucklesVirgina \
sonic_07_14_2025 bash


