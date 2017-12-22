# emacs-settings
My personal emacs-settings and documentations

## .emacs
Copy emacs-settings.el to .emacs.

## Tab
* Do not use tab. Indent with space.
* Use different tab-width for different modes.

## Backup
* Collect backups in one place (.emacs.d/emacs-backups).

## Keybindings.
* `C-h` as backspace - move help command to `C-?`.
* `C-c >` and `C-c <` for region shifting. Shift size depends on tab-width.
* Use `<RET>` as newline, use `C-j` as indent newline.
* Use vim-like keys for navigating windows (h-j-j-l with `C-c`).
* Place non-package-depending keybindings at before package manager.

## Package management
Manage package with package manager and melpa archive. Minimize custom packages.

## Packages
### ag
* Requires silver-searcher
* `sudo apt-get install silversearcher-ag`

### color-theme
### company
### elpy
### google-c-style
### iedit
### magit
### org
### undo-tree
### vmd-mode
* Requires vmd from npm.
* `npm install -g vmd --unsafe-perm=true`


## Color theme

## Managing programming environments.
