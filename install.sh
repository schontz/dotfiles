#!/bin/bash

# get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# alias to our dot files
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/alias ~/.alias
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/gvimrc ~/.gvimrc
