FROM frolvlad/alpine-glibc

LABEL maintainer="eates23@gmail.com"
LABEL version="v0.0.2"

RUN apk add --no-cache \
    bash nodejs-current npm git curl zip

RUN npm install -g pnpm@6.24.2

WORKDIR /workspace
