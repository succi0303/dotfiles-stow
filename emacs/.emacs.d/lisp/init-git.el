;;; init-git.el --- Git integration configuration -*- lexical-binding: t -*-
;;; Commentary:
;; Git tools like magit and git-gutter

;;; Code:

(use-package git-commit-mode
  :mode "\\COMMIT_EDITMSG\\'")

(use-package git-modes
  :ensure t)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode +1))

(defun my/git-quick-commit-and-push ()
  "Quickly commit and push changes in the current Git repo with timestamped message."
  (interactive)
  (let* ((file (or (buffer-file-name) default-directory))
         (repo-dir (locate-dominating-file file ".git"))
         (timestamp (format-time-string "%Y-%m-%d %H:%M:%S")))
    (if repo-dir
        (let ((default-directory repo-dir))
          (shell-command "git add -A")
          (shell-command (format "git commit -m 'Auto backup: %s'" timestamp))
          (shell-command "git push"))
      (message "Not inside a Git repository!"))))

(global-set-key (kbd "C-c p") 'my/git-quick-commit-and-push)

(provide 'init-git)
;;; init-git.el ends here
