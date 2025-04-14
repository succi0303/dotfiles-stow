;;; init-git.el --- Git integration configuration -*- lexical-binding: t -*-
;;; Commentary:
;; Git tools like magit and git-gutter

;;; Code:

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

(provide 'init-git)
;;; init-git.el ends here
