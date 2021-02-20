# Dot Files
My dot files for Bash on Ubuntu.  Key features follow.

# Bash
Aliases for Python, Git, apt, and various features.
- Edit/Apply the `~/.bashrc` by `editrc`/`applyrc`
- Copy the current directory to the clipboard by `pwdc`
- Copy from the stdin to the clipboard by `copy`
- Search the command history by `hist`

# Nano
4 speces for an indent, display tab as 4 spaces, use provided "usual" keybindings, and enable all syntax definitions.

# Vim
Syntax, UTF-8, 4 speces for an indent, display tab as 4 spaces, vim-airline, and automatically add closing tags for HTML/XML.

# Installation
You can install by executing the following commands.

```sh
cd ~
git clone https://github.com/watamario15/dotfiles.git
cd dotfiles
./install.sh
```

Executing `./initialze.sh` sets up the Git and installs some essential packages.  Also, you can install the CASLII/COMETII simulator (Osaka University) by `./initialize.sh caslcomet` and packages for SHARP Brain developments by `./initialize.sh brain`.
