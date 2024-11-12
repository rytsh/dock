FROM alpine:3.20.3

# add curl and ca-certificates
RUN apk --no-cache --no-progress add bash curl ca-certificates tzdata \
    openssh-client-default rsync netcat-openbsd grep gawk sed git

RUN curl -fsSL https://github.com/google/go-containerregistry/releases/download/v0.16.1/go-containerregistry_Linux_x86_64.tar.gz  | tar -oxz --overwrite -C /bin crane
