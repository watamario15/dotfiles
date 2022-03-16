# Dot Files
My dot files for [Ubuntu](https://ubuntu.com/), [Termux](https://termux.com/), and [Brainux](https://brainux.org/). Key features follow.

## Bash
Aliases for Python, Git, apt, and various features including:
- Edit and apply your `~/.bashrc` by `editrc` and `applyrc`
- Copy the current directory to the clipboard by `pwdc`
- Copy from the stdin to the clipboard by `copy`
- Search your command history by `hist`

## Nano
- 4 speces for an indent
- Display tab as 4 spaces
- Use provided "natural" keybindings
- Enable all syntax definitions

## Vim
- Syntax highlighting
- Use UTF-8 encoding
- 4 speces for an indent
- Display tab as 4 spaces
- Vim-airline
- Automatically add closing tags for HTML/XML

## Tools
- `tools/CeGCC` helps you building a Windows CE (ARMv5TEJ) application
- `tools/XTBook` makes converting a MediaWiki site into a XTBook dictionary easier for you

## Installation
### Ubuntu
You can install by invoking the following commands:
```sh
cd
git clone https://github.com/watamario15/dotfiles.git
cd dotfiles
./install.sh
```

Executing `./initialze.sh` sets up the Git and installs some essential packages. You can also set up:
- The CASLII/COMETII simulator (Osaka University) by `./initialize.sh caslcomet`,
- Packages for SHARP Brain developments by `./initialize.sh brain`,
- MediaWiki to XTBook convertion environment by `./initialize.sh xtbook`.

### Termux and Brainux
Most of the installation process and features are the same; just use files in the respective directory. I replaced/removed unsupported features and added some terget-specific setup files. However, note that **you must run `initialize.sh` for the Brainux on a PC that has already mounted the Brainux partition and you must do some steps written in the script manually before running it**.

The target specific files include:
- `swap` (Brainux) sets up a swap with a given size (MB). The default is 1024 MB.
- `usbg` (Brainux) sets up the USB Gadget.
