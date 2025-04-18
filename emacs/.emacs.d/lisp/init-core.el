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
(setq mac-command-modifier 'meta)

(use-package emacs
  :init
  (defun my/reload-init-file ()
    "Reload Emacs init.el file."
    (interactive)
    (load-file (expand-file-name "init.el" user-emacs-directory)))
  :bind
  (("C-c r" . my/reload-init-file)))

(use-package which-key
  :config (which-key-mode))

(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25))

(use-package projectile
  :config
  (projectile-mode 1))

(use-package undo-fu
  :ensure t
  :bind*
  ("C-/" . undo-fu-only-undo)
  ("M-/" . undo-fu-only-redo))

(use-package clipetty
  :ensure t
  :hook (after-init . global-clipetty-mode))


(provide 'init-core)
;;; init-core.el ends here
