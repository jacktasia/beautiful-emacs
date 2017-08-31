(setq make-backup-files nil)       ;; no backup files!

;; bootstrap straight.el package manager
(let ((bootstrap-file (concat user-emacs-directory "straight/bootstrap.el"))
      (bootstrap-version 2))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; bootstrap `use-package` via straight so it is overloaded to use straight.el
(straight-use-package 'use-package)

(use-package dumb-jump :ensure t)

(use-package zerodark-theme 
  :ensure t)


(defun display-startup-echo-area-message ()
  (message "~/.emacs loaded in %s!" (emacs-init-time)))



