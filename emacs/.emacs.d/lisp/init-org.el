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
   ("C-x n s" . org-narrow-subtree)
   ("C-x n w" . widen)
   :map org-mode-map
   ("<RET>" . #'org-insert-heading-respect-content)
   ("C-<RET>" . #'newline))
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
  (setq org-capture-templates
        '(("i" "Inbox" entry
           (file+headline "inbox.org" "INBOX")
           "* %?")
          ("t" "Todo" entry
           (file+headline "tasks.org" "TASKS")
           "* TODO %?\n  %U\n  %a")
          ("n" "Note" entry
           (file+headline "notes.org" "NOTES")
           "* %?\n  %U\n  %a")))
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
        org-journal-file-format "%Y-%m.org"
        org-journal-time-format ""
        org-journal-enable-agenda-integration t
        org-journal-file-type 'monthly
        org-journal-header "#+TITLE: %Y-%m Journal\n#+STARTUP: fold\n")
  :bind
  ("C-c j" . org-journal-new-entry))

(provide 'init-org)
;;; init-org.el ends here
