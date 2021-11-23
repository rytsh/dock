# Dockerfiles

Generating docker images for any purpose.

```sh
./build.sh --user ryts --build ./frontend/deno.Dockerfile --latest --push
```

For more information, run `./build.sh --help`.

```text
  --build <DOCKERFILE>
    Specify the dockerfile to build.

  --tag <TAG>
    Specify the tag of the docker image.
  --latest
    Tag the image additional 'latest'.
  --user <USER>
    Specify the user of docker hub.
  --push
    Push the image to docker hub.
```
