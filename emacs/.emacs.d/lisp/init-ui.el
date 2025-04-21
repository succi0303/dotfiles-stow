
;;; Code:


;; theme with transparent background
(use-package emacs
  :config
  ;; general
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (tab-bar-mode t)
  (line-number-mode t)
  (column-number-mode t)
  (global-display-line-numbers-mode t)
  (custom-set-variables '(display-line-number-width-start t))
  (global-hl-line-mode t)
  (global-visual-line-mode t)
  
  ;; theme
  (require-theme 'modus-themes)
  (setq modus-themes-italic-constructs nil
	modus-themes-bold-constructs nil)
  (load-theme 'modus-vivendi)
  ;(add-to-list 'default-frame-alist '(background-color . "unspecified-bg"))
  (add-to-list 'default-frame-alist '(background-color . "#1e1e1e"))
  
  ;; toggle background transparency
  (defvar my/transparent-background-enabled nil
    "Whether the transparent background is enabled.")
  (defun my/toggle-transparent-background ()
    "Toggle Emacs background transparency (terminal-compatible)."
    (interactive)
    (if my/transparent-background-enabled
	(progn
          (set-face-background 'default "#1e1e1e" (selected-frame)) ;; ← 好みの背景色に変更可
          (message "transparent off!"))
      (progn
	(set-face-background 'default "unspecified-bg" (selected-frame))
	(message "transparent on!")))
    (setq my/transparent-background-enabled (not my/transparent-background-enabled)))
  (global-set-key (kbd "C-c u") #'my/toggle-transparent-background))

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

;; anzu
(use-package anzu
  :ensure t
  :demand t
  :init
  (global-anzu-mode +1)
  :custom
  (anzu-use-migemo nil)
  (anzu-deactivate-region t)
  (anzu-search-threshold 1000)
  (anzu-replace-to-string-separator " => ")
  (anzu-mode-lighter "")
  :config
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))


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

(provide 'init-ui)
;;; init-ui.el ends here
