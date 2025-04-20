#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'

#Yazi
echo -e "${YELLOW}Installing Yazi config...${NC}"

#check if yazi exists in $HOME/.config/. if not create it
if [ ! -d "$HOME/.config/yazi" ]; then
  echo -e "${GREEN}Creating directory $HOME/.config/yazi...${NC}"
  mkdir -p "$HOME/.config/yazi"
else
  echo -e "${RED}Directory $HOME/.config/yazi already exists...${NC}"
fi

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

#update nvim lua config file
echo -e "${YELLOW}Updating nvim lua config file...${NC}"

if [ -f "$HOME/.config/nvim/lazyvim.json" ]; then
  echo -e "${RED}Removing existing lazyvim.json...${NC}"
  rm "$HOME/.config/nvim/lazyvim.json"
fi

ln -s "$(pwd)/nvim/lazyvim.json" "$HOME/.config/nvim/lazyvim.json"

if [ -f "$HOME/.config/nvim/stylua.toml" ]; then
  echo -e "${RED}Removing existing stylua.toml...${NC}"
  rm "$HOME/.config/nvim/stylua.toml"
fi

ln -s "$(pwd)/nvim/stylua.toml" "$HOME/.config/nvim/stylua.toml"

if [ -f "$HOME/.config/nvim/lua/config/autocmds.lua" ]; then
  echo -e "${RED}Removing existing autocmds.lua...${NC}"
  rm "$HOME/.config/nvim/lua/config/autocmds.lua"
fi

ln -s "$(pwd)/nvim/lua/config/autocmds.lua" "$HOME/.config/nvim/lua/config/autocmds.lua"

if [ -f "$HOME/.config/nvim/lua/config/keymaps.lua" ]; then
  echo -e "${RED}Removing existing keymaps.lua...${NC}"
  rm "$HOME/.config/nvim/lua/config/keymaps.lua"
fi

ln -s "$(pwd)/nvim/lua/config/keymaps.lua" "$HOME/.config/nvim/lua/config/keymaps.lua"

if [ -f "$HOME/.config/nvim/lua/config/lazy.lua" ]; then
  echo -e "${RED}Removing existing lazy.lua...${NC}"
  rm "$HOME/.config/nvim/lua/config/lazy.lua"
fi

ln -s "$(pwd)/nvim/lua/config/lazy.lua" "$HOME/.config/nvim/lua/config/lazy.lua"

if [ -f "$HOME/.config/nvim/lua/config/options.lua" ]; then
  echo -e "${RED}Removing existing options.lua...${NC}"
  rm "$HOME/.config/nvim/lua/config/options.lua"
fi

ln -s "$(pwd)/nvim/lua/config/options.lua" "$HOME/.config/nvim/lua/config/options.lua"

#install nvim plugins files in ~/.config/nvim/lua/plugins

#remove all files in plugins directory
for file in "$HOME/.config/nvim/lua/plugins/"*; do
  if [ -f "$file" ]; then
    echo -e "${RED}Removing existing $file...${NC}"
    rm "$file"
  fi
done

ln -s "$(pwd)/nvim/lua/plugins/"* "$HOME/.config/nvim/lua/plugins/"

echo -e "${GREEN}Config installed successfully!${NC}"
