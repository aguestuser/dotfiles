;; ~/.emacs.d/personal/lang/go-cfg.el

;; depencenices:
;; - the `gocode' binary must be installed in $GOPATH/bin.
;; - and these go packages must have been installed:
;; - `golang.org/x/tools/cmd/gorename'
;; - `golang.org/x/tools/cmd/goimports'
;; - `github.com/kovetskiy/godocs'
;; - `github.com/rogpeppe/godef'

;; source: http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/

;; require dependencies
(use-package go-mode :ensure t)
(use-package go-rename :ensure t)
(use-package go-autocomplete :ensure t)
(use-package go-eldoc :ensure t)

;; set $GOPATH
;; allow for autocomplete when searching godocs
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))
;; on osx
(setenv "GOPATH" "/Users/aguestuser/-/code/go")
;; on linux
;; (setenv "GOPATH" "home/aguestuser/-/code/go")

;; automatically run gofmt on save
(defun go-mode-setup ()
  (go-eldoc-setup)
  ;; bind go-rename
  (local-set-key (kbd "C-c C-r") 'go-rename)
  ;; use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ;; run gofmt on every save
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark) ;; goes back!
  ;; godef-at-point key binding
  (local-set-key (kbd "M-RET") 'godoc-at-point)
  ;; disable whitespace (annoying w/ tabs!)
  (whitespace-mode -1)
  ;; Customize compile command
  (set (make-local-variable 'compile-command)
       "go build -v && go test")
  (local-set-key (kbd "C-c C-t") 'compile))



(add-hook 'go-mode-hook 'go-mode-setup)
