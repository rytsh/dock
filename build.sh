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
  --dry-run
    Dont run commands just show it.

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
  --dry-run)
    DRYRUN="Y"
    ;;
  --tag)
    TAG_VERSION=$2
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

if [[ ! -e "$DOCKERFILE" ]]; then
  echo "> Dockerfile [$DOCKERFILE] does not exist"
  exit 1
fi

# Check the tag
if [[ -z "$TAG_VERSION" ]]; then
  _DOCKERFILE_PATH=$(realpath --relative-to="." "$DOCKERFILE" | tr "/" "-")
  # Set lowercase
  _DOCKERFILE_PATH=${_DOCKERFILE_PATH,,}
  # Clean path
  _DOCKERFILE_PATH=${_DOCKERFILE_PATH%.dockerfile}
  _DOCKERFILE_PATH=${_DOCKERFILE_PATH%-dockerfile}
  # Set tag
  TAG=${USERNAME:+${USERNAME}/}${_DOCKERFILE_PATH}

  # Get version information
  VERSION=$(cat $DOCKERFILE | grep "LABEL version" | cut -d "=" -f2 | tr -d '"')

  TAG_VERSION=${TAG}:${VERSION}
else
  # Parse VERSION and TAG
  _BASE_TAG=${TAG_VERSION##*/}
  VERSION=${_BASE_TAG##*:}
  TAG=${TAG_VERSION%:$VERSION}
fi

# Build the docker image
if [[ "${DRYRUN}" == "Y" ]]; then
  echo docker build -t ${TAG_VERSION} - ${DOCKERFILE}
else
  docker build -t ${TAG_VERSION} - < ${DOCKERFILE}
fi

# Tag the image with 'latest'
if [[ "$LATEST" == "Y" && "$VERSION" != "latest" ]]; then
  TAG_LATEST=${TAG}:latest
  echo "> tagging latest"
  if [[ "${DRYRUN}" == "Y" ]]; then
    echo docker tag ${TAG_VERSION} ${TAG_LATEST}
  else
    docker tag ${TAG_VERSION} ${TAG_LATEST}
  fi
fi

# Push the image to docker hub
if [[ "$PUSH" == "Y" ]]; then
  echo "> pushing ${TAG_VERSION}"
  if [[ "${DRYRUN}" == "Y" ]]; then
    echo docker push ${TAG_VERSION}
  else
    docker push ${TAG_VERSION}
  fi
  if [[ "$LATEST" == "Y" ]]; then
    echo "> pushing latest ${TAG_LATEST}"
    if [[ "${DRYRUN}" == "Y" ]]; then
      echo docker push ${TAG_LATEST}
    else
      docker push ${TAG_LATEST}
    fi
  fi
fi
