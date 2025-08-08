FROM golang:1.24.6

ARG GOLANGCI_LINT_VERSION=v1.60.1
ARG GOTESTSUM_VERSION=v1.12.0
ARG GORELEASER_VERSION=v2.11.2

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    vim curl grep sed unzip git unixodbc-dev

ENV LD_LIBRARY_PATH="/usr/lib"

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin $GOLANGCI_LINT_VERSION &&\
    golangci-lint --version &&\ 
    # Gotestsum to make nice reports on service tests
    go install gotest.tools/gotestsum@${GOTESTSUM_VERSION:-latest} &&\
    go install github.com/goreleaser/goreleaser/v2@${GORELEASER_VERSION:-latest}

WORKDIR /workspace

CMD /bin/bash