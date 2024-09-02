# ---
# LABELS="--label org.opencontainers.image.url=github.com/rytsh/dock/tree/main/images/jupyterlab"
# ---
FROM python:3-alpine

LABEL maintainer="Eray Ates <eates23@gmail.com>"

RUN apk add --no-cache \
    # system requirements
    gcc linux-headers build-base zeromq-dev curl cmake
    # && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    # source "$HOME/.cargo/env"

# python requirements
RUN pip install \
    jupyterlab buckaroo theme-darcula pandas numpy matplotlib seaborn

# RUN pip install \
#     tensorflow torch transformers scikit-learn keras

ADD jupyter_notebook_config.json /root/.jupyter/jupyter_notebook_config.json

WORKDIR /jupyter

CMD [ "jupyter-lab", "--ip='0.0.0.0'", "--allow-root" ]
