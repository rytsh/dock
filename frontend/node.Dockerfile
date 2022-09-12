FROM debian:11.4-slim

LABEL maintainer="eates23@gmail.com"
LABEL version="v0.1.0"

RUN apt-get update && apt-get install -y \
    bash git curl zip

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - 

RUN apt-get update && apt-get install -y \
    nodejs gcc g++ make

RUN npm install -g pnpm@7.11.0

WORKDIR /workspace
