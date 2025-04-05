#!/bin/bash

# This script sets up the environment for the project by installing necessary dependencies and setting up the virtual environment.
dotfiles_dir="$HOME/dotfiles/"

# Check if the dotfiles directory exists
[ ! -d "$dotfiles_dir" ] && { echo "Dotfiles directory does not exist. Please clone the repository first."; exit 1; }

# Check if the script is run as root
[ "$EUID" -eq 0 ] && { echo "Please do not run this script as root."; exit 1; }

# Check if the script is run in the correct directory
[ ! -f "$dotfiles_dir/setup.sh" ] && { echo "Please run this script from the dotfiles directory."; exit 1; }

#show text with description and button to continue
echo "This script will install the necessary dependencies for the project:"
echo "1. PHP 8.4"
echo "2. Composer"
echo "3. Laravel Installer"
echo "4. Valet Linux Plus"
echo "5. LazyVim"
echo "6. LazyGit"
echo "7. Yazi"
echo "8. Zsh"
echo "9. Oh My Zsh"
echo "10. Ghostty"

echo "Please make sure you have a backup of your system before proceeding."
read -n 1 -s -r -p "Press any key to continue or Ctrl+C to cancel..." key
echo

echo "Installing dependencies (git, curl, wget, zsh, neovim)"
# Install dependencies
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y git curl wget zsh neovim


# Install PHP8.4
echo "Installing PHP 8.4"

# Install Composer
echo "Installing Composer"

# Install Laravel Installer
echo "Installing Laravel Installer"

# Install Valet Linux Plus
echo "Installing Valet Linux Plus"

# Install LazyVim
echo "Installing LazyVim"

# Install LazyGit
echo "Installing LazyGit"

# Install Yazi
echo "Installing Yazi"

# Install Zsh
echo "Installing Zsh"

# Install Oh My Zsh
echo "Installing Oh My Zsh"

# Install Ghostty
echo "Installing Ghostty"

