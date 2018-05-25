;;;;;;;;;;;
;; magit ;;
;;;;;;;;;;;

(use-package magit :ensure t)
(use-package magit-gh-pulls :ensure t)
(use-package diff-hl :ensure t)

(require 'magit-gh-pulls)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

(setq auto-mode-alist (delete '("git-rebase-todo" . rebase-mode)
                              auto-mode-alist))
