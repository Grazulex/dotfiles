#!/bin/bash

#Yazi
if [ -f "$HOME/.config/yazi/theme.toml" ]; then
  rm "$HOME/.config/yazi/theme.toml"
fi
ln -s "$(pwd)/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"

if [ -f "$HOME/.config/yazi/yazi.toml" ]; then
  rm "$HOME/.config/yazi/yazi.toml"
fi
ln -s "$(pwd)/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"

if [ -d "$HOME/.config/yazi/flavors" ]; then
  rm -rf "$HOME/.config/yazi/flavors"
fi
ln -s "$(pwd)/yazi/flavors" "$HOME/.config/yazi/flavors"

#zellij layouts
if [ -d "$HOME/.config/zellij/layouts" ]; then
  rm -rf "$HOME/.config/zellij/layouts"
fi
ln -s "$(pwd)/zellij/layouts" "$HOME/.config/zellij/layouts"
