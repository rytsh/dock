FROM alpine:3.23.0

RUN apk add --no-cache \
    bash curl iptables nodejs pnpm ca-certificates icu-data-full

ENV SHELL=/bin/bash
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN pnpm setup && \
    pnpm install --dangerously-allow-all-builds -g n8n@2.1.0

RUN curl -fsSL https://github.com/rakunlabs/turna/releases/download/v0.8.17/turna_Linux_x86_64.tar.gz | tar -oxz --overwrite -C / turna

USER 0
ENTRYPOINT [ "/turna" ]
