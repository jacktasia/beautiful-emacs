
;; as org file examples...
;; https://raw.githubusercontent.com/dieggsy/dotfiles/master/emacs.d/init.org
;; http://mescal.imag.fr/membres/arnaud.legrand/misc/init.org

;; TODO: add a bash script that will HTTPS clone, make ln -s, and then run emacs command line to convert org -> el for the first time
;; TODO: add jack-util into it's own repo and then load the same way as pmdm


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
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'hy-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package pmdm
  :ensure t
  :recipe (:host github :repo "jacktasia/pmdm.el")
  :config
  (add-hook 'kill-emacs-hook 'pmdm-write-opened-files)
  (pmdm-load-files))

(use-package visual-regexp
  :ensure t
  :bind (("C-c r" . vr/replace)
	 ("C-c q" . vr/query-replace)))

(use-package whitespace-mode
  :bind (("C-c w" . whitespace-mode))
  :config
  (setq whitespace-line-column 60000))

(use-package expand-region
  :ensure t
  :bind (("C-c e" . er/mark-symbol)))

(use-package highlight-symbol
  :ensure t
  ;;:commands (highight-symbol-at-point)
  :bind (("s-p" . highlight-symbol-prev)
	 ("s-n" . highlight-symbol-next)
         ("M-p" . highlight-symbol-prev)
	 ("M-n" . highlight-symbol-next)
	 ("M-g h" . highlight-symbol-at-point))
  :config
;  (require 'highlight-symbol)
  (highlight-symbol-nav-mode 1))

(use-package fic-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'fic-mode)
  (add-hook 'go-mode-hook 'fic-mode)
  (add-hook 'python-mode-hook 'fic-mode)
  (add-hook 'javascript-mode-hook 'fic-mode)
  (add-hook 'js-mode-hook 'fic-mode)
  (add-hook 'web-mode-hook 'fic-mode)
  (add-hook 'java-mode-hook 'fic-mode)
  (add-hook 'emacs-lisp-mode-hook 'fic-mode)
  (add-hook 'web-mode-hook 'fic-mode)
  (add-hook 'js2-mode-hook 'fic-mode)
  (add-hook 'terraform-mode-hook 'fic-mode))

(use-package avy
  :ensure t
  :bind (("M-g l" . avy-goto-line)
	 ("M-g c" . avy-goto-char)
	 ("M-g w" . avy-goto-word-0)
	 ("M-g t" . avy-goto-char-timer))
  :config
  (setq avy-all-windows nil)
  (setq avy-keys (number-sequence ?a ?z)))

(use-package ws-butler 
  :ensure t
  :config
  (ws-butler-global-mode t))

(use-package smex
  :ensure t
  :config
  (smex-initialize))


(use-package key-chord
  :ensure t
  :recipe (:host github :repo "emacsmirror/key-chord")
  :config
  (key-chord-mode 1)
  (key-chord-define-global "fj" 'avy-goto-char))


(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (set-face-attribute 'anzu-mode-line nil :foreground "light green" :weight 'bold)
  (setq anzu-cons-mode-line-p nil)
  (setcar (cdr (assq 'isearch-mode minor-mode-alist))
	  '(:eval (anzu--update-mode-line))))


;; TODO: company-jedi company-tern company-anaconda company

;; TODO: uniqify

;; TODO:
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))




(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-dim-other-buffers-face ((t (:background "#424450"))))
 '(isearch ((((class color) (min-colors 89)) (:background "#ddbd78" :foreground "#3e4451"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "white"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "cyan"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "blue"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "dark violet"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "magenta"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "saddle brown"))))
 '(show-paren-match ((((class color) (min-colors 89)) (:background "#1f5582"))))
 '(swiper-line-face ((t (:inherit highlight :background "gray0" :foreground "gray100"))))
 '(vhl/default-face ((t (:inherit default :background "yellow2")))))

;; TODO: add all packages
;; TODO: add all packages config
;; TODO: add all built-in keybindings...
;; TODO: add in all jack-util.el code that is _still_ being used....

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

(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)
(setq cua-enable-cua-keys nil)
(cua-mode)
(if window-system
  (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend))
;; http://stackoverflow.com/a/25438277/24998

(global-subword-mode t)                                                       ;; for better deleting of parts of camalcase symbols
(global-linum-mode)

(defun display-startup-echo-area-message ()
  (message "~/.emacs loaded in %s!" (emacs-init-time)))

;;
;; end built-in config changes
;;







