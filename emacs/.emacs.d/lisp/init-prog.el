;;; init-prog.el --- Programming support configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Language support, LSP (eglot), and code editing enhancements.
;;; Code:

(use-package flymake
  :defer t)

;; eglot
(use-package eglot
  :defer t
  :config
  (add-to-list 'eglot-server-programs
	       '(python-mode . ("pyright-langserver" "--stdio"))
	       '(sh-mode . ("bash-language-server" "start"))))

;; python
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :hook ((python-mode . eglot-ensure)
	 (python-mode . (lambda ()
			  (setq indent-tabs-mode nil
				python-indent-offset 4))))
  :custom
  (python-shell-interpreter "python3"))

(use-package blacken
  :hook (python-mode . blacken-mode)
  :config
  (setq blacken-line-length 88))

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
  :hook ((terraform-mode . eglot-ensure))
  :config
  (setq terraform-indent-level 2))

(use-package hcl-mode
  :ensure t)

(provide 'init-prog)
;;; init-prog.el ends here
