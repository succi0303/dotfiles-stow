;;; init-shell.el --- Shell configuration -*- coding: utf-8 ; lexical-binding: t -*-
;;; Commentary:
;; Shell packages and configurations
;;; init-shell.el --- -*- coding=utf-8 -*-
;;; Code:

;; vterm
(use-package vterm
  :ensure t
  :commands vterm
  :bind (:map vterm-mode-map
	      ("C-c C-c" . vterm-send-C-c)
	      ("C-c C-l" . vterm-clear-scrollback)
	      ("C-c C-n" . vterm-next-prompt)
	      ("C-c C-p" . vterm-previous-prompt))
  :config
  (setq vterm-max-scrollback 10000)
  (setq comint-prompt-read-only t))

(use-package vterm-toggle
  :ensure t
  :custom
  (vterm-toggle-fullscreen-p nil)
  (vterm-toggle-use-dedcated-buffer t)
  :bind (("C-c t" . vterm-toggle)))

(use-package multi-vterm
  :after vterm
  :bind (("C-c v n" . multi-vterm)
	 ("C-c v p" . multi-vterm-prev)
	 ("C-c v t" . multi-vterm-next)))

;; dired
(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-alh")
  (dired-dwim-target t)
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  :bind (:map dired-mode-map
	      ("C-c o . 'dired-find-file-other-window")
	      ("C-c C-o" . 'dired-display-file))
  :config
  (require 'dired-x)
  (setq dired-omit-files "^\\...+$")
  (add-hook 'dired-mode-hook
	    (lambda ()
	      (dired-omit-mode 1)))
  (when (and (eq system-type 'darwin)
	     (executable-find "gls"))
    (setq insert-directory-program "gls")))

(provide 'init-shell)
;;; init-ui.el ends here
