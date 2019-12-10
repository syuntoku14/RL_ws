# This Dockerfile is based on https://github.com/ikeyasu/docker-reinforcement-learning

# To use cuda9.2 container, you need to install nvidia-driver >= 396.26
# See https://github.com/NVIDIA/nvidia-docker/wiki/CUDA#requirements
FROM ikeyasu/opengl:cuda9.2-cudnn7-devel-ubuntu16.04
MAINTAINER syuntoku14 <syuntoku14@gmail.com>

ENV DEBIAN_FRONTEND oninteractive

############################################
# Default shell
############################################
SHELL ["/bin/bash", "-c"]

############################################
# Basic dependencies
############################################
RUN apt-get update --fix-missing && apt-get install -y \
    cmake zlib1g-dev libjpeg-dev xvfb libav-tools \
    xorg-dev libboost-all-dev libsdl2-dev swig \
    git wget openjdk-8-jdk ffmpeg unzip \
    && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

############################################
# Miniconda
############################################
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/miniconda.sh
RUN bash /root/miniconda.sh -b -p /root/miniconda && rm /root/miniconda.sh
ENV PATH /root/miniconda/bin:$PATH

############################################
# PyTorch ----------------
############################################

RUN conda install pytorch torchvision cudatoolkit=9.2 -c pytorch  # for cuda9.2

############################################
# PyBullet
############################################
RUN pip install pybullet

############################################
# Jupyternotebook 
############################################
RUN pip install jupyter && \
    jupyter notebook --generate-config
RUN echo "c = get_config()" >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 5000" >> ~/.jupyter/jupyter_notebook_config.py

############################################
# Jupyter vim extension 
# comment out if you don't use vim extension
############################################
RUN pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --user
RUN mkdir -p $(jupyter --data-dir)/nbextensions && cd $(jupyter --data-dir)/nbextensions && \
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
RUN jupyter nbextension enable vim_binding/vim_binding
RUN sed -i "/.*Ctrl-C.*:/d" ~/.local/share/jupyter/nbextensions/vim_binding/vim_binding.js
RUN sed -i "/.*'Shift-Esc'.*:/a\      \'Ctrl-C\': CodeMirror.prototype.leaveInsertMode," ~/.local/share/jupyter/nbextensions/vim_binding/vim_binding.js

############################################
# Gym
############################################

RUN pip install gym 'gym[atari]' 'gym[box2d]' 'gym[classic_control]'
RUN pip install matplotlib

############################################
# Other tools
############################################

RUN apt-get update && apt-get install -y mlocate less tmux vim lxterminal mesa-utils\
    && updatedb\
    && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ENV APP "lxterminal -e bash"

CMD ["bash"]
WORKDIR /root