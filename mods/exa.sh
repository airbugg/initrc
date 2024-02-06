#!/usr/bin/env bash

NAME="exa"

read -r -d '' ALIAS <<EOT

# ls -> exa
alias ls='exa --long --header --group --icons'
alias ll='exa --all --long --header --group --icons'

EOT

install_ubuntu() {
    echo "Installing $NAME on Ubuntu..."
    sudo apt-get install $NAME -y
}

uninstall_ubuntu() {
    echo "Uninstalling $NAME on Ubuntu..."
    sudo apt-get remove $NAME -y
}

install_macos() {
    echo "Uninstalling $NAME on MacOS..."
    brew install $NAME
}

uninstall_macos() {
    echo "Uninstalling $NAME on MacOS..."
    brew uninstall $NAME
}

post_install() {
    if ! grep -q "$ALIAS" ~/.config/fish/config.fish; then
        echo >>~/.config/fish/config.fish
        echo "$ALIAS" >>~/.config/fish/config.fish
        echo >>~/.config/fish/config.fish
    fi
}

post_uninstall() {
    # remove alias $NAME to ls and ll in fish, if not already done
    if grep -q "$ALIAS" ~/.config/fish/config.fish; then
        awk -v RS="$ALIAS" -v ORS="" '1' ~/.config/fish/config.fish >tmp && mv tmp ~/.config/fish/config.fish
    fi
}

if [[ $1 == "-u" || $1 == "--uninstall" ]]; then
    echo "Uninstalling $NAME..."
    # Detect the Operating System
    OS="$(uname -s)"
    case "$OS" in
    Linux*)
        uninstall_ubuntu
        ;;
    Darwin*)
        uninstall_macos
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
    esac

    post_uninstall
    exit 0
fi

# Check if $NAME is installed
if ! command -v $NAME &>/dev/null; then
    echo "$NAME is not installed. Installing..."

    # Detect the Operating System
    OS="$(uname -s)"
    case "$OS" in
    Linux*)
        install_ubuntu
        ;;
    Darwin*)
        install_macos
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
    esac

    post_install
else
    echo "$NAME is already installed."
fi
