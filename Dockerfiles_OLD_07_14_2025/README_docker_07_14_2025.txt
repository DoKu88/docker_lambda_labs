# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit.gpg
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sed 's#https://#signed-by=/usr/share/keyrings/nvidia-container-toolkit.gpg &#' | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# Install the toolkit
sudo apt update
sudo apt install -y nvidia-container-toolkit

# Restart Docker
sudo systemctl restart docker

====================

the old way is depreciated. 
--------------------------------

Lambda Labs already has this installed
nvidia-container-toolkit --version
NVIDIA Container Runtime Hook version 1.17.4

--------------------------------
docker run --rm --runtime=nvidia --gpus all nvidia/cuda:12.2.0-base-ubuntu20.04 nvidia-smi

docker run -it --rm --runtime=nvidia --gpus all -v /home/ubuntu/knucklesVirgina:/home/ubuntu/knucklesVirgina nvidia/cuda:12.2.0-base-ubuntu20.04 bash

========================================
GOOD COMMANDS: 06/07/2025
========================================

MUST RUN every new instance:
--------------------------------
sudo usermod -aG docker $USER
newgrp docker
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker


docker build --no-cache -t sonic_06_07_2025 .

docker run -it --rm --runtime=nvidia --gpus all \
--hostname sonicHost_$(date +%m_%d_%H_%M_%S) --name sonicContainer_$(date +%m_%d_%H_%M_%S) \
-v /home/ubuntu/knucklesVirgina:/home/ubuntu/knucklesVirgina \
sonic_06_07_2025 bash


