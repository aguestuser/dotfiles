;;; package -- Summary
;;; Commentary:
;;; Code:

;; https://christian.kellner.me/2017/05/31/language-server-protocol-lsp-rust-and-emacs/

;; (use-package rust-mode
;;   :ensure t
;;   :mode "\\.rs\\'"
;;   :config (progn
;;             (setq rust-format-on-save t)
;;             (add-hook 'rust-mode-hook 'cargo-minor-mode)
;;             (add-hook 'rust-mode-hook #'lsp-rust-enable)
;;             (add-hook 'rust-mode-hook #'flycheck-mode)))

;; ;; (use-package lsp-mode :ensure t)

;; ;; (use-package lsp-rust
;; ;;   :ensure t
;; ;;   :config (with-eval-after-load 'lsp-mode
;; ;;             (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
;; ;;             (require 'lsp-rust)))

;; (use-package lsp-mode
;;   :ensure t
;;   :init (add-hook 'prog-mode-hook 'lsp-mode)
;;   :config
;;   (use-package lsp-flycheck
;;     :ensure f ; comes with lsp-mode
;;     :after flycheck))

;; (use-package lsp-rust
;;   :ensure t
;;   :after lsp-mode)


;; cf: http://julienblanchard.com/2016/fancy-rust-development-with-emacs/

(use-package rust-mode
  :ensure t
  :config (progn
            ;; misc
            (require 'smartparens-rust)
            (setq rust-format-on-save t)
            ;; keybindings
            (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
            ;; hooks
            (add-hook 'rust-mode-hook #'racer-mode)
            (add-hook 'rust-mode-hook 'cargo-minor-mode)
            (add-hook 'rust-mode-hook #'flycheck-mode)
            (add-hook 'rust-mode-hook #'flycheck-rust-setup)))


(use-package cargo :ensure t)

(use-package racer
  :ensure t
  :config (progn
            ;; activation
            (setq racer-cmd "~/.cargo/bin/racer")
            (setq racer-rust-src-path "~/-/code/rust/src")
            ;; docs
            (add-hook 'racer-mode-hook #'eldoc-mode)
            (define-key racer-mode-map (kbd "C-c C-c C-/") 'racer-describe)
            ;; code completion
            (add-hook 'racer-mode-hook #'company-mode)
            (setq company-tooltip-align-annotations t)
            (setq company-idle-delay 0.2) ;; autosuggest after 0.2 sec
            (setq company-minimum-prefix-length 1))) ;; autosuggest after 1 char


(use-package flycheck-rust
  :ensure t
  :config (setq flycheck-idle-change-delay 0.5)
  )


;;
