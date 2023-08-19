## Using port-forward to access a pod from outside the cluster

### Only use this for debugging or testing purpose

```bash
kubectl port-forward <pod_name> 8080:80
```

# Notes

1. Một pod có thể có nhiều container chia sẽ resource với nhau, các container trong pod có thể giao tiếp với nhau thông qua localhost
2. Có thể giới hạn số container trong pod và thay đổi resource của từng container và cả của pod
