;;;;;;;;;;;;;
;; notmuch ;;
;;;;;;;;;;;;;

(use-package notmuch :ensure t)
(require 'notmuch)

;; (use-package notmuch-crypto-process-mime :ensure t)
;; (require 'notmuch-crypto-process-mime)

;; decrypt messages
(setq notmuch-crypto-process-mime t)

;; sign and encrypte messages by default
(add-hook 'message-setup-hook 'mml-secure-message-encrypt-pgpmime)
;;(add-hook 'message-setup-hook 'mml-secure-message-sign-pgpmime)


;; auto-complete w/ helm
(setq notmuch-address-selection-function
      (lambda (prompt collection initial-input)
        (completing-read prompt (cons initial-input collection) nil t nil 'notmuch-address-history)))

;; (use-package smptmail :ensure t)
;; (require 'smtpmail)

;; ;; (use-package starttls :ensure t)
;; ;; (require 'starttls)

;; (setq smtpmail-starttls-credentials '(("riseup.net" 587 nil nil))
;;       ;; smtpmail-auth-credentials (expand-file-name "~/.passwordstoare/accounts/riseup/austin.guest")
;;       smtpmail-default-smtp-server "riseup.net"
;;       smtpmail-smtp-server "riseup.net"
;;       smtpmail-smtp-service 587)

;; (setq message-send-mail-function 'smtpmail-send-it)
