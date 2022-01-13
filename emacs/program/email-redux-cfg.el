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

;; to ensure mu4e is in loadpath ()for non-flatpak):
;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;; for flatpak:
;; load mu4e from the installation path.
;; yours might differ check with the Emacs installation
;; (add-to-list 'load-path "/var/run/host/usr/local/share/emacs/site-lisp/mu4e")
;; (require 'mu4e)


;; (shell-command-to-string (concat "/usr/local/bin/mu" " --version"))
;; (shell-command-to-string (concat "/opt/mu-1.6.10/mu/mu" " --version"))

(use-package mu4e
  :load-path  "/var/run/host/usr/local/share/emacs/site-lisp/mu4e/"
  :config

  (global-set-key (kbd "C-C C-3") 'mu4e)

  (setq mu4e-process (map 'list
                                   (lambda (x)
                                     (concat "flatpak-spawn --host " x))
                                   mu4e-process)))


  (setq
   ;; needed to find mu in flatpak
   ;; mu4e-mu-binary "/var/run/host/usr/local/bin/mu"
   ;; mu4e-mu-binary "var/run/host/usr/local/bin/mu"
   ;; mu4e-mu-binary "flatpak spawn --host mu"
   ;; use mu4e as our mail user agen
   mail-user-agent 'mu4e-user-agent
   ;; set maildir
   mu4e-maildir "~/.maildir"
   ;; allow for updating mail using 'U' in the main view:
   ;; mu4e-get-mail-command "torify mbsync -Va"
   mu4e-get-mail-command (concat (executable-find "torify") "mbsync -a")
 ;; delete buffers after sending mail
   message-kill-buffer-on-exit t
   ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
   ;; mu4e-sent-messages-behavior 'delete
   ;; refetch every 5 min
   mu4e-update-interval 300
   ;; convert html emails to text (dependency: `apt install python3-html2text`)
   ;; mu4e-html2text-command "html2markdown | grep -v '&nbsp_place_holder;'"
   ;; ask which key to sign messages with
   mm-sign-option 'guided
   ;; handy shortcuts
   mu4e-maildir-shortcuts
        '( ("aguestuser/Inbox"    . ?i)
           ("aguestuser/Sent"     . ?s)
           ("aguestuser/Trash"    . ?t)
           ("aguestuser/Archives" . ?a)))

  ;;Spell checking
  (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)

  ;; Configure sending mail.
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "/usr/bin/msmtp")

  ;; something about ourselves
  (setq
   user-mail-address "aguestuser@riseup.net"
   user-full-name  "Austin G."
   mu4e-compose-signature
   (concat
    "------\n"
    "<3"))


  ;; Use the correct account context when sending mail based on the from header.
  (setq message-sendmail-envelope-from 'header)
  (add-hook 'message-send-mail-hook 'choose-msmtp-account)


  ;; use 'fancy' non-ascii characters in various places in mu4e
  (setq mu4e-use-fancy-chars t)

  ;; save attachment to my desktop (this can also be a function)
  (setq mu4e-attachment-dir "~/Desktop")

  ;; attempt to show images when viewing messages
  (setq mu4e-view-show-images t))
