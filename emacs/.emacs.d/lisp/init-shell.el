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
  :hook (dired-mode . dired-hide-details-mode)
  :bind (("C-c d" . dired-jump)
	 :map dired-mode-map
	      ("E" . wdired-change-to-wdired-mode)
	      ("/" . dired-narrow)
	      ("," . dired-create-empty-file)
	      ("C-c C-e" . dired-toggle-read-only)
	      (";" . dired-subtree-toggle))
  :config
  (setq dired-recursive-copies 'always
	dired-recursive-deletes 'top
	dired-listing-switches "-alhG --group-directories-first"
	dired-dwim-target t
	dired-use-ls-dired t
	dired-case-fold-search t)
  (when (and (eq system-type 'darwin)
	     (executable-find "gls"))
    (setq insert-directory-program "gls"))
  (add-hook 'dired-mode-hook #'dired-hide-details-mode))

(use-package wdired
  :ensure nil
  :after dired
  :config
  (setq wdired-allow-to-change-permissions t
	wdired-create-parent-directories t))

(use-package dired-aux
  :ensure nil
  :config
  (add-to-list 'dired-compress-file-suffixes
	       '("\\.zip\\'" ".zip" "unzip"))
  (add-to-list 'dired-compress-file-suffixes
	       '("\\.tar\\.gz\\'" ".tar.gz" "tar -xzf")))

(use-package dired-rsync
  :bind (:map dired-mode-map
	      ("r" . dired-rsync)))

(use-package dired-quick-sort
  :bind (:map dired-mode-map
	      ("s" . hydra-dired-quick-sort/body)))

(use-package dired-subtree
  :ensure t
  :bind (:map dired-mode-map
	      ("<tab>" . dired-subtree-toggle)
	      ("<C-tab>" . dired-subtree-cycle)))


(provide 'init-shell)
;;; init-ui.el ends here
