# Dockerfiles
The repository of Dockerfiles

## Reference: common commands

### General management purpose
```sh
# Show all running containers
docker ps
# Show all containers(include stopped)
docker ps -a

# Show all avaliable images
docker images

# Remove container
docker rm <contanier id or name>
# Force remove container(even if it's in running status)
docker rm -f <contanier id or name>

# Remove image
docker rmi <image id or name:tag>
```

### Start/stop
```sh
docker start <contanier id or name>
docker stop <contanier id or name>
```

### Attach to container and run bash
```sh
docker exec -it <contanier id or name> bash
```
