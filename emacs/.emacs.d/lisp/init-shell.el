;;; init-shell.el --- Shell configuration -*- coding: utf-8 ; lexical-binding: t -*-
;;; Commentary:
;; Shell packages and configurations
;;; init-shell.el --- -*- coding=utf-8 -*-
;;; Code:
(use-package eshell
  :hook
  (eshell-mode . (lambda ()
		   (eshell/alias "e" "find-file $1")))
  :config
  (setq eshell-history-size 10000
	eshell-hist-ignoredups t
	eshell-save-history-on-exit t
	eshell-prefer-lisp-functions nil
	eshell-banner-message ""))

(use-package eshell-toggle
  :ensure t
  :bind (("C-c ." . eshell-toggle))
  :custom
  (eshell-toggle-window-side 'below)
  (eshell-toggle-size-fraction 2))

(use-package eshell-git-prompt
  :after eshell
  :config
  (eshell-git-prompt-use-theme 'powerline))

(use-package eshell-did-you-mean
  :hook (eshell-mode . eshell-did-you-mean-setup))

(provide 'init-shell)
;;; init-ui.el ends here
