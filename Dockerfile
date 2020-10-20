FROM ubuntu:20.04

# https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       git vim silversearcher-ag \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/.dotfiles

COPY . /root/.dotfiles/

RUN /bin/bash /root/.dotfiles/install.sh

CMD ["/bin/bash"]
