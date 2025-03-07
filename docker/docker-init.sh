##################### Reference #####################
# https://docs.docker.com/engine/install/ubuntu/
#####################################################

# Removing any existing Docker-related packages
echo "Removing existing Docker-related packages..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
echo "Adding Docker's official GPG key..."
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "Adding Docker's repository to Apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo ""

# Install the Docker packages:
echo "Installing Docker packages..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo ""

# Verify that the installation is successful by running the hello-world image:
echo "Verifying Docker installation with hello-world image..."
sudo docker run hello-world

echo ""

# Manage Docker as a non-root user
echo "Setting up Docker to run as a non-root user..."
if ! getent group docker > /dev/null 2>&1; then
    sudo groupadd docker
fi
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world

echo ""

# Configure Docker to start on boot with systemd
echo "Configuring Docker to start on boot with systemd..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo ""

echo "Docker installation and configuration completed successfully!"