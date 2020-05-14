#!/bin/sh

# install fish
if which apt > /dev/null; then
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install fish
fi