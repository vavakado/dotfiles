#!/usr/bin/env bash

cd ~/.asdf/installs/
dwarfs python.dwarfs python-ro
fuse-overlayfs -o lowerdir=python-ro,upperdir=python-rw,workdir=python-work python
