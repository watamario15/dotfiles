# Dot Files
My dot files for Ubuntu, [Termux](https://termux.com/), and [Brainux](https://brainux.org/).  Key features follow.

# Bash
Aliases for Python, Git, apt, and various features including:
- Edit/Apply the `~/.bashrc` by `editrc`/`applyrc`
- Copy the current directory to the clipboard by `pwdc`
- Copy from the stdin to the clipboard by `copy`
- Search the command history by `hist`

# Nano
- 4 speces for an indent
- Display tab as 4 spaces
- Use provided "natural" keybindings
- Enable all syntax definitions

# Vim
- Syntax highlighting
- Using UTF-8 encoding
- 4 speces for an indent
- Display tab as 4 spaces
- Vim-airline
- Automatically add closing tags for HTML/XML

# Installation
## Ubuntu
You can install by executing the following commands:

```sh
cd
git clone https://github.com/watamario15/dotfiles.git
cd dotfiles
./install.sh
```

Executing `./initialze.sh` sets up the Git and installs some essential packages.  You can also install:
- The CASLII/COMETII simulator (Osaka University) by `./initialize.sh caslcomet`,
- Packages for SHARP Brain developments by `./initialize.sh brain`,
- MediaWiki to XTBook convertion environment by `./initialize.sh xtbook`.

## Termux and Brainux
Most of the installation process and features are the same; just use files in the respective directory.  I replaced/removed unsupported features and added some terget-specific setup files.

However, note that `initialize.sh` for the Brainux should be run on a PC that has already mounted the Brainux partition and you must do some steps written in the script manually before/after running.

The target specific files include:
- `swap.sh` (Brainux) sets up a swap with a given size (MB). The default is 1024 MB.
- `usbg.sh` (Brainux) sets up the USB Gadget.
- `buildkernel.sh` and `buildnkbin.sh` are for building Brainux.
