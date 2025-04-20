;;; init-prog.el --- Programming support configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Language support, LSP (eglot), and code editing enhancements.
;;; Code:

(use-package flymake
  :defer t)

(use-package flycheck
  :ensure t
  :hook (terraform-mode . flycheck-mode))

;; eglot
(use-package eglot
  :defer t
  :config
  (defun mise-which (tool-name)
    (string-trim (shell-command-to-string (format "mise which %s" tool-name))))
  (add-to-list 'eglot-server-programs
	       '(sh-mode . ((,mise-which "bash-language-server") "start"))
	       '(terraform-mode . ((,mise-which "terraform-ls") "serve")))
  )


;; python
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :hook ((python-mode . eglot-ensure)
	 (python-mode . (lambda ()
			  (setq indent-tabs-mode nil
				python-indent-offset 4))))
  :custom
  (python-shell-interpreter "python3"))

;; shell script
(use-package sh-script
  :mode (("\\.\\(sh\\|bash\\|zsh\\)\\'" . sh-mode))
  :hook ((sh-mode . eglot-ensure))
  :custom
  (sh-basic-offset 2)
  (sh-indentation 2))

;; terraform
(use-package terraform-mode
  :mode ("\\.tf\\'" . terraform-mode)
  :hook (
	 (terraform-mode . eglot-ensure)
	 (terraform-mode . terraform-format-on-save-mode))
  :config
  (setq terraform-indent-level 2))

(use-package hcl-mode
  :ensure t)

(provide 'init-prog)
;;; init-prog.el ends here
