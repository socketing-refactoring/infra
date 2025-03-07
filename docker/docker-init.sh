##################### Reference #####################
# https://docs.docker.com/engine/install/ubuntu/
#####################################################

# Removing any existing Docker-related packages
echo -e "Removing existing Docker-related packages...\n"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
echo -e "\nAdding Docker's official GPG key...\n"
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo -e "\nAdding Docker's repository to Apt sources...\n"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the Docker packages:
echo -e "\nInstalling Docker packages...\n"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify that the installation is successful by running the hello-world image:
echo -e "\nVerifying Docker installation with hello-world image...\n"
sudo docker run hello-world

echo -e "\nDocker installation completed successfully!\n"

# Manage Docker as a non-root user
echo -e "Setting up Docker to run as a non-root user...\n"
if ! getent group docker > /dev/null 2>&1; then
    sudo groupadd docker
fi
sudo usermod -aG docker $USER
newgrp docker

echo -e "User has been successfully added to the Docker group."
