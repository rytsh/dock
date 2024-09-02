#!/usr/bin/env bash

# Build the docker image

set -e

function usage() {
  cat - <<EOF
Building dockerfile

$0 --prefix rytsh --build images/test/test1.Dockerfile --version v0.1.0 --latest --push

Usage: $0 <OPTIONS>
OPTIONS:
  --build <DOCKERFILE>
    Specify the dockerfile to build.
  --dry-run
    Dont run commands just show it.

  --image-name <IMAGE_NAME>
    Specify the image-name directly.
    Example: rytsh/curl:0.1.0
  --version <VERSION>
    Specify the version of the docker image.
  --latest
    Tag the image additional 'latest'.
  --prefix <PREFIX>
    Specify the prefix of the docker image.
  --push
    Push the image to docker hub.
  -h, --help
    This help page
EOF
}

# Parse the command line arguments
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  --build)
    _DOCKERFILE=$2
    shift 1
    ;;
  --dry-run)
    _DRYRUN="Y"
    ;;
  --image-name)
    _IMAGE_NAME=$2
    shift 1
    ;;
  --latest)
    _LATEST="Y"
    ;;
  --prefix)
    _PREFIX=$2
    shift 1
    ;;
  --push)
    _PUSH="Y"
    ;;
  --version)
    _VERSION=$2
    shift 1
    ;;
  -h | --help )
    usage
    exit
    ;;
  *)
    echo "Unknown option: $1"
    usage
    exit 1
    ;;
esac; shift 1; done
if [[ "$1" == '--' ]]; then shift; fi

if [[ ! -e "$_DOCKERFILE" ]]; then
  echo "> Dockerfile [$_DOCKERFILE] does not exist"
  exit 1
fi

# Read metadata from dockerfile
function read_metadata() {
  eval $(grep -z -o -P '(?<=# ---)(?s).*(?=# ---)' $_DOCKERFILE | tr -d '#' | xargs --null)
}

function assets_dir() {
  _ASSETS_DIR=$(dirname ${_DOCKERFILE})/assets
  if [[ ! -d "$_ASSETS_DIR" ]]; then
    _ASSETS_DIR=""
  fi
}

function dry_run() {
  if [[ "${_DRYRUN}" == "Y" ]]; then
    echo "> $1"
  else
    echo "> $1"
    eval "$1"
  fi
}

# Get version information
read_metadata
# Get assets dir
assets_dir

# Check the tag
if [[ -z "$_IMAGE_NAME" ]]; then
  _DOCKERFILE_PATH=$(realpath --relative-to="." "${_DOCKERFILE}" | sed -e 's/^images\///')
  # Set lowercase
  _DOCKERFILE_PATH=${_DOCKERFILE_PATH,,}
  # Clean path
  _DOCKERFILE_PATH=${_DOCKERFILE_PATH%.dockerfile}
  _DOCKERFILE_PATH=${_DOCKERFILE_PATH%-dockerfile}
  _DOCKERFILE_PATH=${_DOCKERFILE_PATH%/dockerfile}
  # Set tag
  _IMAGE_NAME_BASE=${_PREFIX:+${_PREFIX}/}${_DOCKERFILE_PATH}

  _VERSION=${_VERSION:-latest}
  _IMAGE_NAME=${_IMAGE_NAME_BASE}:${_VERSION}
else
  # Parse VERSION and BASE
  _VERSION=$(echo ${_IMAGE_NAME} | awk -F':' '{print $2}')
  _VERSION=${_VERSION:-latest}
  _IMAGE_NAME_BASE=${_IMAGE_NAME%:$_VERSION}
  _IMAGE_NAME=${_IMAGE_NAME_BASE}:${_VERSION}
fi

# Build the docker image
if [[ -n "$_ASSETS_DIR" ]]; then
  dry_run "docker build -t ${_IMAGE_NAME} ${BUILD_ARGS} ${LABELS} --file ${_DOCKERFILE} ${_ASSETS_DIR}"
else
  dry_run "docker build -t ${_IMAGE_NAME} ${BUILD_ARGS} ${LABELS} - < ${_DOCKERFILE}"
fi

# Tag the image with 'latest'
if [[ "$_LATEST" == "Y" && "$_VERSION" != "latest" ]]; then
  _TAG_LATEST=${_IMAGE_NAME_BASE}:latest
  echo "> tagging latest"
  dry_run "docker tag ${_IMAGE_NAME} ${_TAG_LATEST}"
fi

# Push the image
if [[ "$_PUSH" == "Y" ]]; then
  echo "> pushing ${_IMAGE_NAME}"
  dry_run "docker push ${_IMAGE_NAME}"

  if [[ "$_LATEST" == "Y" && "$_VERSION" != "latest" ]]; then
    echo "> pushing latest ${_TAG_LATEST}"
    dry_run "docker push ${_TAG_LATEST}"
  fi
fi
