#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'

echo -e "${YELLOW}Installing dotfiles...${NC}"

#install stow
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  if [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
    echo -e "${BLUE}Detected Ubuntu/Debian. Installing stow...${NC}"
    sudo apt update -y
    sudo apt install stow -y
  elif [[ "$ID" == "arch" || "$ID" == "manjaro" ]]; then
    echo -e "${BLUE}Detected Arch/Manjaro. Installing stow...${NC}"
    sudo pacman -Syu
    sudo pacman -S stow --noconfirm
  fi
fi

#stow dotfiles
stow yazi zellij nvim alacritty bashrc

echo -e "${GREEN}Config installed successfully!${NC}"
