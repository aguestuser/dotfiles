;;;;;;;;;;;;;
;; editing ;;
;;;;;;;;;;;;;

;; snippets
(use-package yasnippet :ensure t)
(use-package yasnippet-snippets :ensure t)

;; pair completion
(electric-pair-mode 1)
(smartparens-global-mode)
(setq electric-pair-pairs '((?\" . ?\")(?\{ . ?\}))) ;; include {} and "" as pairs

;; tabbing
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default js-indent-level 2)

(fset 'indent-riffle [tab down])
(define-key global-map "\C-z" 'indent-riffle)

;; code-folding
;; (hs-minor-mode t) ;;<- won't work by default in fundamental mode
;; (global-set-key (kbd "C-c <up>") 'hs-show-block)
;; (global-set-key (kbd "C-c <down>") 'hs-hide-block)
;; (global-set-key (kbd "C-c C-<up>") 'hs-show-all)
;; (global-set-key (kbd "C-c C-<down>") 'hs-hide-all)

;; multiple cursors
(use-package multiple-cursors :ensure t)
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-M-J") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M->") 'mc/mark-all-like-this)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOTE: disabling autocopmlete, snippets, and tern for debugging rust w/ lsp setup ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; autocomplete
;; (use-package auto-complete :ensure t)
;; (require 'auto-complete)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.c/ac-dict")
;; (ac-config-default)

;; (use-package company :ensure t)
;; (add-hook 'after-init-hook 'global-company-mode)

;; (use-package tern :ensure t)
;; (use-package tern-auto-complete :ensure t)
;; (use-package company-tern :ensure t)

;; snippets
;; (use-package yasnippet :ensure t)
;; (require 'yasnippet)
;; (defun ac-yasnippet-mode-setup ()
;;   "Append yasnippets as a source to ac-sources."
;;   (setq ac-sources (append '(ac-source-yasnippet) ac-sources)))
;; (add-hook 'auto-complete-mode-hook 'ac-yasnippet-mode-setup)

;; syntax-checking
;; (require 'flycheck)
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; regexp-builder tweaks
(use-package re-builder :ensure t)
(require 're-builder)
(setq reb-re-syntax 'string)

;; tern (for autocomplete)

;; (use-package tern :ensure t)
;; (use-package tern-auto-complete :ensure t)

;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))
;; (add-hook 'web-mode-hook (lambda () (tern-mode t)))

;; (eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

;; (defun delete-tern-process ()
;;   (interactive)
;;   (delete-process "Tern"))


;; incrementing numbers
;; https://www.emacswiki.org/emacs/IncrementNumber

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0-9")
  (or (looking-at "[0-9]+")
      (error "No number at point"))
  (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))
