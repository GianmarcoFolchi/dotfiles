#!/bin/bash  
  
set -e  # Exit immediately if a command exits with a non-zero status  
  
install_if_missing() {  
  command_name="$1"  
  package_name="${2:-$1}"  
  
  if ! command -v "$command_name" &> /dev/null; then  
    echo "$command_name not found, attempting to install $package_name..."  
  
    if command -v apt &> /dev/null; then  
      apt update && apt install -y "$package_name"  
    elif command -v yum &> /dev/null; then  
      yum install -y "$package_name"  
    elif command -v brew &> /dev/null; then  
      brew install "$package_name"  
    else  
      echo "Could not determine package manager for installing $package_name. Please install it manually."  
      exit 1  
    fi  
  else  
    echo "$command_name is already installed."  
  fi  
}  
  
# Check if running as root  
if [[ "$EUID" -ne 0 ]]; then  
  echo "Please run as root or with sudo privileges."  
  exit 1  
fi  
  
cd ~
  
# Install necessary tools  
install_if_missing "curl"  
install_if_missing "git"  
install_if_missing "zsh"  
  
# Install Oh My Zsh if not already installed; avoid any potential prompts  
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then    
  echo "Installing Oh My Zsh..."  
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" </dev/null  
fi   
  
# Clone zsh-syntax-highlighting  
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then  
  echo "Installing zsh-syntax-highlighting..."  
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"  
fi  
  
# Clone zsh-autosuggestions  
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then  
  echo "Installing zsh-autosuggestions..."  
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"  
fi  
  
# Get directory name and GitHub URL  
read -p "How would you like to name your directory containing a bare git repo? " directoryName  
echo "$directoryName" >> .gitignore  
  
# read -p "Please provide the GitHub URL containing your dotfiles: " gitURL  

gitURL="https://github.com/GianmarcoFolchi/dotfiles"

# Clone the bare repository  
git clone --bare "$gitURL" "$HOME/$directoryName" || {  
  echo "Git clone failed"  
  exit 1  
}  
  
# Get the path to Git binary  
git_bin=$(which git)  
  
# Always configure for zsh  
echo "alias config='$git_bin --git-dir=$HOME/$directoryName/ --work-tree=$HOME'" >> ~/.zshrc  
  
# Add the plugins to the oh-my-zsh list  
sed -i '/^plugins=(/ s/)/ zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc  
  
# Configure git settings  
"$git_bin" --git-dir="$HOME/$directoryName" --work-tree="$HOME" config --local status.showUntrackedFiles no  
  
echo "Basic setup complete!"  
echo "Now switch your default shell to zsh, please run: 'chsh -s $(which zsh); zsh'"  
echo "Then run 'config stash; config checkout; source ~/.zshrc'"  
