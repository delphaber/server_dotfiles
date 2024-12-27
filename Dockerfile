FROM debian:12

# https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dotfiles prerequisites
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git git-extras less vim \
    bash bash-completion ripgrep tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install ca-certificates because container won't be able to connect to https sites without it.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates \
    && update-ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR "/root/.dotfiles"

CMD ["/bin/bash"]

