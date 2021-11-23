FROM frolvlad/alpine-glibc

LABEL maintainer="eates23@gmail.com"
LABEL version="v0.0.1"

RUN apk add --no-cache \
    bash nodejs-current npm git curl zip && \
    curl -f https://get.pnpm.io/v6.js | node - add --global pnpm

WORKDIR /workspace
