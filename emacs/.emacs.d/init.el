;;; init.el --- Entry point -*- lexical-binding: t -*-
;;; Commentary:
;; Emacs init entry point. Loads modules from lisp/.

;;; Code:

;; Set UTF-10 and suppress startup screen
(set-language-environment "UTF-8")
(setq inhibit-startup-screen t)

;; Set up custom file
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; Add lisp/ to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Load modules
(require 'init-core)
(require 'init-ui)
(require 'init-package)
(require 'init-completion)
(require 'init-org)
(require 'init-git)
(require 'init-prog)

;;; init.el ends here
