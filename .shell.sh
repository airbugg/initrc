#!/bin/sh

# install brew
#
if ! which brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# .macos
#
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! [[ -f ~/.macos ]]; then
        curl -LO https://raw.githubusercontent.com/airbugg/initrc/master/.macos
        mv .macos ~/.macos
        sh ~/.macos
    fi
fi

# install fish
#
if which brew > /dev/null; then
    brew install fish
elif which apt > /dev/null; then
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt-get update
    sudo apt-get install fish
else
    echo "Could not install fish, mate."
fi

# install fisher
# 
if ! which fisher > /dev/null; then
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    fisher add jethrokuan/fzf
fi

touch ~/.config/fish/config.fish

# install fzf
#
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


# install exa
#
if ! which exa > /dev/null; then
    if which brew > /dev/null; then
        brew install exa
    else
        curl -LO https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
        unzip exa-linux-x86_64-0.9.0.zip
        mv exa-linux-x86_64 /usr/local/bin/exa
        rm exa-linux-x86_64-0.9.0.zip
    fi
    echo abbr -a ls exa | tee -a ~/.config/fish/config.fish
    echo abbr -a ll exa -la | tee -a ~/.config/fish/config.fish
    echo abbr -a la exa -la | tee -a ~/.config/fish/config.fish
fi

# install bat
#
if ! which bat > /dev/null; then
    if which brew > /dev/null; then
        brew install bat
    elif which apt > /dev/null; then
        sudo apt install bat
    fi
    echo abbr -a cat bat | tee -a ~/.config/fish/config.fish
fi


# install hugo
#
if which hugo > /dev/null; then
    if which brew > /dev/null; then
        brew install hugo
    fi
fi
