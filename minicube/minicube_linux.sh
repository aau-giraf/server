#!/bin/bash 

cd /tmp

# minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.17.0/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# kvm driver
sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.7.0/docker-machine-driver-kvm -o /usr/local/bin/docker-machine-driver-kvm
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm

. /etc/os-release
case "$ID_LIKE" in
fedora)
    sudo yum -y install libvirt-daemon-kvm kvm
    sudo usermod -a -G libvirt $(whoami)
    newgrp libvirt
    ;;
debian)
    sudo apt -y install libvirt-bin qemu-kvm
    sudo usermod -a -G libvirtd $(whoami)
    newgrp libvirtd
    ;;
*)
    echo "distro not supported"
    exit 1
    ;;
esac

sudo systemctl enable libvirt-guests.service
sudo systemctl start libvirt-guests.service

minikube start --driver-vm=kvm
