;;;;;;;;;;;;;;;;
;; ruby/rails ;;
;;;;;;;;;;;;;;;;

(use-package ruby-mode :ensure t)
(use-package rspec-mode :ensure t)
(use-package robe :ensure t)
(use-package rvm :ensure t)
(use-package projectile-rails :ensure t)

;; ensure rvm loads correct ruby version
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

;; enable projectile-rails
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(add-hook 'projectile-mode-hook 'projectile-rails-mode)
(add-hook 'ruby-mode-hook 'projectile-rails-on)
(add-hook 'ruby-mode-hook 'projectile-rails-mode)

;; enable robe-mode
(add-hook 'ruby-mode-hook 'robe-mode) ; add hook

(eval-after-load 'company
  '(push 'company-robe company-backends)) ; company mode
(add-hook 'robe-mode-hook 'ac-robe-setup) ; auto-complete


;; enable launching rspec from dired
(add-hook 'dired-mode-hook 'rspec-dired-mode)

;; enable inf-ruby (repl)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(eval-after-load 'inf-ruby
  '(define-key inf-ruby-minor-mode-map
     (kbd "C-c C-s") 'inf-ruby-console-auto))

;; add rspec-mode snippets
(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

;; disable expand-snippet class skeletons
(setq projectile-rails-expand-snippet nil)

;; highlight whitespace, remove on save
(add-hook 'ruby-mode-hook 'whitespace-mode)


(use-package whitespace-cleanup-mode
  :ensure t
  :init (progn (require 'whitespace-cleanup-mode))
  :config (progn (add-hook 'ruby-mode-hook 'whitespace-cleanup-mode)))

;; hide/show blocks
(add-hook 'ruby-mode-hook
          (lambda () (hs-minor-mode)))
(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
                `(ruby-mode
                  ,(rx (or "def" "class" "module" "describe" "do" "{" "[")) ; Block start
                  ,(rx (or "}" "]" "end"))           ; Block end
                  ,(rx (or "#" "=begin"))            ; Comment start
                  ruby-forward-sexp nil)))
;; (global-set-key (kbd "C-c h") 'hs-hide-block)
;; (global-set-key (kbd "C-c s") 'hs-show-block)

;; minitest
;; (use-package minitest
;;   :ensure t
;;   :config (progn (add-hook 'ruby-mode-hook 'minitest-mode)
;;                  (eval-after-load 'minitest'(minitest-install-snippets))))

;; eruby stuff

;; (sp-with-modes '(web-mode)                                                                                                           
;;   (sp-local-pair "%" "%"                                                                                                   :unless '(sp-in-string-p)          
;;                  :post-handlers '(((lambda (&rest _ignored)                    
;;                                      (just-one-space)                          
;;                                      (save-excursion (insert " ")))            
;;                                    "SPC" "=" "#"))) 
;;   (sp-local-pair "<% "  " %>" :insert "C-c %")      
;;   (sp-local-pair "<%= " " %>" :insert "C-c =")      
;;   (sp-local-pair "<%# " " %>" :insert "C-c #")      
;;   (sp-local-tag "%" "<% "  " %>")                   
;;   (sp-local-tag "=" "<%= " " %>")                   
;;   (sp-local-tag "#" "<%# " " %>"))
