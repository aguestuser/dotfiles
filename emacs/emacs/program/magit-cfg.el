;;;;;;;;;;;
;; magit ;;
;;;;;;;;;;;

(use-package magit :ensure t)
(use-package diff-hl :ensure t)

(setq auto-mode-alist (delete '("git-rebase-todo" . rebase-mode)
                              auto-mode-alist))
