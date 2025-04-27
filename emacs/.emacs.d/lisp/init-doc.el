;;; init-doc.el --- Documenting support configuration -*- lexical-binding: t; -*-
;;; Commentary:
;; Documenting support
;;; Code:

;; markdown
(use-package markdown-mode
  :mode ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "pandoc"))

;; skk
(use-package ddskk
  :ensure t
  :bind (("C-x j" . skk-mode))
  :hook ((skk-mode . (lambda()
		       (require 'context-skk))))
  :init
  (setq skk-user-directory "~/.ddskk")
  (setq default-input-method "japanese-skk")
  (setq skk-start-henkan-with-inline 'ask)
  (setq skk-sticky-key ";")
  (setq skk-use-color-cursor t)
  (setq skk-use-look t)
  (setq skk-dcomp-activate t)
  (setq skk-dcomp-multiple-activate t)
  (setq skk-auto-okuri-process t)
  (setq skk-save-jisyo-instantly t)
  (setq skk-isearch-start-mode 'latin))

(provide 'init-doc)
;;; init-prog.el ends here
