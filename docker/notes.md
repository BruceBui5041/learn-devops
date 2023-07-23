# Build container into a Docker image

`docker commit <container_id> <image_name>`

Remove dangling image after build image
`docker build --rm -t <image_name> .`

# Docker Registry

Tag:`docker tag <username>/<image_name> <host_domain>:<registry_port>/<path?>`
Ex: docker tag brucebui/test-image localhost:5001/test-image

Push: `docker push <host_domain>:<registry_port>/<path?>`
Pull: `docker pull<host_domain>:<registry_port>/<path?>`
