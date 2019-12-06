#!/usr/bin/env bash

if [ $# -eq 0 ]
then
	echo "No directory path supplied"
else
	docker run --rm -it -v $1:/logs -p 6006:6006 syuntoku/tensorboard
fi
