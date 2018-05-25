;;;;;;;;;;;;;;;;;;;;;
;; javascript mode ;;
;;;;;;;;;;;;;;;;;;;;;

(use-package nodejs-repl :ensure t)
(use-package js2-mode :ensure t)
(use-package jsx-mode :ensure t)
(use-package react-snippets :ensure t)
(use-package ac-js2 :ensure t)
(use-package js-comint :ensure t)
(use-package color-identifiers-mode :ensure t)

(require 'js2-mode)
;; grabpag of  js-2 stuff
;; mostly from: https://github.com/howardabrams/dot-files/blob/master/emacs-javascript.org

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

;; We'll let fly do the error parsing...
;;(setq-default js2-show-parse-errors nil)x

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

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
;; repl
(require 'nodejs-repl)

;; sending stuff to repl
(require 'js-comint)
(autoload 'js-comint "js-comint"
  "Hooking JavaScript interpreter up to the JS Files." t nil)

;; Turn off fancy node prompt
(setenv "NODE_NO_READLINE" "1")

;; Use node as our repl
(setq inferior-js-program-command "node")

;; js-specific keybindings
(add-hook 'js2-mode-hook '(lambda ()
                            (local-set-key "\C-x\C-e" 'js-send-last-sexp)
                            (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
                            (local-set-key "\C-cb" 'js-send-buffer)
                            (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
                            (local-set-key "\C-cl" 'js-load-file-and-go)))

;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (flycheck-select-checker 'javascript-eslint)
;;             (flycheck-mode)
;;             (yas-minor-mode)
;;             (message "Loaded eslint specific stuff")))


;; auto-completion
(add-hook 'js2-mode-hook 'ac-js2-mode)

;;;;;;;;;;;;;;;;;;;;;;;;
;; from http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html



;; use web-mode for .js files
;;(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

;; ;; http://www.flycheck.org/manual/latest/index.html
;; (require 'flycheck)

;; ;; turn on flychecking globally
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; ;; disable jshint since we prefer eslint checking
;; (setq-default flycheck-disabled-checkers
;;               (append flycheck-disabled-checkers
;;                       '(javascript-jshint)))

;; ;; use eslint with web-mode for jsx files
;; (flycheck-add-mode 'javascript-eslint 'web-mode)

;; ;; customize flycheck temp file prefix
;; (setq-default flycheck-temp-prefix ".flycheck")

;; ;; disable json-jsonlist checking for json files
;; (setq-default flycheck-disabled-checkers
;;               (append flycheck-disabled-checkers
;;                       '(json-jsonlist)))

;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;
;; web mode ;;
;;;;;;;;;;;;;;

(use-package web-mode :ensure t)

;; basic configs
(defun config-web-mode ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-pairing t))
(add-hook 'web-mode-hook  'config-web-mode)

;; tag-wrapping
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

;; use eslint instead of jshint
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; react-specific configs
(require 'react-snippets)

;;works:
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-jsx-mode))
(add-hook 'js2-jsx-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              (flycheck-select-checker 'javascript-eslint)
              (flycheck-mode)
              (yas-minor-mode)
              (message "Loaded jsx specific stuff"))))
