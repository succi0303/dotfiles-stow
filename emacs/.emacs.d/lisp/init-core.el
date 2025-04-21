;;; init-core.el --- Core configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package emacs
  :init
  (defun my/reload-init-file ()
   "Reload Emacs init.el file."
    (interactive)
    (load-file (expand-file-name "init.el" user-emacs-directory)))
  :bind
  (("C-c r" . my/reload-init-file))
  :config
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  (normal-erase-is-backspace-mode 0)
  (global-set-key "\C-h" 'delete-backward-char)
  (transient-mark-mode t)
  (windmove-default-keybindings)
  (setq windmove-wrap-around t)
  (setq mac-command-modifier 'meta))

(use-package which-key
  :config (which-key-mode))

(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25))

(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))

(use-package undo-fu
  :ensure t
  :bind*
  ("C-/" . undo-fu-only-undo)
  ("M-/" . undo-fu-only-redo))

;; project
(use-package projectile
  :config
  (projectile-mode 1))

(use-package otpp
  :ensure t
  :after project
  :init
  (otpp-mode 1)
  (otpp-override-mode 1))

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard"
	dashboard-center-content t
	dashboard-vertically-center-content t
	dashboard-show-shortcuts t
	dashboard-navigation-cycle t
	dashboard-week-agenda t)
  (setq dashboard-items '((recents . 5)
			  (projects . 5)
			  (agenda . 8)))
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))


(provide 'init-core)
;;; init-core.el ends here
