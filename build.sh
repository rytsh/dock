#!/usr/bin/env bash

# Build the docker image

set -e

function usage() {
  cat - <<EOF
Building dockerfile

Usage: $0 <OPTIONS>
OPTIONS:
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
  -h, --help
    This help page
EOF
}

# Parse the command line arguments
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  --build)
    DOCKERFILE=$2
    shift 1
    ;;
  --tag)
    TAG=$2
    shift 1
    ;;
  --latest)
    LATEST="Y"
    ;;
  --user)
    USERNAME=$2
    shift 1
    ;;
  --push)
    PUSH="Y"
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

# Check the tag
if [[ -z "$TAG" ]]; then
  path=$(realpath --relative-to="." "$DOCKERFILE" | tr "/" "-")
  # clean path
  path=${path%.Dockerfile}
  path=${path%.dockerfile}
  path=${path%-Dockerfile}
  path=${path%-dockerfile}
  # set tag
  TAG=${USERNAME:+${USERNAME}/}${path%.Dockerfile}

  # Get version information
  VERSION=$(cat $DOCKERFILE | grep "LABEL version" | cut -d "=" -f2 | tr -d '"')

  TAG_VERSION=${TAG}:${VERSION}
  TAG_LATEST=${TAG}:latest
fi

if [[ ! -e "$DOCKERFILE" ]]; then
  echo "> Dockerfile [$DOCKERFILE] does not exist"
  exit 1
fi

# Build the docker image
docker build -t $TAG_VERSION - < $DOCKERFILE

# Tag the image with 'latest'
if [[ "$LATEST" == "Y" ]]; then
  docker tag $TAG_VERSION $TAG_LATEST
fi

# Push the image to docker hub
if [[ "$PUSH" == "Y" ]]; then
  echo "> pushing $TAG_VERSION"
  docker push $TAG_VERSION
  if [[ "$LATEST" == "Y" ]]; then
    echo "> pushing latest $TAG_LATEST"
    docker push $TAG_LATEST
  fi
fi
