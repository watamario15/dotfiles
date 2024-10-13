# Dot files

My dotfiles for Linux, [Termux](https://termux.com/), [Brainux](https://brainux.org/), [macOS](https://www.apple.com/macos), and [FreeBSD](https://www.freebsd.org/). Most featured for Ubuntu and Fedora.

## Key features

### Bash

- Aliases for Python, Git, package managers, and GCC
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

### Screen

- Use UTF-8 encoding
- Use `Ctrl + J` instead of `Ctrl + A`
- Pretty status bar with load average and time
- Other essential configuations (for my environment)

### Tools

- `tools/cegcc` and `tools/ceg++` to build a Windows CE (Armv5TEJ) app

## Installation

Except for Brainux, run the following:

```sh
cd
git clone https://github.com/watamario15/dotfiles.git
cd dotfiles
./install.sh
```

Running `./initialize.sh` will set up git and install some basic packages. You can also set up:

- CASLII/COMETII simulator (Osaka University) with `./initialize.sh caslcomet`
- SHARP Brain development packages with `./initialize.sh brain` (Currently AMD64/Arm64 Linux only)
- MediaWiki to XTBook conversion environment with `./initialize.sh xtbook` (Currently AMD64/Arm64 Debian/Fedora-based only)

### Brainux

You must run Brainux `initialize.sh' on a PC that already has the Brainux partition mounted, and you will need to manually perform some steps described in the script before running it.

- `swap` (Brainux) sets up a swap with a given size (MB), the default is 1024 MB
- `usbg` (Brainux) sets up the USB gadget
