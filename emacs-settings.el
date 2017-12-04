(prefer-coding-system 'utf-8)
;; tab width = 4 spaces
(setq-default tab-width 4)
;; indent = spaces
(setq-default indent-tabs-mode nil)
;; do not use auto-save
(setq auto-save-default nil)
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
;; color-theme

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'undo-tree)
(add-hook 'after-init-hook 'global-undo-tree-mode)

(require 'color-theme)
(color-theme-initialize)

(require 'ag)
(require 'magit)
;; iedit
(require 'iedit)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; company-complete
(global-set-key (kbd "<C-tab>") 'company-complete)

;; python
(elpy-enable)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(require 'google-c-style)
(require 'indium)

(require 'slime)
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(add-to-list 'slime-contribs 'slime-fancy)

(require 'conda)
(conda-env-initialize-interactive-shells)
(conda-env-initialize-eshell)
(conda-env-autoactivate-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "/Users/ihongju/anaconda")
 '(package-selected-packages
   (quote
    (markdown-mode md-readme conda anaconda-mode company-anaconda ensime sbt-mode scala-mode slime slime-company nodejs-repl magit-gerrit indium npm-mode flycheck google-c-style vimrc-mode elpy auto-complete auto-complete-c-headers company-auctex company-bibtex company-c-headers company-rtags ag color-theme color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow color-theme-solarized company iedit magit org undo-tree)))
 '(python-shell-interpreter "python3"))

;
;; org-mode
;; (global-set-key (kbd "C-c s") 'org-store-link)
;; (global-set-key (kbd "C-c a") 'org-agenda)
;; (global-set-key (kbd "C-c c") 'org-capture)
;; (global-set-key (kbd "C-c i") 'org-iswitchb)
;
;; (define-key global-map (kbd "C-c ;") 'iedit-mode)

;

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)

; font size
(set-face-attribute 'default nil :height 160)

;; c++ -hook
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun my-c++-mode-hook ()
  (google-set-c-style)
  )        ; use my-style defined above

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(setq js-indent-level 2)
(setenv "PYTHONIOENCODING" "utf-8")
(setenv "LANG" "en_US.UTF-8")

(add-hook 'sh-mode-hook (lambda () (setq sh-basic-offset 2)))
(add-hook 'sh-mode-hook (lambda () (setq sh-indentation 2)))

(setq column-number-mode t)

(if (display-graphic-p)
  (color-theme-solarized)
  (color-theme-tty-dark))
