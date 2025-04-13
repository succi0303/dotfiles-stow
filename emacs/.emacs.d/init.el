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

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; General
(setq make-backup-files nil)
(setq auto-save-default nil)
(normal-erase-is-backspace-mode 0)
(global-set-key "\C-h" 'delete-backward-char)
(transient-mark-mode t)
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; Appearance

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(line-number-mode +1)
(global-hl-line-mode 1)
(column-number-mode +1)
(global-display-line-numbers-mode t)
(custom-set-variables '(display-line-numbers-width-start t))
(tab-bar-mode t)
(global-visual-line-mode t)
(when (equal system-type 'darwin)
  (setq mac-command-modifier 'meta))

;; theme
(use-package kaolin-themes
  :config (load-theme 'kaolin-eclipse t))

(set-frame-parameter (selected-frame) 'alpha '(85 85))
(add-to-list 'default-frame-alist '(alpha 85 85))

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
(setq show-paren-style 'mixed) ;; 'parenthesis, 'expression, 'mixed
(electric-pair-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; indent
(use-package highlight-indent-guides
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character) ;; 'fill', 'column', 'character'
  (setq highlight-indent-guides-character ?\|))

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
  (when (char-equal (char-after) ?\))
    (save-excursion
      (ignore-errors
        (backward-sexp)
        (pulse-momentary-highlight-one-line (point))))))

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

;; minibuffer & completions

(use-package vertico
  :custom
  (vertico-count 20)
  (vertico-cycle t)
  (vertico-resize t)
  :init
  (vertico-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode))

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))



(use-package orderless
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package consult
  :bind
  (("C-c h" . consult-history)
   ("C-c b" . consult-buffer)
   ("C-s" . consult-line)
   ("C-c g" . consult-goto-line)
   ("C-c G" . consult-goto-line)
   ("C-c h" . consult-org-heading)
   :map minibuffer-local-map
    ("C-r" . consult-history))
  :config
  (setq consult-line-start-from-top t)
  (setq register-preview-delay 0.5))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :custom
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 2) 
  (company-dabbrev-other-buffers t) 
  (company-dabbrev-code-other-buffers t)
  :config
  (defun my/company-dabbrev-setup ()
    (setq-local company-backends '(company-dabbrev)))
  (setq company-backends
        '((company-dabbrev-code company-keywords)
          company-files
          company-dabbrev)))

;; Package Configuration

;; org-mode
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode))
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-x n s" . org-narrow-subtree)
   ("C-x n w" . widen)
   :map org-mode-map
   ("<RET>" . #'org-insert-heading-respect-content)
   ("C-<RET>" . #'newline))
  :config
  (setq org-directory "~/org/"
	org-default-notes-file "~/org/inbox.org"
	org-startup-with-inline-images t
	org-image-visual-width nil
	org-clock-into-drawer t
	org-startup-folded 'content
	org-hide-leading-starts t
	org-ellipsis " ▼ "
	org-return-follows-link t)
  (setq org-hide-emphasis-markers t)
  ;; refile
  (setq org-refile-targets
	'((org-agenda-files :maxlevel . 3)))
  (setq org-outline-path-complete-in-steps t)
  (setq org-refile-use-outline-path 'file)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  ;; TODO status
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w@/!)" "IN-PROGRESS(i)" "|" "DONE(d!)" "CANCELLED(c@)")))
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "orange" :weight bold))
          ("WAITING" . (:foreground "gold" :weight bold))
          ("IN-PROGRESS" . (:foreground "deepskyblue" :weight bold))
          ("DONE" . (:foreground "forest green" :weight bold))
          ("CANCELLED" . (:foreground "gray" :weight bold))))
  ;; org-capture
  (setq org-capture-templates
        '(("i" "Inbox" entry
	   (file+headline "inbox.org" "INBOX")
	   "* %?")
	  ("t" "Todo" entry
           (file+headline "tasks.org" "TASKS")
           "* TODO %?\n  %U\n  %a")
          ("n" "Note" entry
           (file+headline "notes.org" "NOTES")
           "* %?\n  %U\n  %a")))
  ;; org-agenda
  (setq org-agenda-files (list org-directory)
	org-log-done 'time))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package org-journal
  :ensure t
  :init
  (global-set-key (kbd "C-c j") #'org-journal-new-entry)
  (setq org-jounal-dir "~/org/journal/"
	org-journal-date-format "%Y-%m-%d"
	org-journal-file-format "%Y-%m.org"
	org-journal-time-format ""
	org-journal-enable-agenda-integration t
	org-journal-file-type 'monthly)
  (setq org-journal-header "#+TITLE: %Y-%m Journal\n#+STARTUP: fold\n"))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package git-gutter
  :config (global-git-gutter-mode 1))

(use-package which-key
  :config (which-key-mode))

(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 25))

(use-package projectile
  :config (projectile-mode +1))

;; markdown

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "pandoc"))

;; init.el ends here
