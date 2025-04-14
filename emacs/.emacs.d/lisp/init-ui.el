;;; init-ui.el --- UI configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(menu-bar-mode -1)
(tool-bar-mode -1)
(tab-bar-mode t)
(scroll-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(global-display-line-numbers-mode t)
(custom-set-variables '(display-line-number-width-start t))
(global-hl-line-mode t)
(global-visual-line-mode t)

(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

;; theme
(use-package kaolin-themes
  :ensure t
  :config
  (load-theme 'kaolin-eclipse t))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))

(use-package minions
  :ensure t
  :config
  (minions-mode 1))

;; paren
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)
(electric-pair-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; indent
(use-package indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode)
  :config
  (setq indent-guide-char "|")
  (setq indent-guide-delay 0.1))

;; visibility
(use-package beacon
  :config (beacon-mode 1))

(use-package highlight-symbol
  :ensure t
  :hook (prog-mode . highlight-symbol-mode)
  :config
  (setq highlight-symbol-idle-delay 0.2))

(use-package volatile-highlights
  :ensure t
  :config (volatile-highlights-mode 1))

(use-package pulse
  :config
  (defun my/pulse-line (&rest _)
    (pulse-momentary-highlight-one-line (point)))
  (dolist (cmd '(recenter-top-bottom
                 other-window
                 avy-goto-word-1
                 consult-line
                 consult-buffer))
    (advice-add cmd :after #'my/pulse-line)))

(defun my/pulse-matching-paren ()
  (let ((char (char-after)))
    (when (and char (char-equal char ?\)))
      (save-excursion
        (ignore-errors
          (backward-sexp)
          (pulse-momentary-highlight-one-line (point)))))))
(advice-add 'show-paren-function :after #'my/pulse-matching-paren)

;; sidebar
(use-package treemacs
  :ensure t
  :defer t
  :bind
  (:map global-map
	("C-c t" . treemacs))
  :custom
  (treemacs-width 30)
  (treemacs-no-png-images t))

(provide 'init-ui)
;;; init-ui.el ends here
