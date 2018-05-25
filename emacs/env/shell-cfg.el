;;;;;;;;;;;
;; shell ;;
;;;;;;;;;;;

;; use shell env vars
(use-package exec-path-from-shell :ensure t)
(require 'exec-path-from-shell)
;; (exec-path-from-shell-copy-env "SSH_AGENT_PID")
;; (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
;; (exec-path-from-shell-initialize)

;; another way:
;; https://github.com/purcell/exec-path-from-shell
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize)
;;   (exec-path-from-shell-copy-envs
;;    '("PATH")))


;; multi-term
(use-package multi-term :ensure t)
(global-set-key (kbd "C-c m m") 'multi-term)
(add-hook 'term-mode-hook
          '(lambda ()
             (define-key term-raw-map (kbd "C-y") 'term-paste)
             (define-key term-raw-map (kbd "C-c m n") 'multi-term-next)
             (define-key term-raw-map (kbd "C-c m p") 'multi-term-prev)))

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; No need for ~ files when editing
(setq create-lockfiles nil)
