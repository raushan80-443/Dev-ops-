#!/bin/bash

# List of packages to install
packages=(
    git
    vim
    docker.io

  
)

# Update package list
sudo apt update

# Function to check and install a package
install_if_missing() {
    if ! dpkg -l | grep -q "^ii  $1 "; then
        echo "$1 is not installed. Installing..."
        sudo apt install -y "$1"
    else
        echo "✅ $1 is already installed."
    fi
}

# Install the APT packages
for package in "${packages[@]}"; do
    install_if_missing "$package"
done



# Install kubectl separately as it needs to be moved to a specific directory
if ! command -v kubectl &> /dev/null; then
    echo "kubectl is not installed. Downloading..."
    
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/\
    $(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

    echo "kubectl installed."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

else
    echo "✅ kubectl is already installed."
fi



# Install Brave Browser if not installed (check the package in a different way)
if ! dpkg -l | grep -q "^ii  brave-browser "; then
    echo "Brave Browser is not installed. Installing..."
    sudo apt install curl

	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg 
	https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] \
	https://brave-browser-apt-release.s3.brave.com/ stable main"|	
	sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
    
    sudo apt install -y brave-browser
else
    echo "✅ Brave Browser is already installed."
fi



echo "Setup complete!"



