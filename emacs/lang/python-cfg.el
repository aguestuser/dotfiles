;; ~/.emacs.d/personal/lang/python-cfg.el

;;;;;;;;;;;;
;; Python ;;
;;;;;;;;;;;;


;; IPYTHON MULTILINE GOTCHA:
;; https://emacs.stackexchange.com/questions/14082/multi-line-inputs-in-ipython
;; $ sudo pip install rlipython
;; $ ipython
;; [1] import rlipython; rlipython.install()

(setq py-python-command "/usr/bin/python3")



;;;;;;;;;;;;;;;;;
;; python-mode ;;
;;;;;;;;;;;;;;;;;

;;  we  defer to configs offered in lsp-cfg.el, with the following prereqs:
;;  pip3 install jedi python-language-server[all]  pyls-mypy

(use-package python-mode
  :ensure t
  :config (progn
            ;; (setq python-shell-interpreter "python3")
            ;; (setq python-shell-interpreter-args "-i")
            (setq python-shell-interpreter "ipython3" python-shell-interpreter-args "--simple-prompt -i")
            (add-hook 'python-mode-hook (highlight-indentation-mode 1))))


;;;;;;;;;;;;;;;
;; nose-mode ;;
;;;;;;;;;;;;;;;

(use-package nose-mode :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Jedi (code completion, etc.) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package jedi
  :ensure t
  :config (progn
            ;; GOTCHA: on first run might require: `M-x jed:install-server`
            (add-hook 'python-mode-hook 'jedi:setup)
            (setq jedi:environment-root "jedi")  ; or any other name you like
            (setq jedi:environment-virtualenv
                  (append python-environment-virtualenv
                          '("--python" "/usr/bin/python3")))
            ;; (setq elpy-rpc-backend "jedi")
            ;; (setq jedi:complete-on-dot t)
            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs IPython Notebook (EIN) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; PYTHON REQUIREMENTS: $ ipython tornado dash jupyterhub
;; DOCS: http://tkf.github.io/emacs-ipython-notebook/

(use-package request :ensure t)
(use-package websocket :ensure t)
(use-package skewer-mode :ensure t)
(use-package smartrep :ensure t)
(use-package ein
  :ensure t
  :init (progn
          (require 'ein)
          ;; (require 'ein-loaddefs)
          (require 'ein-notebook)
          (require 'ein-subpackages))
  :config (progn
            ;; use `url-retrieve` instead of `curl`
            ;; as per: https://github.com/tkf/emacs-ipython-notebook/issues/130
            ;; (setq request-backend 'url-retrieve)
            ;; make jupyter startup from emacs easier (note: actually running from emacs borked for me)
            ;; as per: https://github.com/millejoh/emacs-ipython-notebook/issues/176
            (setq ein:jupyter-default-server-command "/usr/local/bin/jupyter")
            (setq ein:jupyter-server-args (list "--no-browser"))
            (setq ein:completion-backend 'ein:use-ac-jedi-backend)))

;; EIN AUTHENTICATION GOTCHA:
;; https://github.com/millejoh/emacs-ipython-notebook/issues/147

;; USAGE:
;; (1) disable authentication:
;;     $ jupyter notebook --generate-config
;;     * in ~/.jupyter/jupyter_notebook_config.py
;;     * set `c.NotebookApp.password` and `c.NotebookApp.token` to `''`
;;     $ jupypter notebook # start jupyter server
;;     M-x ein:notebooklist-login
;;     * provide empty strings
;;     M-x ein:notebooklist-open
;; ..OR..
;; (2) copy and past login token from terminal every time you start


;;;;;;;;;;
;; elpy ;;
;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; deprecated for now, since we defer to lsp mode...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; PYTHON REQUIREMENTS: $ pip3 install flake8 jedi importmagic autopep8
;; DOCS: https://elpy.readthedocs.io/en/latest/

;; (use-package elpy
;;   :ensure t
;;   :init (progn
;;           ;; (package-initialize)
;;           (require 'elpy))
;;   :config (progn
;;             (elpy-enable)
;;             (setq python-shell-interpreter "ipython3")
;;             (setq python-shell-interpreter-args "--simple-prompt -i")
;;             (setq elpy-rpc-python-command "python3")
;;             (add-hook 'elpy-mode-hook
;;                       '(lambda ()
;;                          (local-set-key (kbd "C-c , t") 'elpy-test-nose-runner)))))
