;;; init-doc.el --- Documenting support configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Documenting support
;;; Code:

;; markdown
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "pandoc"))

(provide 'init-doc)
;;; init-prog.el ends here
