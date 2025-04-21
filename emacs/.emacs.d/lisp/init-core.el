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

;; window
(use-package ace-window
  :bind ("C-c w" . ace-window)
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-scope 'frame)
  (aw-background t))

(use-package golden-ratio
  :diminish
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t)
  (add-to-list 'golden-ratio-extra-commands 'ace-window))

(use-package winner
  :ensure nil
  :config
  (winner-mode 1)
  :bind (("C-c <left>" . winner-undo)
	 ("C-c <right>" . winner-redo)))

;; buffer
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :config
  (setq ibuffer-saved-filter-groups
        '(("default"
           ("dired" (mode . dired-mode))
           ("org" (mode . org-mode))
           ("programming" (or
                           (mode . python-mode)
                           (mode . emacs-lisp-mode)
                           (mode . c-mode)))
           ("shell" (or
                     (mode . eshell-mode)
                     (mode . shell-mode)
                     (mode . term-mode)
                     (mode . vterm-mode)))
           ("magit" (name . "^magit"))
           ("help" (or
                    (name . "\*Help\*")
                    (name . "\*Apropos\*")
                    (name . "\*info\*")))
           ("internal" (name . "^\*.*\*$")))))
  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "default"))))

(use-package ibuffer-projectile
  :after ibuffer
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-projectile-set-filter-groups)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

(use-package midnight
  :ensure nil
  :config
  (midnight-mode)
  (setq clean-buffer-list-delay-general 1))

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))


;; project
(use-package projectile
  :diminish
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'default)
  (setq projectile-indexing-method 'alien)
  (setq projectile-switch-project-action #'projectile-find-file)
  :bind-keymap
  ("C-x p" . projectile-command-map)
  :bind
  (:map projectile-command-map
        ("p" . projectile-persp-switch-project)))

(use-package persp-projectile
  :after (perspective projectile))

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
