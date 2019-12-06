docker run --rm -it --privileged \
	-p 5900:5900 \
	-p 8888:8888 \
	-v ~/RL_ws:/root/RL_ws \
	-e DISPLAY=$DISPLAY \
	--name rl \
	--entrypoint "" \
	syuntoku/dl_remote bash -c "umask 0002 && zsh"
	# --runtime=nvidia \