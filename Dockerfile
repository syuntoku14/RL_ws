# https://hub.docker.com/r/naruya/
# $ docker run --runtime=nvidia -it --privileged -p 5900:5900 naruya/dl_remote

# [1] https://github.com/robbyrussell/oh-my-zsh
# [2] https://github.com/pyenv/pyenv/wiki/common-build-problems

FROM nvidia/cudagl:9.2-devel-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive

# zsh,[1] ----------------
RUN apt-get update -y && apt-get -y upgrade && apt-get install -y \
    wget curl git zsh
SHELL ["/bin/zsh", "-c"]
RUN wget http://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# pyenv,[2] ----------------
RUN apt-get update -y && apt-get -y upgrade && apt-get install -y \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
RUN curl https://pyenv.run | zsh && \
    echo '' >> /root/.zshrc && \
    echo 'export PATH="/root/.pyenv/bin:$PATH"' >> /root/.zshrc && \
    echo 'eval "$(pyenv init -)"' >> /root/.zshrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> /root/.zshrc
RUN source /root/.zshrc && \
    pyenv install 3.7.4 && \
    pyenv global 3.7.4

# X window, options ----------------
RUN apt-get install -y vim xvfb x11vnc python-opengl
RUN source /root/.zshrc && \
    pip install setuptools jupyterlab

RUN apt-get install -y tmux icewm

WORKDIR /root

# CMD ["zsh"]
