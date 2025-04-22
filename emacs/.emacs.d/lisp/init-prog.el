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
	       '((html-mode css-mode web-mode) . ("vscode-html-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
	       '((typescript-ts-mode js-ts-mode)
		 . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(python-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(sh-mode . ("bash-language-server" "start")))
  (add-to-list 'eglot-server-programs
               '(terraform-mode . ("terraform-ls" "serve"))))

;; yasnippet
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :after yasnippet)

;; html, css, javascript, typescript
(use-package web-mode
  :hook ((html-mode . eglot-ensure)
	 (css-mode . eglot-ensure)
	 (web-mode . eglot-ensure))
  :mode "\\.html?\\'")

(use-package typescript-ts-mode
  :hook ((typescript-ts-mode . eglot-ensure)
	 (js-ts-mode . eglot-ensure))
  :mode (("\\.ts\\'" . typescript-ts-mode)
	 ("\\.tsx\\'" . typescript-ts-mode)
	 ("\\.js\\'" . js-ts-mode)
	 ("\\.jsx\\'" . js-ts-mode)))

(use-package npm-mode
  :hook (typescript-ts-mode . npm-mode))

(use-package prettier
  :hook ((typescript-ts-mode . prettier-mode)
	 (js-ts-mode . prettier-mode)
	 (html-mode . prettier-mode)
	 (css-mode . prettier-mode)))

;; python
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :hook ((python-mode . eglot-ensure)
	 (python-mode . (lambda ()
			  (setq indent-tabs-mode nil
				python-indent-offset 4))))
  :custom
  (python-shell-interpreter "python3"))

(use-package pyvenv
  :config
  (pyvenv-mode 1))

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
