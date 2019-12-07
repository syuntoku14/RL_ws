# Tools for RL research

## Docker

Main Dockerfile is based on: https://qiita.com/namahoge/items/cf39320e9acc5b96d1a6

Launch a container:
```
./scripts/run_docker.bash
```

## vnc server

Run vnc server inside the container:
```
/root/RL_ws/scripts/run_vnc.bash
```

Access vnc from [chrome vnc extension](https://chrome.google.com/webstore/detail/vnc%C2%AE-viewer-for-google-ch/iabmpiboiopbgfabjmgeedhcmjenhbla?utm_source=chrome-app-launcher-info-dialog).

## jupyter notebook

Uncomment corresponding lines if you want to use jupyternotebook or jupyterlab. See Dockerfile.

Run jupyter notebook server:

```
/root/RL_ws/scripts/run_jupyter.bash
```

Then you can access the notebook from any browser localhost:8888 

## others

* split_window.sh splits the window into 4 panes in tmux