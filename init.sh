#!/usr/bin/env bash

for file in mods/*.sh; do
  if [ -f "$file" ]; then
    # if no "--all" flag is passed, ask user before installing every mod
    if [[ $1 != "--all" ]]; then
      read -p "Do you want to install $file? [y/N] " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        continue
      fi
    fi
    
    if [[ $1 == "-u" || $1 == "--uninstall" ]]; then
      bash "$file" --uninstall
    else
      bash "$file"
    fi
  fi
done
