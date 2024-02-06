#!/usr/bin/env bash

NAME="fzf"

install() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
}

uninstall() {
    ~/.fzf/uninstall
    rm -rf ~/.fzf
}

if [[ $1 == "-u" || $1 == "--uninstall" ]]; then
    echo "Uninstalling $NAME..."
    # Detect the Operating System
    OS="$(uname -s)"
    case "$OS" in
    Linux*)
        uninstall
        ;;
    Darwin*)
        uninstall
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
    esac

    exit 0
fi

if ! command -v $NAME &>/dev/null; then
    echo "$NAME is not installed. Installing..."

    OS="$(uname -s)"
    case "$OS" in
    Linux*)
        install
        ;;
    Darwin*)
        install
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
    esac

else
    echo "$NAME is already installed."
fi
