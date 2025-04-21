;;; init-shell.el --- Shell configuration -*- coding: utf-8 ; lexical-binding: t -*-
;;; Commentary:
;; Shell packages and configurations
;;; init-shell.el --- -*- coding=utf-8 -*-
;;; Code:

;; vterm
(use-package vterm
  :ensure t
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000)
  (setq comint-prompt-read-only t))

(use-package vterm-toggle
  :ensure t
  :custom
  (vterm-toggle-fullscreen-p nil)
  (vterm-toggle-use-dedcated-buffer t)
  :bind (("C-x ," . vterm-toggle)))

;; dired
(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-alh --group-directories-first")
  (dired-dwim-target t)
  (dired-hide-details-hide-symlink-targets nil)
  :config
  (add-hook 'dired-mode-hook #'dired-hide-details-mode))

(use-package dired-subtree
  :ensure t
  :bind (:map dired-mode-map
	      ("<tab>" . dired-subtree-toggle)
	      ("<C-tab>" . dired-subtree-cycle)))


(provide 'init-shell)
;;; init-ui.el ends here
