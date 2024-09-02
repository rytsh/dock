# jupyterlab

Main password is `secretpass`.

```sh
# -d --restart always
docker run -it --rm -p 8888:8888 -v ~/jupyter:/jupyter --name jupyterlab -h jupyter ghcr.io/rytsh/dock/jupyterlab:latest
```

## Change Password

Open terminal on jupyter and run this command. After this command restart container.

```sh
# in jupyterlab terminal
jupyter notebook password
```

Restart docker container

```sh
docker restart <ContainerID>
```
