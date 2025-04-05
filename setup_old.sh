#!/bin/bash

# This script sets up the environment for the project by installing necessary dependencies and setting up the virtual environment.
dotfiles_dir="$HOME/dotfiles/"

# Check if the dotfiles directory exists
[ ! -d "$dotfiles_dir" ] && { echo "Dotfiles directory does not exist. Please clone the repository first."; exit 1; }

# Check if the script is run as root
[ "$EUID" -eq 0 ] && { echo "Please do not run this script as root."; exit 1; }

# Check if the script is run in the correct directory
[ ! -f "$dotfiles_dir/setup.sh" ] && { echo "Please run this script from the dotfiles directory."; exit 1; }

# Install dependencies
sudo apt update
sudo apt install -y git curl wget zsh neovim

# Install PHP8.4
if ! command -v php &> /dev/null; then
    echo "PHP not found. Installing PHP 8.4..."
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt update
    sudo apt install -y php8.4 php8.4-{cli,fpm,mysql,xml,mbstring,curl,zip,gd,bcmath,soap,intl,readline,redis,imagick}
else
    echo "PHP is already installed."
fi

# Install Composer
#if ! command -v composer &> /dev/null; then
    echo "Composer not found. Installing Composer..."
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    php -r "unlink('composer-setup.php');"

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
#else
    echo "Composer is already installed."
#fi

# Install Laravel Installer
[ ! command -v laravel &> /dev/null ] && { echo "Laravel Installer not found. Installing Laravel Installer..."; composer global require laravel/installer; } || echo "Laravel Installer is already installed."

# Install Valet Linux Plus
[ ! command -v valet &> /dev/null ] && { echo "Valet Linux Plus not found. Installing Valet Linux Plus..."; composer global require genesisweb/valet-linux-plus; } || echo "Valet Linux Plus is already installed."

# Install LazyVim
if [ ! -f "$HOME/.config/nvim/lazyvim.json" ]; then
    echo "LazyVim not found. Installing LazyVim..."
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    for dir in $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.local/state/nvim $HOME/.cache/nvim; do
        [ -d "$dir" ] && { mkdir -p "${dir}.bak/$TIMESTAMP"; mv "$dir"/* "${dir}.bak/$TIMESTAMP"/; }
    done
    rm -rf $HOME/.config/nvim $HOME/.local/share/nvim $HOME/.local/state/nvim $HOME/.cache/nvim
    git clone https://github.com/LazyVim/starter $HOME/.config/nvim
    rm -rf $HOME/.config/nvim/.git
    touch $HOME/.config/nvim/lazyvim.json
else
    echo "LazyVim is already installed."
fi

# Install LazyGit
if ! command -v lazygit &> /dev/null; then
    echo "LazyGit not found. Installing LazyGit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/
else
    echo "LazyGit is already installed."
fi

# Install Yazi
[ ! command -v yazi &> /dev/null ] && { echo "Yazi not found. Installing Yazi..."; sudo snap install yazi --classic; } || echo "Yazi is already installed."

# Install Zsh
[ ! command -v zsh &> /dev/null ] && { echo "Zsh not found. Installing Zsh..."; sudo apt install -y zsh; } || echo "Zsh is already installed."

# Install Oh My Zsh
[ ! -d "$HOME/.oh-my-zsh" ] && { echo "Oh My Zsh not found. Installing Oh My Zsh..."; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; } || echo "Oh My Zsh is already installed."

# Install Ghostty
[ ! command -v ghostty &> /dev/null ] && { echo "Ghostty not found. Installing Ghostty..."; sudo apt install -y ghostty; } || echo "Ghostty is already installed."
