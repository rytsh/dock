FROM alpine:3.16.2

LABEL version="3.16.2-1"

# add curl and ca-certificates
RUN apk --no-cache --no-progress add bash curl ca-certificates tzdata

RUN curl -fsSL https://github.com/mikefarah/yq/releases/download/v4.27.5/yq_linux_amd64 -o /usr/bin/yq && \
    chmod +x /usr/bin/yq
