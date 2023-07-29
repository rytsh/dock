# ---
# VERSION="0.1.0"
# BUILD_ARGS="--build-arg foo=bar"
# ---
FROM alpine:3.18.2

LABEL maintainer="eates23@gmail.com"

ARG foo
ENV foo=${foo}

# add curl and ca-certificates
COPY asset1 /asset1

ENTRYPOINT [ "/bin/cat" ]
CMD [ "/asset1" ]
