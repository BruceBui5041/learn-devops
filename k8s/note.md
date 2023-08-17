## User Kubernetes Admin to set Master Node

```bash
kubeadm init --apiserver-advertise-address=172.16.129.128 --pod-network-cidr=172.16.0.0/16
# 172.16.0.0/16 is the default CIDR for flannel ( calico network plugin )
```

### if you run the command above and get error like this: `[ERROR CRI]: container runtime is not running:`

```bash
# run this command to fix it
rm /etc/containerd/config.toml
sudo systemctl restart containerd

# and then run the command kubeadm above again
```
