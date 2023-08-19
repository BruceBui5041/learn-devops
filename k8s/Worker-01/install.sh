#!/bin/bash

sudo su
cd ~
sudo apt-get -y update
sudo apt-get -y install ca-certificates curl gnupg

#Cai dat YUM
#sudo apt-get install yum

# Cai dat Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get -y update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

usermod -aG docker $(whoami)

## Create /etc/docker directory.
mkdir /etc/docker

# Setup daemon.
# cat > /etc/docker/daemon.json <<EOF
# {
#   "exec-opts": ["native.cgroupdriver=systemd"],
#   "log-driver": "json-file",
#   "log-opts": {
#     "max-size": "100m"
#   },
#   "storage-driver": "overlay2",
#   "storage-opts": [
#     "overlay2.override_kernel_check=true"
#   ]
# }
# EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart Docker
systemctl enable docker.service
systemctl daemon-reload
systemctl restart docker

# Tat SELinux
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Tat Firewall
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

# sysctl
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

# Tat swap
sed -i '/swap/d' /etc/fstab
swapoff -a

# Add yum repo file for Kubernetes
# cat >>/etc/yum.repos.d/kubernetes.repo<<EOF
# [kubernetes]
# name=Kubernetes
# baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
# enabled=1
# gpgcheck=1
# repo_gpgcheck=1
# gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
# EOF

sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSL https://dl.k8s.io/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get -y update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

remove docker config to init kubeadm
rm /etc/containerd/config.toml
systemctl restart containerd

# sudo apt-get install -y -q kubeadm kubelet kubectl

# systemctl enable kubelet
# systemctl start kubelet

# # Configure NetworkManager before attempting to use Calico networking.
# cat >>/etc/NetworkManager/conf.d/calico.conf<<EOF
# [keyfile]
# unmanaged-devices=interface-name:cali*;interface-name:tunl*
# EOF