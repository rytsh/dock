# ---
# VERSION="0.1.0"
# ---
FROM alpine:3.18.2

LABEL maintainer="eates23@gmail.com"

COPY asset2 /asset2

ENTRYPOINT [ "/bin/cat" ]
CMD [ "/asset2" ]
