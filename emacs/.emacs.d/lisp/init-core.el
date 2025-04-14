;;; init-core.el --- Core configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq make-backup-files nil)
(setq auto-save-default nil)
(normal-erase-is-backspace-mode 0)
(global-set-key "\C-h" 'delete-backward-char)
(transient-mark-mode t)
(windmove-default-keybindings)
(setq windmove-wrap-around t)

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta))

(use-package which-key
  :config (which-key-mode))

(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25))

(use-package projectile
  :config
  (projectile-mode 1))

(provide 'init-core)
;;; init-core.el ends here
