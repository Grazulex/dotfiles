#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'

#Yazi
echo -e "${YELLOW}Installing Yazi config...${NC}"

if [ -f "$HOME/.config/yazi/theme.toml" ]; then
  echo -e "${RED}Removing existing theme.toml...${NC}"
  rm "$HOME/.config/yazi/theme.toml"
fi
echo -e "${GREEN}Creating symlink for theme.toml...${NC}"
ln -s "$(pwd)/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"

if [ -f "$HOME/.config/yazi/yazi.toml" ]; then
  echo -e "${RED}Removing existing yazi.toml...${NC}"
  rm "$HOME/.config/yazi/yazi.toml"
fi
echo -e "${GREEN}Creating symlink for yazi.toml...${NC}"
ln -s "$(pwd)/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"

if [ -d "$HOME/.config/yazi/flavors" ]; then
  echo -e "${RED}Removing existing flavors...${NC}"
  rm -rf "$HOME/.config/yazi/flavors"
fi
echo -e "${GREEN}Creating symlink for flavors...${NC}"
ln -s "$(pwd)/yazi/flavors" "$HOME/.config/yazi/flavors"

echo ""

#zellij layouts
echo -e "${YELLOW}Installing Zellij layouts...${NC}"

if [ -d "$HOME/.config/zellij/layouts" ]; then
  echo -e "${RED}Removing existing layouts...${NC}"
  rm -rf "$HOME/.config/zellij/layouts"
fi
echo -e "${GREEN}Creating symlink for layouts...${NC}"
ln -s "$(pwd)/zellij/layouts" "$HOME/.config/zellij/layouts"

echo ""

#update .bashrc with aliases
echo -e "${YELLOW}Updating .bashrc with aliases...${NC}"

if grep -q "alias zla=" "$HOME/.bashrc"; then
  echo -e "${RED}Removing existing alias zla...${NC}"
  sed -i '/alias zla=/d' "$HOME/.bashrc"
fi

echo -e "${GREEN}Adding alias zla to .bashrc...${NC}"
sed -i '$a alias zla="zellij --layout laravel"' "$HOME/.bashrc"

#alias y="yazi"

if grep -q "alias y=" "$HOME/.bashrc"; then
  echo -e "${RED}Removing existing alias y...${NC}"
  sed -i '/alias y=/d' "$HOME/.bashrc"
fi

echo -e "${GREEN}Adding alias y to .bashrc...${NC}"
sed -i '$a alias y="yazi"' "$HOME/.bashrc"

echo ""

echo -e "${GREEN}Config installed successfully!${NC}"
