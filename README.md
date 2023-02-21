# Dot files
My dotfiles for [Ubuntu](https://ubuntu.com/), [Termux](https://termux.com/), and [Brainux](https://brainux.org/).

## Key features
### Bash
Aliases for Python, Git, APT, GCC, and various features including:
- `editrc` and `applyrc` to edit and apply your `~/.bashrc`
- `pwdc` to copy the current directory path to the clipboard
- `copy` to copy stdin to the clipboard
- `hist` to search your command history

### Nano
- 2 spaces for one indent
- Show a tab as 2 spaces
- Use the supplied "natural" key bindings
- Enable all syntax definitions

### Vim
- Syntax highlighting
- Use UTF-8 encoding
- 2 spaces for one indent
- Show a tab as 2 spaces
- Vim-airline
- Automatically add a closing tag for HTML/XML

### Tools
- `tools/cegcc` and `tools/ceg++` to build a Windows CE (Armv5TEJ) app
- `tools/xtbconv` to convert a MediaWiki into an XTBook dictionary

## Installation
### Ubuntu
You can install by running the following commands:
```sh
cd
git clone https://github.com/watamario15/dotfiles.git
cd dotfiles
./install.sh
```

Running `./initialize.sh` will set up git and install some basic packages. You can also set up:
- CASLII/COMETII simulator (Osaka University) with `./initialize.sh caslcomet`
- SHARP Brain development packages with `./initialize.sh brain`
- MediaWiki to XTBook conversion environment with `./initialize.sh xtbook`

### Termux and Brainux
Most installation processes and features are the same, just use the files in the appropriate directory. I have replaced/removed unsupported features and added some terget-specific setup files. Note that **you will need to run Brainux `initialize.sh' on a PC that already has the Brainux partition mounted, and you will need to manually perform some steps described in the script before running it**.

The target-specific files include:
- `swap` (Brainux) sets up a swap with a given size (MB), the default is 1024 MB
- `usbg` (Brainux) sets up the USB gadget
