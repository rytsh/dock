# Container Builder

Generating container images for any purpose.

## Usage

Add a tag to for dockerfile:

```sh
git tag ssh/v0.1.0
git tag test/test1/v0.1.0
```

And push it to the remote:

```sh
git push origin test/test1/v0.1.0
```

## Local Usage

Give an dockerfile to `--build` parameter:

```sh
./build.sh --prefix rytsh --build ./images/test/test1.Dockerfile --version v0.1.0 --latest --push
```

Image names:  
  `rytsh/test/test1:0.1.0` -> version in dockerfile  
  `rytsh/test/test1:latest` -> _--latest_ option is used

`assets` folder near the Dockerfile.

Set extra build args in the Dockerfile:

```dockerfile
# ---
# BUILD_ARGS="--build-arg foo=bar"
# ---
```

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
