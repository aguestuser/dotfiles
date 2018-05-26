;;;;;;;;;;;;;;;;;;;;;
;; Javascript Mode ;;
;;;;;;;;;;;;;;;;;;;;;

(use-package nodejs-repl :ensure t) ;; node repl
(use-package rjsx-mode :ensure t) ;; new and improved major mode for jsx
(use-package js-comint :ensure t) ;; run js in inferior process window
(use-package flycheck-flow :ensure t) ;; flow integration w/ flycheck
(use-package js-doc :ensure t) ;; javascript JSDOC
;; (use-package react-snippets :ensure t)
;; (use-package ac-js2 :ensure t)
;; (use-package web-mode :ensure t)

;; use rjsx-mode with .js files
(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))

;; enable JSDOC support when in js2-mode
(add-hook 'rjsx-mode-hook
          #'(lambda ()
              (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
              (define-key js2-mode-map "@" 'js-doc-insert-tag)))

;; Note: since rjsx-mode is an extension of js2-mode, we can still
;; set js2-mode variables

;; set js2-mode variables
(setq js-basic-indent 2)
(setq-default js2-basic-indent 2)
(setq-default js2-basic-offset 2)
(setq-default js2-auto-indent-p t)
(setq-default js2-cleanup-whitespace t)
(setq-default js2-enter-indents-newline t)
(setq-default js2-global-externs "jQuery $")
(setq-default js2-indent-on-enter-key t)
(setq-default js2-mode-indent-ignore-first-tab t)
(setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))

;; auto-completion
;; (add-hook 'js2-mode-hook 'ac-js2-mode)

;; disable syntax checking in js2-mode
(setq-default js2-mode-show-parse-errors nil)
(setq-default js2-mode-show-strict-warnings nil)

;;;;;;;;;;;;
;; eslint ;;
;;;;;;;;;;;;

;; disable jshint
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; find linters in node_modules as opposed to global
(defun use-js-executables-from-node-modules ()
  "Set executables of JS checkers from local node modules."
  (-when-let* ((file-name (buffer-file-name))
               (root (locate-dominating-file file-name "node_modules"))
               (module-directory (expand-file-name "node_modules" root)))
    (pcase-dolist (`(,checker . ,module) '((javascript-jshint . "jshint")
                                           (javascript-eslint . "eslint")
                                           (javascript-jscs   . "jscs")))
      (let ((package-directory (expand-file-name module module-directory))
            (executable-var (flycheck-checker-executable-variable checker)))
        (when (file-directory-p package-directory)
          (set (make-local-variable executable-var)
               (expand-file-name (concat "bin/" module ".js")
                                 package-directory)))))))
;; find eslint in node_modules upon loading flycheck
(add-hook 'flycheck-mode-hook #'use-js-executables-from-node-modules)

;; use eslint with web-mode
(flycheck-add-mode 'javascript-eslint 'rjsx-mode)

;;;;;;;;;;
;; Flow ;;
;;;;;;;;;;

;; assumes you have run instructions here:  https://github.com/flowtype/flow-for-emacs
(load-file "~/.emacs.d/personal/lang/flow-for-emacs/flow.el")

;; use flow from node_modules instead of global
(defun use-flow-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (flow (and root
                    (expand-file-name "node_modules/flow-bin/vendor/flow"
                                      root))))
    (when (and flow (file-executable-p flow))
      (setq-local flycheck-javascript-flow-executable flow))))
(add-hook 'flycheck-mode-hook #'use-flow-from-node-modules)

(flycheck-add-next-checker 'javascript-flow 'javascript-eslint)

;;;;;;;;;;;
;; Tests ;;
;;;;;;;;;;;
;; mocha test runner
(use-package mocha :ensure t)
(add-hook 'rjsx-mode-hook (local-set-key (kbd "M-RET") 'mocha-test-at-point))


;;;;;;;;;;;;;;;;
;; formatting ;;
;;;;;;;;;;;;;;;;

;; Place warning font around TODO and others:
(font-lock-add-keywords 'js2-mode
                        '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
                           1 font-lock-warning-face t)))

;; code folding
(add-hook 'js2-mode-hook
          (lambda ()
            ;; Scan the file for nested code blocks
            (imenu-add-menubar-index)
            ;; Activate the folding mode
            (hs-minor-mode t)))

;; wrap in html tag
(defun wrap-in-html-tag (start end)
  "Wraps the selected text or the point with a tag"
  (interactive "r")
  (let (string)
    (if mark-active
        (list (setq string (buffer-substring start end))
              (delete-region start end)))
    (yas-expand-snippet (point)
                        (point)
                        (concat "<${1:p}>" string "$0</${1:$(replace-regexp-in-string \" .*\" \"\" text)}>"))))

(add-hook 'web-mode-hook
          '(lambda ()
             (local-set-key "\C-t" 'wrap-in-html-tag)))

;;;;;;;;;;;;;;
;; web mode ;;
;;;;;;;;;;;;;;

;; ;; basic configs
;; (defun config-web-mode ()
;;   "Hooks for Web mode."
;;   (setq web-mode-markup-indent-offset 2)
;;   (setq web-mode-css-indent-offset 2)
;;   (setq web-mode-code-indent-offset 2)
;;   (setq web-mode-style-padding 1)
;;   (setq web-mode-script-padding 1)
;;   (setq web-mode-block-padding 0))
;; (add-hook 'web-mode-hook  'config-web-mode)

;; ;; tag-wrapping
;; (defun wrap-in-html-tag (start end)
;;   "Wraps the selected text or the point with a tag"
;;   (interactive "r")
;;   (let (string)
;;     (if mark-active
;;         (list (setq string (buffer-substring start end))
;;               (delete-region start end)))
;;     (yas-expand-snippet (point)
;;                         (point)
;;                         (concat "<${1:p}>" string "$0</${1:$(replace-regexp-in-string \" .*\" \"\" text)}>"))))

;; (add-hook 'web-mode-hook
;;           '(lambda ()
;;              (local-set-key "\C-t" 'wrap-in-html-tag)))



;; ;;works:
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-jsx-mode))
;; (add-hook 'js2-jsx-mode-hook
;;           (lambda ()
;;             (when (equal web-mode-content-type "js")
;;               (flycheck-select-checker 'javascript-eslint)
;;               (flycheck-mode)
;;               (yas-minor-mode)
;;               (message "Loaded jsx specific stuff"))))
