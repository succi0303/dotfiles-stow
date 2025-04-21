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
  :bind ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
	aw-background t
	aw-dispatch-always nil
	aw-dispatch-alist
        '((?x aw-delete-window "Delete Window")
          (?m aw-swap-window "Swap Windows")
          (?M aw-move-window "Move Window")
          (?c aw-copy-window "Copy Window")
          (?s aw-switch-buffer-other-window "Switch Buffer Other Window")
          (?n aw-flip-window)
          (?u aw-switch-buffer-in-window "Switch Buffer")
          (?f aw-split-window-fair "Split Fair Window")
          (?v aw-split-window-vert "Split Vert Window")
          (?h aw-split-window-horz "Split Horz Window"))))

(use-package golden-ratio
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-auto-scale t)
  (add-to-list 'golden-ratio-exclude-modes "ediff-mode"))

(use-package winner
  :ensure nil
  :config
  (winner-mode 1)
  :bind (("C-c <left>" . winner-undo)
	 ("C-c <right>" . winner-redo)))

;; buffer & tab
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-height 32)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "*")
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-group-by-projectile-project t)
  (setq centaur-tabs-excluded-buffers '("*Messages*" "*scratch*" "*Completions*")))

;; workspace & project
(use-package perspective
  :bind (("C-x k" . persp-kill-buffer*) 
         ("C-x C-b" . persp-list-buffers))
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :config
  (persp-mode)
  (define-key perspective-map (kbd "s") #'persp-switch)
  (define-key perspective-map (kbd "k") #'persp-remove-buffer)
  (define-key perspective-map (kbd "c") #'persp-kill)
  (define-key perspective-map (kbd "r") #'persp-rename)
  (define-key perspective-map (kbd "a") #'persp-add-buffer)
  (define-key perspective-map (kbd "A") #'persp-set-buffer)
  (define-key perspective-map (kbd "b") #'persp-switch-to-buffer)
  (defun persp-update-frames ()
    (walk-windows
     (lambda (w)
       (let ((frame (window-frame w)))
         (when (and (frame-live-p frame)
                    (not (member frame persp-inhibit-display-frames)))
           (let ((persp (persp-curr))
                 (name (safe-persp-name (persp-curr))))
             (when name
               (set-frame-parameter frame 'title
                                   (format "%s - Emacs" name)))))))
     nil t)
    (force-mode-line-update t))
  (add-hook 'persp-activated-functions
            (lambda (_) (persp-update-frames))))

(use-package projectile
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
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
