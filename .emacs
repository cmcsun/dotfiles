(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
    )
(add-to-list 'load-path "~/.emacs.d/evil/")
(require 'evil)
    (evil-mode 1)
(setq default-tab-width 4)
(require 'cc-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)
;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
(require 'auto-complete-clang)
(define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
;; replace C-S-<return> with a key binding that you want
(setq mf--source-file-extension "cpp")
(require 'framemove)
(require 'win-switch)
(setq speedbar-use-images nil)
;(require 'cmake-project)
(global-set-key (kbd "C-x P") 'previous-multiframe-window)
(global-set-key (kbd "C-x O") 'next-multiframe-window)
