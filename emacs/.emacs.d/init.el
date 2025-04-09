;;; init.el --- My init script -*- coding: utf-8 ; lexical-binding: t -*-
;; Author: succi0303
;;; Commentary:
;;; Code:

;; Custom file

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;; Package Manager

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))

(leaf leaf-keywords
      :ensure t
      :config
      (leaf-keywords-init))

;; Appearance

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(line-number-mode +1)
(column-number-mode +1)
(global-display-line-numbers-mode t)
(custom-set-variables '(display-line-numbers-width-start t))
(tab-bar-mode t)

(leaf doom-themes
  :ensure t
  :defun (doom-themes-visual-bell-config)
  :config
  (load-theme'doom-vibrant t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(leaf doom-modeline
  :ensure t
  :global-minor-mode t
  :custom
  (doom-modeline-bar-width . 4)
  (doom-modeline-hud . t))

(leaf beacon
  :ensure t
  :global-minor-mode t)

(leaf volatile-highlights
  :ensure t
  :global-minor-mode t)

(leaf nerd-icons
  :ensure t)

(leaf nerd-icons-completion
  :ensure t)

(leaf nerd-icons-dired
  :ensure t
  :hook (dired-mode . nerd-icons-dired-mode))

(leaf puni
  :ensure t
  :global-minor-mode puni-global-mode)

;; minibuffer & completions

(leaf vertico
  :ensure t
  :hook (after-init . vertico-mode))

(leaf marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(leaf orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(leaf savehist
  :config
  (savehist-mode 1))

(leaf corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind ((corfu-map
	  ("<tab>" . corfu-complete)))
  :config
  (setq tab-always-indent 'complete)
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)
  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1)
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

;; File Manager (Dired)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq delete-by-moving-to-trash t)
(setq dired-dwim-target t)

(leaf dired-subtree
  :ensure t
  :after dired
  :bind ((dired-mode-map
	  ("<tab>" . dired-subtree-toggle)
	  ("TAB" . dired-subtree-toggle)
	  ("<backtab>" . dired-subtree-remove)
	  ("S-TAB" . dired-subtree-remove)))
  :config (setq dired-subtree-use-backgrounds nil))

(leaf trashed
  :ensure t
  :commands (trashed)
  :config
  (setq trashed-action-confirmer 'y-or-n-p)
  (setq trashed-use-header-line t)
  (setq trashed-sort-key '("Date deleted" . t))
  (setq trashed-date-format "%Y-%m-%d %h:%M:%S"))

;; Pakage Configuration

;; org-mode
(leaf org
  :bind
  (("C-c c" . org-capture)
   ("C-c a" . org-agenda)
   ("C-c l" . org-store-link)
   (:org-mode-map
    ("C-c C-;" . org-edit-special))
   (:org-src-mode-map
    ("C-c C-;" . org-edit-src-special)))
  :mode
  ("\\.org$" . org-mode)
  :custom
  ((org-directory . "~/org/")
   (org-default-note-file . "~/org/inbox.org")
   (org-log-done . t)
   (org-clock-persist . t)
   (org-clock-out-when-done . t)
   (org-adapt-indentation . nil)
   (org-startup-indented . t)
   (org-startup-folded . 'fold)
   (org-hide-leading-stars . t)
   (org-ellipsis . " ▼")))

(leaf org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

;; Git

(leaf magit
  :ensure t
  :bind ("C-x g" . magit-status))

(leaf git-gutter
  :ensure t
  :global-minor-mode global-git-gutter-mode)

;; Language Protocol Server
(leaf eglot
  :hook
  (html-mode . eglot-ensure)
  (go-mode . eglot-ensure)
  (typescript-mode . eglot-ensure))

;; docker
(leaf docker
  :ensure t)

(leaf dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

;; vterm
(leaf vterm
  :ensure t
  :commands vterm
  :config
  (setq vterm-shell "/usr/bin/bash"))

;; UI & Other packages
(leaf ivy
  :ensure t
  :config (ivy-mode 1))

(leaf counsel
  :ensure t
  :after ivy
  :config (counsel-mode 1))

(leaf which-key
  :ensure t
  :config (which-key-mode))

(leaf recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25))


(leaf projectile
  :ensure t
  :config (projectile-mode +1))

;; init.el ends here
