;;; init.el --- Entry point -*- coding: utf-8 ; lexical-binding: t -*-
;;; Commentary:
;; Emacs init entry point. Loads modules from lisp/.

;;; Code:

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;; Set UTF-10 and suppress startup screen
(set-language-environment "UTF-8")
(setq inhibit-startup-screen t)

;; Pacakge manager
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Add lisp/ to load-path & modules
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-core)
(require 'init-ui)
;(require 'init-package)
(require 'init-completion)
(require 'init-org)
(require 'init-git)
(require 'init-prog)
(require 'init-doc)
(require 'init-shell)

;;; init.el ends here
