# Dockerfiles

Generating docker images for any purpose.

## Usage

```sh
./build.sh --user rytsh --build ./frontend/deno.Dockerfile --latest --push
```

Image names:  
  `rytsh/frontend-deno:v0.0.1` -> version label in dockerfile  
  `rytsh/frontend-deno:latest` -> --latest option is used


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
