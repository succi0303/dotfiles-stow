;;; init-prog.el --- Programming support configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Language support, LSP (eglot), and code editing enhancements.
;;; Code:

(use-package eglot
  :defer t
  :config
  (add-to-list 'eglot-server-programs
	       '(sh-mode . ("bash-language-server" "start"))
	       '(terraform-mode . ("terraform-ls" "serve"))))
(use-package flymake
  :defer t)

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
  :hook ((terraform-mode . terraform-format-on-save-mode))
  :config
  (setq terraform-format-on-save-mode t))

(provide 'init-prog)
;;; init-prog.el ends here
