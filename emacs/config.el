;; ~/.emacs.d/personal/cfg.el

;;;;;;;;;;;;;;;;;;;;;;
;; custom variables ;;
;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/personal")
(load "custom-vars.el") ;; ONLY ONE OF THESE PER INIT FILE!!!

;;;;;;;;;
;; env ;;
;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/personal/env")

(load "package-cfg.el")

(load "editing-cfg.el")
(load "navigation-cfg.el")
(load "shell-cfg.el")
(load "ui-cfg.el")
(load "opening-cfg.el")
(load "evil-cfg.el")


;;;;;;;;;;;
;; langs ;;
;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/personal/lang")
(load "clojure-cfg.el")
(load "golang-cfg.el")
(load "javascript-cfg.el")
(load "lsp-cfg.el")
(load "markdown-cfg.el")
(load "python-cfg.el")
(load "racket-cfg.el")
(load "ruby-cfg.el")
(load "rust-cfg.el")

;;;;;;;;;;;;;
;; program ;;
;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/personal/program")

(load "magit-cfg.el")
(load "notmuch-cfg.el")
(load "org-mode-cfg.el")
