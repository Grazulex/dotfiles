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

echo "Installing dependencies (git, curl, wget, libnss3-tools, jqn, xsel, openssl, ca-certificates, gcc, libstdc++6.0-dev, libffi-dev, libssl-dev)"
# Install dependencies
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y git curl wget libnss3-tools jq xsel openssl ca-certificates gcc

# config GIT
git config --global user.name "Jean-Marc Strauven"
git config --global user.email "jms@grazulex.be"
git config --global core.editor "nvim"
git config --global init.defaultBranch "main"

# Install PHP8.4
echo "Installing PHP 8.4"
if ! command -v php &> /dev/null; then
    echo "PHP not found. Installing PHP 8.4..."
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt update
    sudo apt install -y php8.4 php8.4-{cli,fpm,mysql,xml,mbstring,curl,zip,gd,bcmath,soap,intl,readline,redis,imagick}
else
    echo "PHP is already installed."
fi

# Install Composer
echo "Installing Composer"
if ! command -v composer &> /dev/null; then
    echo "Composer not found. Installing Composer..."
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    sudo mv composer.phar /usr/local/bin/composer

    # set composer global bin directory
    COMPOSER_BIN_DIR="$HOME/.config/composer/vendor/bin"
    if [ ! -d "$COMPOSER_BIN_DIR" ]; then
        mkdir -p "$COMPOSER_BIN_DIR"
        echo "export PATH=\"\$PATH:$COMPOSER_BIN_DIR\"" >> ~/.bashrc
        source ~/.bashrc
    fi

    # Check if Composer is installed
    if command -v composer &> /dev/null; then
        echo "Composer installed successfully."
    else
        echo "Composer installation failed."
        exit 1
    fi
else
    echo "Composer is already installed."
fi

# Install Laravel Installer
echo "Installing Laravel Installer"
if ! command -v laravel &> /dev/null; then
    echo "Laravel Installer not found. Installing Laravel Installer..."
    composer global require laravel/installer
else
    echo "Laravel Installer is already installed."
fi

# Install Valet Linux Plus
echo "Installing Valet Linux Plus"
if ! command -v valet &> /dev/null; then
    echo "Valet Linux Plus not found. Installing Valet Linux Plus..."
    composer global require genesisweb/valet-linux-plus
else
    echo "Valet Linux Plus is already installed."
fi

# Install NeoVim
echo "Installing NeoVim"
if ! command -v nvim &> /dev/null; then
    echo "NeoVim not found. Installing NeoVim..."
    sudo apt install -y neovim
else
    echo "NeoVim is already installed."
fi

# Install LazyVim
#echo "Installing LazyVim"
#if [ ! -f "$HOME/.config/nvim/lazyvim.json" ]; then
#    echo "LazyVim not found. Installing LazyVim..."
#    git clone https://github.com/LazyVim/starter ~/.config/nvim
#    rm -rf ~/.config/nvim/.git
#    nvim +Lazy +qall
#else
#    echo "LazyVim is already installed."
#fi

# Install LazyGit
echo "Installing LazyGit"
if ! command -v lazygit &> /dev/null; then
    echo "LazyGit not found. Installing LazyGit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
else
    echo "LazyGit is already installed."
fi

# Install Yazi
echo "Installing Yazi"

# Install Zsh
echo "Installing Zsh"
if ! command -v zsh &> /dev/null; then
    echo "Zsh not found. Installing Zsh..."
    sudo apt install -y zsh

    # Set Zsh as the default shell
    if [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s "$(which zsh)"
        echo "Zsh has been set as the default shell. Please log out and log back in for the changes to take effect."
    else
        echo "Zsh is already set as the default shell."
    fi
else
    echo "Zsh is already installed."
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Ghostty
echo "Installing Ghostty"

