;;; init-prog.el --- Programming support configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Language support, LSP (eglot), and code editing enhancements.
;;; Code:

(use-package flymake
  :defer t)

(use-package terraform-mode
  :custom (terraform-indent-level 4))

(provide 'init-prog)
;;; init-prog.el ends here
