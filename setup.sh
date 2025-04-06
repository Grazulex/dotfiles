#!/bin/bash
RED='\033[1;31m'
NC='\033[0m' # No Color
YELLOW='\033[1;33m'
GREEN='\033[1;32m'

# https://www.asciiart.eu/text-to-ascii-art

# This script sets up the environment for the project by installing necessary dependencies and setting up the virtual environment.
dotfiles_dir="$HOME/dotfiles/"

# Check if the dotfiles directory exists
[ ! -d "$dotfiles_dir" ] && { echo "Dotfiles directory does not exist. Please clone the repository first."; exit 1; }

# Check if the script is run as root
[ "$EUID" -eq 0 ] && { echo "Please do not run this script as root."; exit 1; }

# Check if the script is run in the correct directory
[ ! -f "$dotfiles_dir/setup.sh" ] && { echo "Please run this script from the dotfiles directory."; exit 1; }

echo ".--------------------------------------------------------------------.";
echo "| #     #                                                            |";
echo "| ##   ## #   #    #####   ####  ##### ###### # #      ######  ####  |";
echo "| # # # #  # #     #    # #    #   #   #      # #      #      #      |";
echo "| #  #  #   #      #    # #    #   #   #####  # #      #####   ####  |";
echo "| #     #   #      #    # #    #   #   #      # #      #           # |";
echo "| #     #   #      #    # #    #   #   #      # #      #      #    # |";
echo "| #     #   #      #####   ####    #   #      # ###### ######  ####  |";
echo "'--------------------------------------------------------------------'";

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

echo


echo "Please make sure you have a backup of your system before proceeding."
read -n 1 -s -r -p "Press any key to continue or Ctrl+C to cancel..." key
echo


echo -e "${YELLOW}.---------------------------------------------------------------------------------.${NC}";
echo -e "${YELLOW}| ######                                                                          |${NC}";
echo -e "${YELLOW}| #     # ###### #####  ###### #    # #####  ###### #    #  ####  # ######  ####  |${NC}";
echo -e "${YELLOW}| #     # #      #    # #      ##   # #    # #      ##   # #    # # #      #      |${NC}";
echo -e "${YELLOW}| #     # #####  #    # #####  # #  # #    # #####  # #  # #      # #####   ####  |${NC}";
echo -e "${YELLOW}| #     # #      #####  #      #  # # #    # #      #  # # #      # #           # |${NC}";
echo -e "${YELLOW}| #     # #      #      #      #   ## #    # #      #   ## #    # # #      #    # |${NC}";
echo -e "${YELLOW}| ######  ###### #      ###### #    # #####  ###### #    #  ####  # ######  ####  |${NC}";
echo -e "${YELLOW}'---------------------------------------------------------------------------------'${NC}";
echo
sudo apt update -y > /dev/null
sudo apt upgrade -y > /dev/null
sudo apt install -y git curl wget libnss3-tools jq xsel openssl ca-certificates gcc-multilib g++-multilib libc6-dev-i386 libffi-dev libssl-dev make ffmpeg 7zip jq poppler-utils imagemagick > /dev/null
sudo apt install -y fd-find ripgrep fzf ncdu zoxide > /dev/null

# config GIT
git config --global user.name "Jean-Marc Strauven"
git config --global user.email "jms@grazulex.be"
git config --global core.editor "nvim"
git config --global init.defaultBranch "main"

echo -e "${YELLOW}.------------------------------------------------.${NC}";
echo -e "${YELLOW}| ######  #     # ######      #####      #       |${NC}";
echo -e "${YELLOW}| #     # #     # #     #    #     #     #    #  |${NC}";
echo -e "${YELLOW}| #     # #     # #     #    #     #     #    #  |${NC}";
echo -e "${YELLOW}| ######  ####### ######      #####      #    #  |${NC}";
echo -e "${YELLOW}| #       #     # #          #     # ### ####### |${NC}";
echo -e "${YELLOW}| #       #     # #          #     # ###      #  |${NC}";
echo -e "${YELLOW}| #       #     # #           #####  ###      #  |${NC}";
echo -e "${YELLOW}'------------------------------------------------'${NC}";
echo
if ! command -v php &> /dev/null; then
    echo -e "${RED}PHP not found. Installing PHP 8.4${NC}"
    sudo add-apt-repository ppa:ondrej/php -y > /dev/null
    sudo apt update > /dev/null
    sudo apt upgrade -y > /dev/null
    sudo apt install -y php8.4 php8.4-{cli,fpm,mysql,xml,mbstring,curl,zip,gd,bcmath,soap,intl,readline,redis,imagick,sqlite3} > /dev/null
else
    echo -e "${GREEN}PHP is already installed.${NC}"
fi

echo -e "${YELLOW}.----------------------------------------------------------.${NC}";
echo -e "${YELLOW}|  #####                                                   |${NC}";
echo -e "${YELLOW}| #     #  ####  #    # #####   ####   ####  ###### #####  |${NC}";
echo -e "${YELLOW}| #       #    # ##  ## #    # #    # #      #      #    # |${NC}";
echo -e "${YELLOW}| #       #    # # ## # #    # #    #  ####  #####  #    # |${NC}";
echo -e "${YELLOW}| #       #    # #    # #####  #    #      # #      #####  |${NC}";
echo -e "${YELLOW}| #     # #    # #    # #      #    # #    # #      #   #  |${NC}";
echo -e "${YELLOW}|  #####   ####  #    # #       ####   ####  ###### #    # |${NC}";
echo -e "${YELLOW}'----------------------------------------------------------'${NC}";
echo
if ! command -v composer &> /dev/null; then
    echo -e "${RED}Composer not found. Installing Composer.${NC}"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  > /dev/null
    php composer-setup.php  > /dev/null
    php -r "unlink('composer-setup.php');"  > /dev/null
    sudo mv composer.phar /usr/local/bin/composer  > /dev/null

    # set composer global bin directory
    COMPOSER_BIN_DIR="$HOME/.config/composer/vendor/bin"
    if [ ! -d "$COMPOSER_BIN_DIR" ]; then
        mkdir -p "$COMPOSER_BIN_DIR"  > /dev/null
        echo "export PATH=\"\$PATH:$COMPOSER_BIN_DIR\"" >> ~/.bashrc
        source ~/.bashrc
    fi
else
    echo -e "${GREEN}Composer is already installed.${NC}"
fi

# Install NodeJs with snap
echo -e "${YELLOW}.------------------------.${NC}";
echo -e "${YELLOW}| #    #  ####  #    # |${NC}";
echo -e "${YELLOW}| ##   # #    # #    # |${NC}";
echo -e "${YELLOW}| # #  # #    # #    # |${NC}";
echo -e "${YELLOW}| #  # # #    # #    # |${NC}";
echo -e "${YELLOW}| #   ## #    # #    # |${NC}";
echo -e "${YELLOW}| #    #  ####  #    # |${NC}";
echo -e "${YELLOW}'------------------------'${NC}";
echo
if ! command -v node &> /dev/null; then
    echo -e "${RED}NodeJs not found. Installing NodeJs.${NC}"
    sudo snap install node --classic  > /dev/null
else
    echo -e "${GREEN}NodeJs is already installed.${NC}"
fi

echo -e "${YELLOW}.--------------------------------------------------.${NC}";
echo -e "${YELLOW}| #        ##   #####    ##   #    # ###### #      |${NC}";
echo -e "${YELLOW}| #       #  #  #    #  #  #  #    # #      #      |${NC}";
echo -e "${YELLOW}| #      #    # #    # #    # #    # #####  #      |${NC}";
echo -e "${YELLOW}| #      ###### #####  ###### #    # #      #      |${NC}";
echo -e "${YELLOW}| #      #    # #   #  #    #  #  #  #      #      |${NC}";
echo -e "${YELLOW}| ###### #    # #    # #    #   ##   ###### ###### |${NC}";
echo -e "${YELLOW}'--------------------------------------------------'${NC}";
echo
if ! command -v laravel &> /dev/null; then
    echo -e "${RED}Laravel Installer not found. Installing Laravel Installer.${NC}"
    composer global require laravel/installer > /dev/null 2>&1
else
    echo -e "${GREEN}Laravel Installer is already installed.${NC}"
fi

echo -e "${YELLOW}.---------------------------------------------.${NC}";
echo -e "${YELLOW}| #     #                                     |${NC}";
echo -e "${YELLOW}| #     #   ##   #      ###### #####      #   |${NC}";
echo -e "${YELLOW}| #     #  #  #  #      #        #        #   |${NC}";
echo -e "${YELLOW}| #     # #    # #      #####    #      ##### |${NC}";
echo -e "${YELLOW}|  #   #  ###### #      #        #        #   |${NC}";
echo -e "${YELLOW}|   # #   #    # #      #        #        #   |${NC}";
echo -e "${YELLOW}|    #    #    # ###### ######   #            |${NC}";
echo -e "${YELLOW}'---------------------------------------------'${NC}";
echo
if ! command -v valet &> /dev/null; then
    echo -e "${RED}Valet Linux Plus not found. Installing Valet Linux Plus.${NC}"
    composer global require genesisweb/valet-linux-plus  > /dev/null  2>&1
else
    echo -e "${GREEN}Valet Linux Plus is already installed.${NC}"
fi

# Install NeoVim
echo -e "${YELLOW}.------------------------.${NC}";
echo -e "${YELLOW}| #    # #    # # #    # |${NC}";
echo -e "${YELLOW}| ##   # #    # # ##  ## |${NC}";
echo -e "${YELLOW}| # #  # #    # # # ## # |${NC}";
echo -e "${YELLOW}| #  # # #    # # #    # |${NC}";
echo -e "${YELLOW}| #   ##  #  #  # #    # |${NC}";
echo -e "${YELLOW}| #    #   ##   # #    # |${NC}";
echo -e "${YELLOW}'------------------------'${NC}";
echo
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}NeoVim not found. Installing NeoVim.${NC}"
    sudo snap install nvim --classic > /dev/null
else
    echo -e "${GREEN}NeoVim is already installed.${NC}"
fi

# configure NeoVim symlink
if [ -d "$HOME/.config/nvim" ]; then
    #delete the old config
    rm -rf "$HOME/.config/nvim"
fi
ln -s "$dotfiles_dir/nvim" "$HOME/.config/nvim"

# Install LazyGit
echo -e "${YELLOW}.-------------------------------------------.${NC}";
echo -e "${YELLOW}| #        ##   ###### #   #  ####  # ##### |${NC}";
echo -e "${YELLOW}| #       #  #      #   # #  #    # #   #   |${NC}";
echo -e "${YELLOW}| #      #    #    #     #   #      #   #   |${NC}";
echo -e "${YELLOW}| #      ######   #      #   #  ### #   #   |${NC}";
echo -e "${YELLOW}| #      #    #  #       #   #    # #   #   |${NC}";
echo -e "${YELLOW}| ###### #    # ######   #    ####  #   #   |${NC}";
echo -e "${YELLOW}'-------------------------------------------'${NC}";
echo
if ! command -v lazygit &> /dev/null; then
    echo -e "${RED}LazyGit not found. Installing LazyGit.${NC}"
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')  > /dev/null
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"  > /dev/null  2>&1
    tar xf lazygit.tar.gz lazygit  > /dev/null
    sudo install lazygit -D -t /usr/local/bin/  > /dev/null
else
    echo -e "${GREEN}LazyGit is already installed.${NC}"
fi

# Install Yazi
echo -e "${YELLOW}.-----------------------.${NC}";
echo -e "${YELLOW}| #   #   ##   ###### # |${NC}";
echo -e "${YELLOW}|  # #   #  #      #  # |${NC}";
echo -e "${YELLOW}|   #   #    #    #   # |${NC}";
echo -e "${YELLOW}|   #   ######   #    # |${NC}";
echo -e "${YELLOW}|   #   #    #  #     # |${NC}";
echo -e "${YELLOW}|   #   #    # ###### # |${NC}";
echo -e "${YELLOW}'-----------------------'${NC}";
echo
if ! command -v yazi &> /dev/null; then
    echo -e "${RED}Yazi not found. Installing Yazi.${NC}"
    sudo snap install yazi --classic  > /dev/null
else
    echo -e "${GREEN}Yazi is already installed.${NC}"
fi

# Install Zsh
echo -e "${YELLOW}.----------------------.${NC}";
echo -e "${YELLOW}| ######  ####  #    # |${NC}";
echo -e "${YELLOW}|     #  #      #    # |${NC}";
echo -e "${YELLOW}|    #    ####  ###### |${NC}";
echo -e "${YELLOW}|   #         # #    # |${NC}";
echo -e "${YELLOW}|  #     #    # #    # |${NC}";
echo -e "${YELLOW}| ######  ####  #    # |${NC}";
echo -e "${YELLOW}'----------------------'${NC}";
if ! command -v zsh &> /dev/null; then
    echo -e "${RED}Zsh not found. Installing Zsh.${NC}"
    sudo apt install -y zsh  > /dev/null

    # Set Zsh as the default shell
    if [ "$SHELL" != "$(which zsh)" ]; then
        # add zsh into bashrc file
        echo "zsh" >> ~/.bashrc
        echo -e "${RED}Zsh has been set as the default shell. Please log out and log back in for the changes to take effect.${NC}"
    else
        echo -e "${GREEN}Zsh is already set as the default shell.${NC}"
    fi
else
    echo -e "${GREEN}Zsh is already installed.${NC}"
fi

# Install Oh My Zsh
echo -e "${YELLOW}.----------------------------------------------------------.${NC}";
echo -e "${YELLOW}| #######           #     #          #######               |${NC}";
echo -e "${YELLOW}| #     # #    #    ##   ## #   #         #   ####  #    # |${NC}";
echo -e "${YELLOW}| #     # #    #    # # # #  # #         #   #      #    # |${NC}";
echo -e "${YELLOW}| #     # ######    #  #  #   #         #     ####  ###### |${NC}";
echo -e "${YELLOW}| #     # #    #    #     #   #        #          # #    # |${NC}";
echo -e "${YELLOW}| #     # #    #    #     #   #       #      #    # #    # |${NC}";
echo -e "${YELLOW}| ####### #    #    #     #   #      #######  ####  #    # |${NC}";
echo -e "${YELLOW}'----------------------------------------------------------'${NC}";
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended  > /dev/null

# Install plugins for Zsh (zsh-autosuggestions, zsh-syntax-highlighting, you-should-use)
echo -e "${YELLOW}.----------------------------------------------------------------------.${NC}";
echo -e "${YELLOW}| #######                                                              |${NC}";
echo -e "${YELLOW}|      #   ####  #    #    #####  #      #    #  ####  # #    #  ####  |${NC}";
echo -e "${YELLOW}|     #   #      #    #    #    # #      #    # #    # # ##   # #      |${NC}";
echo -e "${YELLOW}|    #     ####  ######    #    # #      #    # #      # # #  #  ####  |${NC}";
echo -e "${YELLOW}|   #          # #    #    #####  #      #    # #  ### # #  # #      # |${NC}";
echo -e "${YELLOW}|  #      #    # #    #    #      #      #    # #    # # #   ## #    # |${NC}";
echo -e "${YELLOW}| #######  ####  #    #    #      ######  ####   ####  # #    #  ####  |${NC}";
echo -e "${YELLOW}'----------------------------------------------------------------------'${NC}";
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions  > /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting  > /dev/null
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use  > /dev/null

#configure Zsh symlink after Oh My Zsh
if [ -f "$HOME/.zshrc" ]; then
    #delete the old config
    rm -f "$HOME/.zshrc"  > /dev/null
fi
ln -s "$dotfiles_dir/zsh/.zshrc" "$HOME/.zshrc"

# Install Eza
echo -e "${YELLOW}.----------------------.${NC}";
echo -e "${YELLOW}| ###### ######   ##   |${NC}";
echo -e "${YELLOW}| #          #   #  #  |${NC}";
echo -e "${YELLOW}| #####     #   #    # |${NC}";
echo -e "${YELLOW}| #        #    ###### |${NC}";
echo -e "${YELLOW}| #       #     #    # |${NC}";
echo -e "${YELLOW}| ###### ###### #    # |${NC}";
echo -e "${YELLOW}'----------------------'${NC}";
if ! command -v eza &> /dev/null; then
    echo -e "${RED}Eza not found. Installing Eza.${NC}"
    wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz  > /dev/null
    sudo chmod +x eza > /dev/null
    sudo chown root:root eza  > /dev/null
    sudo mv eza /usr/local/bin/eza  > /dev/null
else
    echo -e "${GREEN}Eza is already installed.${NC}"
fi

# Install Ghostty
echo -e "${YELLOW}.------------------------------------------------.${NC}";
echo -e "${YELLOW}|  #####                                         |${NC}";
echo -e "${YELLOW}| #     # #    #  ####   ####  ##### ##### #   # |${NC}";
echo -e "${YELLOW}| #       #    # #    # #        #     #    # #  |${NC}";
echo -e "${YELLOW}| #  #### ###### #    #  ####    #     #     #   |${NC}";
echo -e "${YELLOW}| #     # #    # #    #      #   #     #     #   |${NC}";
echo -e "${YELLOW}| #     # #    # #    # #    #   #     #     #   |${NC}";
echo -e "${YELLOW}|  #####  #    #  ####   ####    #     #     #   |${NC}";
echo -e "${YELLOW}'------------------------------------------------'${NC}";
if ! command -v ghostty &> /dev/null; then
    echo -e "${RED}Ghostty not found. Installing Ghostty.${NC}"
    snap install ghostty --classic  > /dev/null
else
    echo -e "${GREEN}Ghostty is already installed.${NC}"
fi

# Configure Ghostty symlink
if [ -d "$HOME/.config/ghostty" ]; then
    #delete the old config
    rm -rf "$HOME/.config/ghostty"  > /dev/null
fi
ln -s "$dotfiles_dir/ghostty" "$HOME/.config/ghostty"

echo -e "${GREEN}.----------------------.${NC}";
echo -e "${GREEN}| ###### #    # #####  |${NC}";
echo -e "${GREEN}| #      ##   # #    # |${NC}";
echo -e "${GREEN}| #####  # #  # #    # |${NC}";
echo -e "${GREEN}| #      #  # # #    # |${NC}";
echo -e "${GREEN}| #      #   ## #    # |${NC}";
echo -e "${GREEN}| ###### #    # #####  |${NC}";
echo -e "${GREEN}'----------------------'${NC}";
