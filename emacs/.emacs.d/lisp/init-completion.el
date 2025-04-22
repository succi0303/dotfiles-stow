;;; init-completion.el --- Completion and minibuffer setup -*- lexical-binding: t -*-
;;; Commentary:
;; Enhances minibuffer completion and completion UI.

;;; Code:

(use-package vertico
  :init
  (vertico-mode 1)
  :custom
  (vertico-count 20)
  (vertico-cycle t)
  (vertico-resize nil))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package affe
  :ensure t)

(use-package consult
  :bind
  (("C-c h" . consult-history)
   ("C-c b" . consult-buffer)
   ("C-s" . consult-line)
   ("C-c g" . consult-goto-line)
   ("C-c h" . consult-org-heading)
   :map minibuffer-local-map
   ("C-r" . consult-history))
  :config
  (setq consult-line-start-from-top t)
  (setq register-preview-delay 0.5))

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package company
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
	 ("C-n" . company-select-next)
	 ("C-p" . company-select-previous)
	 ("C-s" . company-filter-candidates)
	 :map company-search-map
	 ("C-n" . company-select-next)
	 ("C-p" . company-select-previous))
  :config
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1
	company-tooltip-align-annotations t
	company-selection-wrap-around t
	company-show-numbers t)
  (with-eval-after-load 'eglot
    (add-hook 'eglot-managed-mode-hook
	      (lambda ()
		(set-local company-backends '(company-capf))))))

(use-package company-box
  :hook (company-mode . company-box-mode))

(provide 'init-completion)
;;; init-completion.el ends here
