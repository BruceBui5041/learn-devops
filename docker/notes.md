## Build container into a Docker image

```bash
 docker commit <container_id> <image_name>
```

### Remove dangling image after build image

```bash
docker build --rm -t <image_name> .
```

## Docker Registry

Tag:

```bash
docker tag <username>/<image_name> <host_domain>:<registry_port>/<path?>
```

Ex:

```bash
docker tag brucebui/test-image localhost:5001/test-image
```

Push:

```bash
bash docker push <host_domain>:<registry_port>/<path?>
```

Pull:

```bash
docker pull<host_domain>:<registry_port>/<path?>
```

### Registry Authentication:

1. Use `htpasswd` to create authentication for docker registry
2. Use this command to create user with password `htpasswd -Bc .htpasswd <user_name>`

```

```
