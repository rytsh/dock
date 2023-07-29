# Container Builder

Generating container images for any purpose.

## Usage

Give an dockerfile to `--build` parameter:

```sh
./build.sh --prefix rytsh --build ./images/test/test1.Dockerfile --latest --push
```

Image names:  
  `rytsh/test/test1:0.1.0` -> version in dockerfile  
  `rytsh/test/test1:latest` -> _--latest_ option is used

`assets` folder near the Dockerfile.

Set version in the Dockerfile:

```dockerfile
# ---
# VERSION="3.18.2"
# ---
```

You can also add extra options for build with `BUILD_ARGS="--build-arg foo=bar"` value.

For more information, run `./build.sh --help`.

```text
  --build <DOCKERFILE>
    Specify the dockerfile to build.
  --dry-run
    Dont run commands just show it.

  --image-name <IMAGE_NAME>
    Specify the image-name directly.
    Example: rytsh/curl:0.1.0
  --latest
    Tag the image additional 'latest'.
  --prefix <PREFIX>
    Specify the prefix of the docker image.
  --push
    Push the image to docker hub.
  -h, --help
    This help page
```
