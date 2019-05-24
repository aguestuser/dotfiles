;;; package -- Configures LSP Mode
;;; Commentary: https://github.com/emacs-lsp/lsp-mode#installation
;;; Code:

;; borrowed from https://github.com/tigersoldier/company-lsp/issues/31#issue-311872828

(use-package lsp-mode
  :ensure t
  :init (progn
          (add-hook 'rust-mode-hook #'lsp)
          (add-hook 'c-mode-hook #'lsp)
          (add-hook 'js2-mode-hook #'lsp)
          (add-hook 'web-mode-hook #'lsp)
          (add-hook 'rjsx-mode-hook #'lsp)))


(use-package lsp-ui
  :ensure t
  :init (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references))

(use-package company
  :ensure t
  :diminish company-mode
  :init
  (setf company-backends '((company-files
                            company-keywords
                            company-capf
                            company-yasnippet)
                           (company-abbrev company-dabbrev)))
  (setf company-idle-delay 0.5)
  (setf company-tooltip-limit 10)
  (setf company-minimum-prefix-length 1)
  (setf company-echo-delay 0)
  (setf company-auto-complete nil)
  (add-hook 'after-init-hook #'global-company-mode))

(use-package company-lsp
  :ensure t
  :init
  (push 'company-lsp company-backends)
  (setf company-lsp-async t))

(use-package company-quickhelp
  :ensure t
  :after (company)
  :config (company-quickhelp-mode 1))

;; also see: https://github.com/emacs-lsp/lsp-mode#installation

;; (use-package lsp-mode
;;   :ensure t
;;   :commands lsp
;;   :init (add-hook 'prog-mode-hook 'lsp-mode)
;;   :config (progn

;;             (require 'company-lsp)
;;             (push 'company-lsp company-backends)

;;             (require 'lsp-ui)
;;             (add-hook 'lsp-mode-hook 'lsp-ui-mode)))

;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode)

;; (use-package company-lsp
;;   :ensure t
;;   :commands company-lsp)
