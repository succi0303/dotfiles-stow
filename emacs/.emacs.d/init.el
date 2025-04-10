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

;; General
(setq make-backup-files t)

;; Appearance

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(line-number-mode +1)
(column-number-mode +1)
(global-display-line-numbers-mode t)
(custom-set-variables '(display-line-numbers-width-start t))
(tab-bar-mode t)
(global-visual-line-mode t)

(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

(leaf doom-themes
  :ensure t
  :defun (doom-themes-visual-bell-config)
  :config
  (load-theme 'doom-laserwave t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  )

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
  :global-minor-mode t)

(leaf marginalia
  :ensure t
  :global-minor-mode t)

(leaf orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(leaf consult
  :ensure t
  :hook
  (completion-list-mode-hook . consult-preview-at-point-mode)
  :custom
  (consult-line-start-from-top . t)
  :bind
  (("C-c h" . consult-history)
   ("C-c b" . consult-buffer)
   ("C-s" . consult-line)
   ("C-c g" . consult-goto-line)
   ("C-c G" . consult-goto-line)
   (minibuffer-local-map
    :package emacs
    ("C-r" . consult-history))))

(leaf embark-consult
  :ensure t
  :bind ((minibuffer-mode-map
	 :package emacs
	 ("M-x" . embark-dwim)
	 ("C-." . embark-act))))

(leaf corfu
  :ensure t
  :global-minor-mode global-corfu-mode corfu-popupinfo-mode
  :custom
  ((corfu-auto . t)
   (corfu-auto-delay . 0)
   (corfu-auto-prefix . 1)
   (corfu-popupinfo-delay . nil))
  :bind ((corfu-map
	  ("C-s" . corfu-insert-separator))))

(leaf cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file))

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
  :custom
  ((org-directory . "~/org/")
  (org-default-notes-file . "~/org/inbox.org")
  (org-log-done . t)
  (org-startup-indented . t)
  (org-hide-leading-stars . t)
  (org-ellipsis . " ▼")))

(leaf org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(leaf org-capture
  :bind (("C-c c" . org-capture))
  :custom
  ((org-capture-templates .
			  '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
			     "* TODO %?\n %U\n %a")
			    ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
			     "* %?\nEntered on %U\n %i\n %a")))))

(leaf org-agenda
  :bind (("C-c a" . org-agenda)))

(leaf org-journal
  :ensure t
  :custom
  ((org-journal-dir . "~/org/journal/")
   (org-journal-date-format . "%A, %Y-%m-%d")
   (org-journal-file-format . "%Y-%m-%d.org")
   (org-journal-time-format . "")
   (org-journal-enable-agenda-integration . t))
  :bind (("C-c j" . org-journal-new-entry)))
   

;; git

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
