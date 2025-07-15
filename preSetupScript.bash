sudo usermod -aG docker $USER
newgrp docker
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
