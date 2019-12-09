# Tools for RL research

## Docker

Main Dockerfile is based on: https://github.com/ikeyasu/docker-reinforcement-learning

Build:
```
docker build -t <name>/<tag> .
```

Launch a container:
```
./scripts/run_docker.bash
```

## vnc server

Run vnc server inside the container:
```
/root/RL_ws/scripts/run_vnc.bash
```

You can access the desktop from any browser localhost:6080 

## jupyter notebook

Uncomment corresponding lines if you want to use jupyternotebook or jupyterlab. See Dockerfile.

Run jupyter notebook server:

```
/root/RL_ws/scripts/run_jupyter.bash
```

Then you can access the notebook from any browser localhost:8888 

## others

* split_window.sh splits the window into 4 panes in tmux
