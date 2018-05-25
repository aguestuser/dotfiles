;;;;;;;;;;;;;;;;
;; navigation ;;
;;;;;;;;;;;;;;;;

;; helm
(use-package helm
  :ensure t
  :init
  (progn
    (require 'helm-config)
    (helm-mode 1))
  :bind (
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)))

(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on)
  )
(use-package helm-ag :ensure t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-unset-key (kbd "C-c p h"))
(global-set-key (kbd "C-x p") 'helm-projectile)

;; dired
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
                '("\\.zip\\'" ".zip" "unzip")))

;; speedbar
(use-package sr-speedbar
  :ensure t
  :init (progn
          (require 'sr-speedbar)
          (setq sr-speedbar-right-side nil)
          (global-set-key (kbd "C-c s") 'sr-speedbar-toggle)))



;; projectile everywhere!
;; (projectile-global-mode)

;; ido

;; ido-mode allows you to more easily navigate choices. For example,
;; when you want to switch buffers, ido presents you with a list
;; of buffers in the the mini-buffer. As you start to type a buffer's
;; name, ido will narrow down the list of buffers to match the text
;; you've typed in
;; http://www.emacswiki.org/emacs/InteractivelyDoThings

;; (use-package ido-ubiquitous :ensure t)
;; (ido-mode t)

;; ;; This allows partial matches, e.g. "tl" will match "Tyrion Lannister"
;; (setq ido-enable-flex-matching t)

;; ;; Turn this behavior off because it's annoying
;; (setq ido-use-filename-at-point nil)

;; ;; Don't try to match file across all "work" directories; only match files
;; ;; in the current directory displayed in the minibuffer
;; (setq ido-auto-merge-work-directories-length -1)

;; ;; Includes buffer names of recently open files, even if they're not
;; ;; open now
;; (setq ido-use-virtual-buffers t)

;; ;; This enables ido in all contexts where it could be useful, not just
;; ;; for selecting buffer and file names
;; (ido-ubiquitous-mode 1)
