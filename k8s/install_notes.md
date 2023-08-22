## User Kubernetes Admin to set Master Node

```bash
kubeadm init --apiserver-advertise-address=172.168.24.128 --pod-network-cidr=172.168.0.0/16
# 172.16.0.0/16 is the default CIDR for flannel ( calico network plugin )
```

## Install Calico Network Plugin

Link: https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises

### Install Calicoctl

```bash
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
```

### Get Calico config file

```bash
wget https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
```

After pulled the file, go into the file and change the "cidr: 192.168.0.0/16" to your current server ip

### Create the manifest in order to install Calico.

```bash
kubectl create -f custom-resources.yaml
```

### Verify Calico installation in your cluster.

```bash
kubectl get pods -n calico-system
```

## Then you can join any number of worker nodes by running the following on each as root:

```bash
# the token and the ip will be different in your case
kubeadm join 192.168.24.130:6443 --token 5eq7p5.vj8azeiasb904miu --discovery-token-ca-cert-hash sha256:81c9b3fcf2e806a4b4b87c4bc249eb6ce2258f208dbfc5b7c69b629c718a8e7a

# use the command below to get new join command
kubeadm token create --print-join-command
```

## Kubectl Cheat Sheet

```bash
kubectl get nodes
# -o wide will show the ip of the pod
kubectl get node -o wide

kubectl get pods
```
