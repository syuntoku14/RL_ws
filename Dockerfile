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
    pip install setuptools 

RUN apt-get install -y tmux icewm

WORKDIR /root

# rl libraries ----------------
RUN source /root/.zshrc && \
    pip install gym pybullet matplotlib

# uncomment jupyternotebook or jupyter lab if you want
# uncomment corresponding vim extension if use vim extension

# install jupyternotebook ----------------
# RUN source /root/.zshrc && \
#     pip install jupyter && \
#     jupyter notebook --generate-config
# RUN echo "c = get_config()" >> ~/.jupyter/jupyter_notebook_config.py
# RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py
# RUN echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
# RUN echo "c.NotebookApp.port = 5000" >> ~/.jupyter/jupyter_notebook_config.py

# set jupyter vim extension ----------------
# RUN source /root/.zshrc && \
#     pip install jupyter_contrib_nbextensions && \
#     jupyter contrib nbextension install --user
# RUN source /root/.zshrc && \
#     mkdir -p $(jupyter --data-dir)/nbextensions
# RUN source /root/.zshrc && \
#     cd $(jupyter --data-dir)/nbextensions && \
#     git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
# RUN source /root/.zshrc && \
#     jupyter nbextension enable vim_binding/vim_binding
# RUN sed -i "/.*Ctrl-C.*:/d" ~/.local/share/jupyter/nbextensions/vim_binding/vim_binding.js
# RUN sed -i "/.*'Shift-Esc'.*:/a\      \'Ctrl-C\': CodeMirror.prototype.leaveInsertMode," ~/.local/share/jupyter/nbextensions/vim_binding/vim_binding.js

# install jupyterlab ----------------
# RUN source /root/.zshrc && \
#     jupyterlab
# set jupyterlab vim extension ----------------
# RUN apt-get install -y nodejs npm 
# RUN source /root/.zshrc && \ 
#     jupyter labextension install jupyterlab_vim
# RUN source /root/.zshrc && \ 
#     jupyter labextension install @lckr/jupyterlab_variableinspector

CMD ["zsh"]