# ---
# ---
FROM alpine:3.23.2

# add curl and ca-certificates
RUN apk --no-cache --no-progress add bash curl ca-certificates tzdata

RUN curl -fsSL https://github.com/mikefarah/yq/releases/download/v4.50.1/yq_darwin_amd64.tar.gz -o /usr/bin/yq && \
    chmod +x /usr/bin/yq
