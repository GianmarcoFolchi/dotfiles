### Dotfile Management
For tmux, remember that you need to source the `.tmux.conf` file and also run `Prefix-A` + `I` to install plugins
I am using a git bare repo to manage my dotfiles. [This](https://www.atlassian.com/git/tutorials/dotfiles) is how I set it up. I included a script to set up dotifles in a new machine

##### Installation

###### Using curl

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/GianmarcoFolchi/dotfiles/refs/heads/master/setupDotfiles.sh)"`
###### Using wget

`sh -c "$(wget -qO- https://raw.githubusercontent.com/GianmarcoFolchi/dotfiles/refs/heads/master/setupDotfiles.sh)"  `