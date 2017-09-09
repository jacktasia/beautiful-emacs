
;;;###autoload
(defun beautiful-backward-kill-line (arg)
  "removes all tabs/spaces on the front of the line regardless of where your cursor is"
  (interactive "p")
  (back-to-indentation)
  (kill-line 0))

;;;###autoload
(defun beautiful-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times. Does NOT add to kill ring."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

;;;###autoload
(defun beautiful-helm-projectile-ag-at-point ()
  (interactive)
  (let ((helm-ag-insert-at-point 'symbol))
    (helm-projectile-ag)))


;;;###autoload
(defun beautiful-company-move-up ()
  (interactive)
  (company-complete-common-or-cycle 1))

;;;###autoload
(defun beautiful-company-move-down ()
  (interactive)
  (company-complete-common-or-cycle -1))

(defun beautiful-insert-code-next-line (code)
  (move-end-of-line nil)
  (insert "\n")
  (beautiful-match-above-indentation)
  (insert code))

;;;###autoload
(defun beautiful-match-above-indentation ()
  (interactive)
  (let ((above-col (save-excursion
                     (previous-line)
                     (back-to-indentation)
                     (current-column)))
        (below-col (save-excursion
                     (next-line)
                     (back-to-indentation)
                     (current-column))))
    (move-beginning-of-line nil)
    (delete-horizontal-space)
    (insert-char (string-to-char " ") (max below-col above-col))))

;;;###autoload
(defun beautiful-debug-symbol-at-point ()
  (interactive)
  (let ((cur-symbol (thing-at-point 'symbol))
        (cur-ext (f-ext (buffer-file-name))))
    (cond
     ((string= cur-ext "py")
      (beautiful-insert-code-next-line (format "print(\'value of `%s`\', %s)" cur-symbol cur-symbol)))
     ((string= cur-ext "js")
      (beautiful-insert-code-next-line (format "console.log(\'value of `%s`\', %s);" cur-symbol cur-symbol))))))

;;;###autoload
(defun beautiful-git-blame-line ()
  (interactive)
  (let ((cmd_tmpl "git blame -L %s,+3 %s")
		(current_line (cadr (split-string (what-line) " "))))
	(shell-command (format cmd_tmpl current_line (buffer-file-name)))))

;;;###autoload
(defun beautiful-git-diff ()
  (interactive)
  (let* ((cmd_tmpl "git diff %s")
		(git_diff_cmd (format cmd_tmpl (buffer-file-name)))
		(file_name (car (last (split-string (buffer-file-name) "/"))))
		(buffer_title (concat "DIFF " file_name " on " (format-time-string "%D @ %H:%M:%S"))))
	(shell-command git_diff_cmd)
	(with-current-buffer (get-buffer "*Shell Command Output*")
		(rename-buffer buffer_title)
		(diff-mode))))

;; http://emacs.stackexchange.com/a/2302
;;;###autoload
(defun beautiful-eval-buffer ()
  "Execute the current buffer as Lisp code.
Top-level forms are evaluated with `eval-defun' so that `defvar'
and `defcustom' forms reset their default values."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (not (eobp))
      (forward-sexp)
      (eval-defun nil)))
  (message "%s eval'd" (buffer-file-name)))

; based off of http://stackoverflow.com/a/10364547/24998
;;;###autoload
(defun beautiful-new-scratch ()
  "open up a new scratch buffer"
  (interactive)
  (switch-to-buffer (generate-new-buffer "*scratch*")))


;;;###autoload
(defun beautiful-reload-config ()
  "Reload the config."
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/init.org")))


; http://stackoverflow.com/a/3417473/24998 adding confirmation
;;;###autoload
(defun beautiful-kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (when (y-or-n-p "Kill all other buffers? ")
      (mapc 'kill-buffer
            (delq (current-buffer)
                  (remove-if-not 'buffer-file-name (buffer-list))))))

;;;###autoload
(defun beautiful-kill-all-buffers ()
    "Kill all buffers."
    (interactive)
    (when (y-or-n-p "Kill all buffers? ")
      (mapc 'kill-buffer (buffer-list))))
