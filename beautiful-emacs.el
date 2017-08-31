


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

(use-package zerodark-theme :ensure t)

;; TODO: add all packages
;; TODO: add all packages config
;; TODO: add all built-in keybindings...

;;
;; start built-in config changes
;;
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq uniquify-min-dir-content 3)
;; https://github.com/emacs-mirror/emacs/blob/0537943561a37b54467bec19d1b8afbeba8e1e58/lisp/uniquify.el#L107
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)                ;; or "forward"
(setq tramp-default-method "scpx")
(setq clean-buffer-list-delay-general 7)
(show-paren-mode t)
(add-to-list 'auto-mode-alist '("\\.el\\'" . emacs-lisp-mode))
(setq org-log-done t)                                                         ;; show done time when marking a todo done
(defalias 'yes-or-no-p 'y-or-n-p)                                             ;; don't require full "yes" for confirms
(tool-bar-mode -1)                                                            ;; get rid of tool bar
(setq inhibit-startup-message t)                                              ;; git rid of startup page
(menu-bar-mode 0)                                                             ;; no menu bar
(setq resize-mini-windows t)                                                  ;; let mini buffer resize
(setq make-backup-files nil)                                                  ;; no backup files
(setq-default c-electric-flag nil)                                            ;; do not get fancy with () {} ?
(setq whitespace-line-column 60000)                                           ;; do not turn line purple if "too long"
(blink-cursor-mode 0)                                                         ;; no blinking cursor
(setq initial-scratch-message "")                                             ;; no scratch message
(electric-indent-mode 0)                                                      ;; stop electric mode from being too smart for its own good
(global-hl-line-mode 1)
;; (global-auto-revert-mode 1)                                                ;; so git branch changes and checkouts update the mode line (slow, so disabled)
(setq auto-revert-check-vc-info nil)
(setq confirm-kill-emacs 'y-or-n-p)
(setq message-log-max t)                                                      ;; If t, log messages but don't truncate the buffer when it becomes large.
(setq-default cursor-in-non-selected-windows nil)                             ;;
(setq column-number-mode t)                                                   ;;
(global-subword-mode t)                                                       ;; 


(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)
(setq cua-enable-cua-keys nil)
(cua-mode)
(if window-system
  (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend))
;; http://stackoverflow.com/a/25438277/24998
(global-linum-mode)

(defun display-startup-echo-area-message ()
  (message "~/.emacs loaded in %s!" (emacs-init-time)))

;;
;; end built-in config changes
;;







