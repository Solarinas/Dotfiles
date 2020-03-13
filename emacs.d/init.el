;; -------------------- Initialise packages
(load "package")
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
;;-------------------- User info
(setq user-full-name "Solarinas")
(setq user-mail-address "solarinass@protonmail.com")

;;-------------------- Text Editing Plugins

;; New autosave directory
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs-saves/" t)))

;; Handle Parentheses
(electric-pair-mode)
(show-paren-mode)

(setq max-specpdl-size 130000)

;;-------------------- Helm Framework

(use-package helm
  :demand t
  :bind ("M-x" . helm-M-x)
  :config
  (load-file "~/.emacs.d/plugins/helm-fzf.el")
  (helm-mode 1)
  )

;;-------------------- Counsel


(global-set-key (kbd "C-c C-p") 'counsel-fzf)
(global-set-key (kbd "C-c C-/") 'counsel-rg)

;;-------------------- Emacs Application Framework

(use-package eaf
  :load-path "/usr/share/emacs/site-lisp/eaf" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :custom
  (eaf-find-alternate-file-in-dired t)
  :config
  (eaf-bind-key scroll_up "RET" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down_page "DEL" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding))


;;-------------------- Auto complete framework
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (global-company-mode 1)
  (global-set-key (kbd "C-<tab>") 'company-complete))

(use-package company-lsp
  :ensure t
  :config
  (setq company-lsp-enable-snippet t)
  (push 'company-lsp company-backends)

  ;; Disable client-side cache becuase LSP does a better job
  (setq company-transformers nil
	company-lsp-async t
	company-lsp-cache-candidates nil))

(setq company-minimum-prefix-length 1
      company-idle-delay 0.0)

;; -------------------- Language Server Protocol

(use-package lsp-mode
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  :init (setq lsp-keymap-prefix "C-c l")
  :config (setq lsp-diagnostic-package 'flycheck)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 (c-mode . lsp)
	 (sh-mode . lsp)
	 (c++-mode . lsp)
	 (python-mode . lsp)
	 (lua-mode . lsp)
	 (html-mode . lsp)
	 (java-mode . lsp)
	 (css-mode . lsp)
	 (rust-mode . lsp)
	 ;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui
  :requires lsp-mode flycheck
  :config
  (setq lsp-ui-doc-enable t
	lsp-ui-doc-header t
	lsp-ui-doc-use-childframe t
	lsp-ui-doc-include-signature t
	lsp-ui-doc-position 'top
	lsp-ui-sideline-enable nil
	lsp-ui-sideline-ignore-duplicate t
	lsp-ui-flycheck-list-position 'bottom
	lsp-flycheck-live-reporting t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t
  :after lsp-mode
  :init
  (require 'cl-lib)
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (use-package dap-java :after (lsp-java))
  (require 'dap-python)
  (require 'dap-gdb-lldb)
  ); to load the dap adapter for your language


;; optional if you want which-key integration
(use-package which-key
  :config
  (which-key-mode))

;;-------------------- Debuggers

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t)
  :config
  (setq flycheck-display-errors-function
	#'flycheck-display-error-messages-unless-error-list))

;;-------------------- UI

;; Disable Emacs UI elements
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
;; (set-frame-parameter nil 'undecorated t)

;; Enable line highlight
(global-hl-line-mode +1)

;;Font Settings
;; (set-frame-font "Inconsolata Bold 13" nil t)
(setq default-frame-alist '((font . "Inconsolata Bold 13")))
(add-hook 'after-init-hook #'global-emojify-mode)

;; Highlighters
(add-hook 'prog-mode-hook 'highlight-numbers-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)

;; Load icons
(use-package all-the-icons)

;; Emacs theme
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (load-theme 'doom-ayu-dark t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


;; Doom modeline
(use-package doom-modeline
  :defer t
  :hook (after-init . doom-modeline-init)
  :config
  (setq doom-modeline-bar-width 3
	doom-modeline-icon t
	doom-modeline-buffer-file-name-style 'truncate-with-project
	doom-modeline-minor-modes nil
	doom-modeline-major-mode-icon t))


;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-startup-banner "~/.emacs.d/GabEmacs2.png")
(setq dashboard-banner-logo-title "Happy Hacking~ ❤")
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
;; Centaur tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))
(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-set-bar 'left)

;; Relative numbers
(linum-relative-global-mode)
(setq linum-relative-backend 'display-line-numbers-mode)

;; Sublimity
(use-package sublimity
  :config (require 'sublimity)
  (require 'sublimity-scroll)
  (sublimity-mode 1)
  (setq sublimity-scroll-weight 9
	sublimity-scroll-drift-length 10)
  )

;; ido-mode
(ido-mode 1)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)


;;-------------------- Keyboard shortcuts

;; Evil mode
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))
(evil-mode 1)
(evil-collection-init)

;; Evil Leader
(global-evil-leader-mode)
(evil-leader/set-leader ",")

;; Nerd Commenter Shortcuts
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-c l") 'evilnc-quick-comment-or-uncomment-to-the-line)
(global-set-key (kbd "C-c c") 'evilnc-copy-and-comment-lines)
(global-set-key (kbd "C-c p") 'evilnc-comment-or-uncomment-paragraphs)


;; Vim key bindings
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-key
  "cc" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ci" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "."  'evilnc-copy-and-comment-operator
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
  "vf" 'treemacs
  ;; "ct" 'imenu-list-smart-toggle
  "ct" 'lsp-ui-imenu
  "lc" 'flycheck-show-errors
  "lc" 'eval-buffer
  )

;; Git Shortcuts
(use-package magit
  :bind
  (:prefix-map magit-prefix-map
	       :prefix "C-c m"
	       (("a" . magit-stage-file) ; the closest analog to git add
		("b" . magit-blame)
		("B" . magit-branch)
		("c" . magit-checkout)
		("C" . magit-commit)
		("d" . magit-diff)
		("D" . magit-discard)
		("f" . magit-fetch)
		("g" . vc-git-grep)
		("G" . magit-gitignore)
		("i" . magit-init)
		("l" . magit-log)
		("m" . magit)
		("M" . magit-merge)
		("n" . magit-notes-edit)
		("p" . magit-pull)
		("P" . magit-push)
		("r" . magit-reset)
		("R" . magit-rebase)
		("s" . magit-status)
		("S" . magit-stash)
		("t" . magit-tag)
		("T" . magit-tag-delete)
		("u" . magit-unstage)
		("U" . magit-update-index))))

(load-file "~/.emacs.d/plugins/discord-emacs.el")
(discord-emacs-run "384815451978334208")

;; -------------------- Org Mode

;; Set agenda files
(setq org-agenda-files (list "~/Documents/Org/home.org"
			     "~/Documents/Org/work.org"
			     "~/Documents/Org/extra.org"))
;; Org-mode bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3e3a1caddeee4a73789ff10ba90b8394f4cd3f3788892577d7ded188e05d78f4" default))
 '(eaf-find-alternate-file-in-dired t t)
 '(package-selected-packages
   '(helm-ag restart-emacs lsp-ivy horizon-theme counsel-tramp minibuffer-line counsel ivy evil-multiedit web-mode emmet-mode ranger smart-compile hexo frog-jump-buffer avy-menu csv csv-mode xcscope ggtags helm-gtags nhexl-mode yasnippet which-key vscode-icon use-package treemacs-magit treemacs-icons-dired treemacs-evil tramp-auto-auth telephone-line sublimity sr-speedbar spaceline-all-the-icons smex smart-mode-line-powerline-theme session rust-mode rainbow-delimiters powerline-evil org-bullets monokai-pro-theme minimap lsp-ui lsp-java linum-relative kaolin-themes imenus imenu-list imenu-anywhere ido-vertical-mode ido-completing-read+ highlight-quoted highlight-numbers highlight-defined helm-descbinds fzf flycheck-rust evil-nerd-commenter evil-leader evil-collection emojify doom-themes doom-modeline doom dashboard darkokai-theme dap-mode company-lua company-lsp cl-libify centaur-tabs ccls base16-theme badger-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
