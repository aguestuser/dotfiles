
;;;;;;;;;;;;;;;;;;;; 
;; email accounts ;;
;;;;;;;;;;;;;;;;;;;; 

;; This sets up my two different context for foo@example.com and bar@example.com
(setq mu4e-contexts
      `( ,(make-mu4e-context
	   :name "foo"
	   :enter-func (lambda () (mu4e-message "Switch to foo context"))
	   :match-func (lambda (msg)
			 (when msg
			   (mu4e-message-maildir-matches msg "^/foo")))
	   :leave-func (lambda () (mu4e-clear-caches))
	   :vars '((user-mail-address     . "foo@example.com")
		   (user-full-name        . "foo")
		   (mu4e-sent-folder      . "/foo/Sent")
		   (mu4e-drafts-folder    . "/foo/Drafts")
		   (mu4e-trash-folder     . "/foo/Trash")
		   (mu4e-refile-folder    . "/foo/Archives")))
	 ,(make-mu4e-context
	   :name "bar"
	   :enter-func (lambda () (mu4e-message "Switch to  context"))
	   :match-func (lambda (msg)
			 (when msg
			   (mu4e-message-maildir-matches msg "^/bar")))
	   :leave-func (lambda () (mu4e-clear-caches))
	   :vars '((user-mail-address     . "bar@example.com")
		   (user-full-name        . "bar")
		   (mu4e-sent-folder      . "/bar/Sent")
		   (mu4e-drafts-folder    . "/bar/Drafts")
		   (mu4e-trash-folder     . "/bar/Trash")
		   (mu4e-refile-folder    . "/bar/Archives")))))

;; Choose account label to feed msmtp -a option based on From header
;; in Message buffer; This function must be added to
;; message-send-mail-hook for on-the-fly change of From address before
;; sending message since message-send-mail-hook is processed right
;; before sending message.
(defun choose-msmtp-account ()
  (if (message-mail-p)
      (save-excursion
	(let*
	    ((from (save-restriction
		     (message-narrow-to-headers)
		     (message-fetch-field "from")))
	     (account
	      (cond
	       ((string-match "foo@example.com" from) "foo")
	       ((string-match "bar@example.com" from) "bar"))))
	  (setq message-sendmail-extra-arguments (list '"-a" account))))))
