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

#check if kitty is installed if not install it
if ! command -v kitty &>/dev/null; then
  echo -e "${BLUE}Kitty not found. Installing kitty...${NC}"
  if [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
    sudo apt install kitty -y
  elif [[ "$ID" == "arch" || "$ID" == "manjaro" ]]; then
    sudo pacman -S kitty --noconfirm
  fi
fi

#install warp terminal
if ! command -v warp-terminal &>/dev/null; then
  echo -e "${BLUE}Warp terminal not found. Installing warp...${NC}"
  if [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
    warp_url="https://app.warp.dev/download?package=deb"
    curl -L -o warp.deb "$warp_url"
    chmod +x warp.deb
    sudo dpkg -i warp.deb
  elif [[ "$ID" == "arch" || "$ID" == "manjaro" ]]; then
    #sudo pacman -S warp --noconfirm
  fi
fi

#stow dotfiles
stow yazi zellij nvim alacritty kitty bashrc wrap

echo -e "${GREEN}Config installed successfully!${NC}"
