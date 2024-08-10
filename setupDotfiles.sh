#!/bin/bash

# Check if running from home directory
read -p "Are you running this from your home directory? (y/n): " response

if [[ "$response" != "y" && "$response" != "Y" ]]; then
  echo "Please run this from the home directory. Thanks"
  exit 1
fi

# Get directory name and GitHub URL
read -p "How would you like to name your directory containing a bare git repo? " directoryName
echo "$directoryName" >>.gitignore

read -p "Please provide the GitHub URL containing your dotfiles: " gitURL

# Clone the bare repository
git clone --bare "$gitURL" "$HOME/$directoryName" || {
  echo "Git clone failed"
  exit 1
}

# Get the path to Git binary
git_bin=$(which git)

# Update shell configuration based on the current shell
current_shell=$(basename "$SHELL")

if [[ "$current_shell" == "zsh" ]]; then
  echo "alias config='$git_bin --git-dir=$HOME/$directoryName/ --work-tree=$HOME'" >>~/.zshrc
elif [[ "$current_shell" == "bash" ]]; then
  echo "alias config='$git_bin --git-dir=$HOME/$directoryName/ --work-tree=$HOME'" >>~/.bashrc
else
  echo "You are running $current_shell and this script does not support it :("
  exit 1
fi

# Configure git settings
config config --local status.showUntrackedFiles no

echo "Basic setup complete!"
echo "Now backup all dotfiles you have on this computer by either changing their names or moving them somewhere else."
echo "Then source your respective shell rc (.zshrc or .bashrc) and run 'config checkout'\n"
