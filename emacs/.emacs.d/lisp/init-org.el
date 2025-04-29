;;; init-org.el --- Org-mode configuration -*- lexical-binding: t -*-
;;; Commentary:
;; Org-mode setup: capture, agenda, todo, journal, visuals, etc.

;;; Code:

(use-package org
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode))
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   :map org-mode-map
   ("<RET>" . #'org-insert-heading-respect-content)
   ("C-c <RET>" . #'newline))
   ("C-x n s" . org-narrow-subtree)
   ("C-x n w" . widen)
   ("C-S-<up>" . org-metaup)
   ("C-S-<down>" . org-metadown)
   ("C-S-<right>" . org-metaright)
   ("C-S-<left>" . org-metaleft)
  :config
  (setq org-directory "~/org/"
        org-default-notes-file "~/org/inbox.org"
        org-startup-with-inline-images t
        org-image-visual-width nil
        org-clock-into-drawer t
        org-startup-folded 'content
        org-hide-leading-stars t
        org-ellipsis " ▼ "
        org-return-follows-link t)
  (setq org-hide-emphasis-markers t)
  ;; refile
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (setq org-outline-path-complete-in-steps t
        org-refile-use-outline-path 'file
        org-refile-allow-creating-parent-nodes 'confirm)
  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w@/!)" "IN-PROGRESS(i)" "|" "DONE(d!)" "CANCELLED(c@)")))
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "orange" :weight bold))
          ("WAITING" . (:foreground "gold" :weight bold))
          ("IN-PROGRESS" . (:foreground "deepskyblue" :weight bold))
          ("DONE" . (:foreground "forest green" :weight bold))
          ("CANCELLED" . (:foreground "gray" :weight bold))))
  ;; Capture templates
  (defun my/org-capure-inbox-to-top ()
    (goto-char (point-min))
    (while (looking-at-p "^#\\+")
      (forward-line))
    (unless (looking-at-p "^\\* ")
      (insert "\n")))
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file "todo.org")
           "* TODO %?\n  %U\n  %a" :prepend t)
	  ("a" "Anki flashcard" entry
	   (file "~/org/anki/inbox.org")
	   "* %^{front}\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: default-deck\n:ANKI_TAGS: %^{Tags}\n:END:\n%?" :prepend t)
	  ))
  ;; org-agenda
  (setq org-agenda-files (list org-directory)
        org-log-done 'time))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

;; org-journal
(use-package org-journal
  :init
  (setq org-journal-dir "~/org/journal/"
        org-journal-date-format "%Y-%m-%d"
        org-journal-file-format "%Y/%Y-%m-%d.org"
        org-journal-time-format ""
        org-journal-enable-agenda-integration t
        org-journal-file-type 'daily
        org-journal-file-header "#+TITLE: %Y-%m-%d Journal\n#+STARTUP: showall\n")
  :bind
  (("C-c j" . org-journal-new-entry)
   ("C-c J" . org-journal-new-date-entry)
   ("C-c 0" . calendar)
   :map org-journal-mode-map
   ("C-c <" . org-journal-previous-entry)
   ("C-c >" . org-journal-next-entry)))


(use-package org-anki
  :ensure t
  :after org)

(use-package company-org-block
  :ensure t
  :custom
  (company-org-block-edit-style 'auto)
  :hook ((org-mode . (lambda()
		      (setq-local company-backends '(company-org-block))
				  (company-mode +1)))))

(provide 'init-org)
;;; init-org.el ends here
