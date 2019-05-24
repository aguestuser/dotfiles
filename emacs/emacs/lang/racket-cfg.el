;;;;;;;;;;;;;;;;;
;; racket mode ;;
;;;;;;;;;;;;;;;;;

(add-hook 'racket-mode-hook
          '(lambda ()
             (define-key racket-mode-map (kbd "C-c r") 'racket-run)))
(add-hook 'racket-mode-hook
          '(lambda ()
             (define-key racket-mode-map (kbd "C-c t") 'racket-test)))

