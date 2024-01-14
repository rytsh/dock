# ---
# ---
FROM alpine:3.18.2

LABEL maintainer="eates23@gmail.com"

# add curl and ca-certificates
RUN apk --no-cache --no-progress add bash curl ca-certificates tzdata

RUN curl -fsSL https://github.com/mikefarah/yq/releases/download/v4.34.2/yq_linux_amd64 -o /usr/bin/yq && \
    chmod +x /usr/bin/yq
