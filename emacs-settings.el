(prefer-coding-system 'utf-8)
;; indent = spaces
(setq-default indent-tabs-mode nil)
;; do not use auto-save
(setq auto-save-default nil)
;; collect backup in one place
(setq-default tab-width 2)
(setq
  backup-by-copying t      ; don't clobber symlinks
  backup-directory-alist
  '(("." . "/home/hongjoo/.emacs.d/emacs-backups"))    ; don't litter my fs tree
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
(global-set-key (kbd "C-x >") (kbd (format "C-u %d C-x TAB" tab-width)))
(global-set-key (kbd "C-x <") (kbd (format "C-u - %d C-x TAB" tab-width)))
;; C-j <-> RET
(global-set-key (kbd "<RET>") 'electric-indent-just-newline)
(global-set-key (kbd "C-j") 'newline-and-indent)

;;; add package manager
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "https://melpa.milkbox.net/packages/") t)
)

(defvar my-packages
  '(ag
    color-theme-modern
    company
    company-c-headers
    company-go
    conda
    csharp-mode
    dockerfile-mode
    elpy
    exec-path-from-shell
    flycheck
    geiser
    go-mode
    google-c-style
    iedit
    indium  ;; JavaScript
    json-mode
    magit
    magit-gerrit
    markdown-mode
    nodejs-repl
    npm-mode
    org
    py-yapf
    pylint
    racket-mode
    rjsx-mode
    scala-mode
    slime
    slime-company
    solarized-theme
    undo-tree
    vimrc-mode
    vmd-mode
    vue-mode
    yaml-mode))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      my-packages)

;; Have to be on top of other packages
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "PATH")

(require 'undo-tree)
(add-hook 'after-init-hook 'global-undo-tree-mode)

(require 'ag)
(require 'magit)
;; iedit
(require 'iedit)
(define-key global-map (kbd "C-c ;") 'iedit-mode)

(require 'company)
(require 'company-go)
(add-hook 'after-init-hook 'global-company-mode)

;; company-complete
(global-set-key (kbd "<C-tab>") 'company-complete)

;; python
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "/home/hongjoo/miniconda3/")
 '(package-selected-packages
   (quote
    (company-go flycheck json-reformat yaml-mode go-mode dockerfile-mode rjsx-mode vmd-mode markdown-mode md-readme conda anaconda-mode company-anaconda ensime sbt-mode scala-mode slime slime-company nodejs-repl magit-gerrit indium npm-mode google-c-style vimrc-mode elpy auto-complete auto-complete-c-headers company-auctex company-bibtex company-c-headers company-rtags ag company iedit magit org undo-tree))))
(elpy-enable)
;; Use flycheck instead of flymake
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode)

;; Javascript
(require 'indium)

(require 'google-c-style)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)

; font size
(set-face-attribute 'default nil :height 120)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

(defun my-c++-mode-hook ()
  (setq tab-width 4))

(defun my-sh-mode-hook ()
  (setq sh-basic-offset 2)
  (setq tab-width 2)
  (setq sh-indentation 2))

(defun my-python-mode-hook ()
  (setq tab-width 4)
  (setq python-shell-interpreter "ipython3")
  (setq python-shell-interpreter-args "--simple-prompt --pprint")
  (py-yapf-enable-on-save))

(defun my-js-mode-hook ()
  (setq tab-width 2)
  (flycheck-mode)
  (advice-add
   'js--multi-line-declaration-indentation
   :around (lambda (orig-fun &rest args) nil))
  (setq js-indent-level 2)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil))

(defun my-csharp-mode-hook ()
  ;; enable the stuff you want for C# here
  ;; Emacs 25
  (electric-pair-local-mode 1))

(defun my-go-mode-hook ()
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (set (make-local-variable 'company-backends) '(company-go)))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'sh-mode-hook 'my-sh-mode-hook)
(add-hook 'python-mode-hook 'my-python-mode-hook)
(add-hook 'rjsx-mode-hook 'flycheck-mode)
(add-hook 'js2-mode-hook 'my-js-mode-hook)
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)
(add-hook 'go-mode-hook 'my-go-mode-hook)

(setenv "PYTHONIOENCODING" "utf-8")
(setenv "LANG" "en_US.UTF-8")
(setq inferior-lisp-program "/usr/bin/sbcl")

(setq column-number-mode t)

(if (display-graphic-p)
  (load-theme 'solarized-dark t)
  (load-theme 'clarity t))
