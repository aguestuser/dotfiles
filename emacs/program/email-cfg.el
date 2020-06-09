
;;;;;;;;;;
;; mu4e ;;
;;;;;;;;;;

;; sources:
;; - https://www.djcbsoftware.nl/code/mu/mu4e/Gmail-configuration.html#Gmail-configuration
;; - https://notanumber.io/2016-10-03/better-email-with-mu4e/
;; - https://github.com/FrancisMurillo/.emacs.d#mu4e

;; dependencies:
;; - sudo apt install offlineimap msmtp libgmime-3.0-dev libxapian-dev guile-2.0-dev html2text xdg-utils libwebkitgtk-3.0-dev python3-html2text
;; - mu43 from source: https://www.djcbsoftware.nl/code/mu/mu4e/Installation.html

;; necessary config files (see ../../misc/):
;; - ~/.offlineimaprc
;; - ~/.msmtprc


(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'org-mu4e)

(use-package mu4e
  :config

  (global-set-key (kbd "C-C C-3") 'mu4e)

  (setq
   ;; use mu4e as our mail user agen
   mail-user-agent 'mu4e-user-agent
   ;; set maildir
   mu4e-maildir "~/Maildir"
   ;; allow for updating mail using 'U' in the main view:
   mu4e-get-mail-command "offlineimap"
 ;; delete buffers after sending mail
   message-kill-buffer-on-exit t
   ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
   ;; mu4e-sent-messages-behavior 'delete
   ;; refetch every 5 min
   mu4e-update-interval 300
   ;; convert html emails to text (dependency: `apt install python3-html2text`)
   mu4e-html2text-command "html2markdown | grep -v '&nbsp_place_holder;'"
   ;; ask which key to sign messages with
   mm-sign-option 'guided
   ;; handy shortcuts
   mu4e-maildir-shortcuts
        '( ("aguestuser/INBOX"    . ?i)
           ("aguestuser/Sent"     . ?s)
           ("aguestuser/Trash"    . ?t)
           ("aguestuser/Archives" . ?a)))

  ;;Spell checking
  (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)

  ;; Configure sending mail.
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "/usr/bin/msmtp")
 
  ;; load account data (kept in separate file to enable secure secret management -- see ./email-accounts-example.el for example)
  (load "./email-accounts.el")

  ;; determine which account context I am in based  on the folder in my maildir the email is located in.
  (defun mu4e-message-maildir-matches (msg rx)
    (when rx
      (if (listp rx)
	  ;; If rx is a list, try each one for a match
	  (or (mu4e-message-maildir-matches msg (car rx))
	      (mu4e-message-maildir-matches msg (cdr rx)))
	;; Not a list, check rx
	(string-match rx (mu4e-message-field msg :maildir)))))

  ;; Use the correct account context when sending mail based on the from header.
  (setq message-sendmail-envelope-from 'header)
  (add-hook 'message-send-mail-hook 'choose-msmtp-account)

  ;;;;;;;;;;;;;;;;;;;;;
  ;; org-mode plugin ;;
  ;;;;;;;;;;;;;;;;;;;;;
  
  ;;store link to message if in header view, not to header query
  (setq org-mu4e-link-query-in-headers-mode nil)
  ;; hitting C-c c t generates a todo item that contains a link to the email you are currently viewing.
  (global-set-key (kbd "C-C c") 'org-capture)
  (setq org-capture-templates
        '(("t" "todo" entry (file+headline "~/-/notes/todo.org" "Tasks")
           "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))
  )

