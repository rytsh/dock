FROM golang:1.18 as builder

LABEL maintainer="eates23@gmail.com"
LABEL version="v0.1.0"

ARG GOPROXY=https://proxy.golang.org/

# stable version for go 1.18
RUN CGO_ENABLED=0 go install -trimpath golang.org/x/pkgsite/cmd/frontend@9ffe8b928e4fbd3ff7dcf984254629a47f8b6e63 && \
    CGO_ENABLED=0 go install -trimpath golang.org/x/pkgsite/devtools/cmd/db@9ffe8b928e4fbd3ff7dcf984254629a47f8b6e63

WORKDIR /workspace
RUN cp -a /go/pkg/mod/golang.org/x/pkgsite*/static \
        /go/pkg/mod/golang.org/x/pkgsite*/third_party \
        /go/bin/frontend /go/bin/db . && \
    mkdir -p golang.org/x/pkgsite@v0.0.0-20220614140003-9ffe8b928e4f && \
    cp -a /go/pkg/mod/golang.org/x/pkgsite*/migrations golang.org/x/pkgsite@v0.0.0-20220614140003-9ffe8b928e4f/migrations

FROM alpine:3.16.0

RUN apk --no-cache --no-progress add ca-certificates tzdata

COPY --from=builder /workspace /workspace

WORKDIR /workspace

EXPOSE 8080
ENTRYPOINT /workspace/db create && /workspace/db migrate && /workspace/frontend -host 0.0.0.0:8080
# [CMD] -proxy_url http://172.17.0.1:4444
