# Configure Docker to start on boot with systemd
echo "Configuring Docker to start on boot with systemd..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo "Docker installation and configuration completed successfully!"
