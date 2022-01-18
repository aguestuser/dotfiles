;;;;;;;;;;
;; mu4e ;;
;;;;;;;;;;

;; sources:
;; - https://www.djcbsoftware.nl/code/mu/mu4e/Gmail-configuration.html#Gmail-configuration
;; - https://notanumber.io/2016-10-03/better-email-with-mu4e/
;; - https://github.com/FrancisMurillo/.emacs.d#mu4e

;; dependencies:
;; - sudo apt install msmtp libgmime-3.0-dev libxapian-dev guile-2.0-dev html2text xdg-utils libwebkitgtk-3.0-dev python3-html2text
;; - mu4e from source: https://www.djcbsoftware.nl/code/mu/mu4e/Installation.html

;; necessary config files (see ../../misc/):
;; - ~/.offlineimaprc
;; - ~/.msmtprc

;; to ensure mu4e is in loadpath
;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;; (require 'mu4e)


(use-package mu4e
  ;; to ensure mu4e is in loadpath
  :load-path "/usr/local/share/emacs/site-lisp/mu4e/"
  :config

  ;; invoke to launch mu4e from anywhere in emacs:
  (global-set-key (kbd "C-C C-3") 'mu4e)

  ;;;;;;;;;;;;;;;;;;;;;;;;
  ;; hooks
  ;;;;;;;;;;;;;;;;;;;;;;;;

  ;;Spell checking
  (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)
  (add-hook 'mu4e-compose-mode-hook 'mml-secure-message-encrypt-pgpmime)
  (add-hook 'mu4e-compose-mode-hook 'mml-secure-message-sign-pgpmime)
  ;; (add-hook 'message-send-mail-hook 'choose-msmtp-account)


  (setq
   ;; use mu4e as our mail user agent
   mail-user-agent 'mu4e-user-agent

   ;;;;;;;;;;;;;;;;;;;;
   ;; get/send configs
   ;;;;;;;;;;;;;;;;;;;;

   ;; retrieve mail w/ mbsync over tor (see ~/.mbsyrncrc for configs)
   mu4e-get-mail-command "torify mbsync -aV"
   ;; refetch every 5 min
   mu4e-update-interval 300

   ;; send mail with smtp mail
   ;; - for configs see: see `~/.msmtprc for configs',
   ;; message-send-mail-function 'smtpmail-send-it

   ;; - for tips see: https://tushartyagi.com/blog/configure-mu4e-and-msmtp/
   sendmail-program "/usr/bin/msmtp"
   send-mail-function 'smtpmail-send-it
   message-sendmail-f-is-evil t
   message-sendmail-extra-arguments '("--read-envelope-from")
   message-send-mail-function 'message-send-mail-with-sendmail

   ;; Use the correct account context when sending mail based on the from header.
   ;; message-sendmail-envelope-from 'header
   ;; don't copy messages to `Sent` dir -- maybe messes up risup sync?
   ;; mu4e-sent-messages-behavior 'delete

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; account configuration
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;

   mu4e-maildir        "~/-/.maildir"
   user-mail-address   "aguestuser@torproject.org"
   user-full-name      "Austin G."

   mu4e-sent-folder    "/aguestuser/Sent"
   mu4e-drafts-folder  "/aguestuser/Drafts"
   mu4e-trash-folder   "/aguestuser/Trash"
   mu4e-refile-folder  "/aguestuser/Archives"
   mu4e-attachment-dir "~/Downloads"

   ;; ;; shortcuts to directories
   mu4e-maildir-shortcuts
   '(("/aguestuser/Inbox"    . ?i)
     ("/aguestuser/Sent"     . ?s)
     ("/aguestuser/Drafts"   . ?d)
     ("/aguestuser/Archives" . ?a)
     ("/aguestuser/Trash"    . ?t))

   ;;;;;;;;;;;;;;;
   ;; security
   ;;;;;;;;;;;;;;;
   ;; delete buffers after sending mail
   message-kill-buffer-on-exit t
   ;; for sign-only mode to not break
   mml-secure-openpgp-sign-with-sender t
   mml-secure-openpgp-encrypt-to-self t
   ;; mm-sign-option 'guided
   ;; convert html emails to text (dependency: `apt install python3-html2text`)
   ;; mu4e-html2text-command "html2markdown | grep -v '&nbsp_place_holder;'"

   ;;;;;;;;;;;;;
   ;; functionality
   ;;;;;;;;;;;;


   ;;;;;;;;;;;;;;
   ;; aesthetics
   ;;;;;;;;;;;;;;;
   mu4e-use-fancy-chars t
   mu4e-compose-signature (concat "/a/")
  ))

(use-package mu4e-alert
  :ensure t
  :after mu4e
  :init
  (setq mu4e-alert-interesting-mail-query "flag:unread maildir:/aguestuser/Inbox ")
  (mu4e-alert-enable-mode-line-display)
  (defun gjstein-refresh-mu4e-alert-mode-line ()
    (interactive)
    (mu4e~proc-kill)
    (mu4e-alert-enable-mode-line-display)
    )
  (run-with-timer 0 60 'gjstein-refresh-mu4e-alert-mode-line))
