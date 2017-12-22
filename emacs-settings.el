(prefer-coding-system 'utf-8)
(setq-default indent-tabs-mode nil)
(setq auto-save-default nil)
(setq column-number-mode t)
(put 'dired-find-alternate-file 'disabled nil)
; font size
(set-face-attribute 'default nil :height 160)

;; collect backup in one place
(setq
  backup-by-copying t      ; don't clobber symlinks
  backup-directory-alist
  '(("." . "~/.emacs.d/emacs-backups"))    ; don't litter my fs tree
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t
) ; use versioned backups

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
; vi style key binding for frame move
(global-set-key (kbd "\C-c h")  'windmove-left)
(global-set-key (kbd "\C-c l") 'windmove-right)
(global-set-key (kbd "\C-c k")    'windmove-up)
(global-set-key (kbd "\C-c j")  'windmove-down)
;; shift region
(global-set-key (kbd "C-c >") (kbd (format "C-u %d C-x TAB" tab-width)))
(global-set-key (kbd "C-c <") (kbd (format "C-u - %d C-x TAB" tab-width)))
;; C-j <-> RET
(global-set-key (kbd "<RET>") 'electric-indent-just-newline)
(global-set-key (kbd "C-j") 'newline-and-indent)

;;; add package manager
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
)

(package-initialize)

(require 'ag)
(require 'color-theme)
(require 'company)
(require 'exec-path-from-shell)
(require 'google-c-style)
(require 'iedit)
(require 'magit)
(require 'undo-tree)


(add-hook 'after-init-hook 'global-undo-tree-mode)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "<C-tab>") 'company-complete)
(define-key global-map (kbd "C-c ;") 'iedit-mode)
(color-theme-initialize)
(exec-path-from-shell-initialize)


(if (display-graphic-p)
  (color-theme-solarized)
  (color-theme-tty-dark))
