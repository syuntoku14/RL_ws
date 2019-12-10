#!/bin/bash

tmux rename-window main
tmux split-window -h
tmux split-window -v -t main.0
tmux split-window -v -t main.1
tmux select-layout tiled
