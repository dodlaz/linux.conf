;(add-to-list 'load-path "/home/klaar/lsw/python-mode.el-6.0.11/") 
;(setq py-install-directory "/home/klaar/lsw/python-mode.el-6.0.11/")
;(require 'python-mode)

;; (global-set-key (kbd "C-x C-m i") 'set-input-method)

;; If you always prefer UTF-8 to ISO-8859-1, you can use this:
;(prefer-coding-system 'utf-8)

;; collection of emacs settings collected from various sources
;; Base file: tao@ida, tjo@ida
;; Additions: klaar@ida, Jonathand Waldsjö,
;;   jonwa416@student arvka568@student

;; Save this file in your home folder (~/.emacs)
;; If you do not like it, comment it out by adding semicolon first on line

;; use xfontsel or xlsfonts to find a font you like
;; set on command line is a lot faster and nicer startup appearance
;(set-default-font "-*-fixed-*-r-normal-*-12-*-*-*-*-*-iso8859-*")
;(set-default-font "-*-courier-*-r-normal-*-12-*-*-*-*-*-iso8859-1")

;; ======================
;; =   Arvid Karlsson   =
;; ======================


(setq user-full-name "Arvid Karlsson")
(setq user-mail-address "arvid.karlsson94@gmail.com")

;; Set the name of the host and current path/file in title bar:
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
	    '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))




;;yes to y
(defalias 'yes-or-no-p 'y-or-n-p)

;; Mouse 
;(global-set-key [down-mouse-2] 'imenu)

;; Disable mouse-2 event that was appending text into documents
;(global-set-key [mouse-2] nil)


;; ===== Function to delete a line =====
(defvar previous-column nil "Save the column position")
(defun nuke-line()
  "Kill an entire line, including the trailing newline character"
  (interactive)
  (setq previous-column (current-column))
  (end-of-line)
  (if (= (current-column) 0)
    (delete-char 1)
    (progn
      (beginning-of-line)
      (kill-line)
      (delete-char 1)
      (move-to-column previous-column))))
(global-set-key [C-delete] 'nuke-line)


(global-set-key (kbd "C-a") 'mark-whole-buffer)              ;; Markera hella filen
(global-set-key '[(insert)] (fset 'ind [tab down]))          ;; Indentering
(global-set-key '[(C-c)] 'copy)                              ;; Kopiering !!!!!!!!!!!!!!!!!
(global-set-key [C-f12] '(lambda () (interactive) (eshell))) ;; Shells (Terminal)

;; Book mark
(define-key global-map [f9] 'bookmark-jump)
(define-key global-map [f10] 'bookmark-set)

;; Indent Whole Buffer
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


;; AUTO COMPLET
;(add-to-list 'load-path "~/.emacs.d/")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;(ac-config-default)
;(ac-set-trigger-key "TAB")

;; Mark lines thate is lnger then 80 caracters
;;(add-hook 'c++-mode-hook '(lambda () (highlight-lines-matching-regexp ".\\{81\\}" 'hi-yellow)))

;; don't save bacups files
(setq make-backup-files nil)

(setq default-frame-alist (append (list 
  '(width  . 81)  ; Width set to 81 characters 
  '(height . 40)) ; Height set to 60 lines 
  default-frame-alist)) 

;; Line nuber
(global-linum-mode t)



;; ======================
;; =  /Arvid Karlsson   =
;; ======================




;; No annoying messages at startup, thank you very much.
(setq inhibit-default-init t)
(setq inhibit-startup-message t)

;; Disable some useless graphics
(tool-bar-mode nil)
(menu-bar-mode nil)
(scroll-bar-mode nil)

;; Put the scrollbar where it should be
(setq scroll-bar-mode-explicit t)
(set-scroll-bar-mode 'right)

(load "paren")

;; Highlight matching parenthesis
(show-paren-mode 1)

;; load special programming mode for NesC
;(setq load-path (cons (expand-file-name "/home/TDDI07/lab/lib/ncc/editor-modes/emacs") load-path))
;(autoload 'nesc-mode "nesc.el")
;(add-to-list 'auto-mode-alist '("\\.nc\\'" . nesc-mode))

;; MATLAB mode
;(setq load-path (cons (expand-file-name "~klaar/matlab-lisp") load-path))
;(autoload 'matlab-mode "matlab.el")
;(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))
         
(add-to-list 'auto-mode-alist '("\\.shtml\\'" . html-mode))
(add-hook 'html-mode-hook (lambda ()
                            (flyspell-mode t)
                            (setq lang (file-name-extension (file-name-sans-extension (buffer-name))))
                            (if (string= "en" lang)
                                (ispell-change-dictionary "english")
                              (ispell-change-dictionary "svenska")
                              )
                            )
          )

(add-hook 'c++-mode-hook
          (lambda ()
            (flyspell-prog-mode)
            (ispell-change-dictionary "english")
          ))

;; (defun fd-switch-dictionary()
;;       (interactive)
;;       (let* ((dic ispell-current-dictionary)
;;     	 (change (if (string= dic "deutsch8") "english" "deutsch8")))
;;         (ispell-change-dictionary change)
;;         (message "Dictionary switched from %s to %s" dic change)
;;         ))
    
;; (global-set-key (kbd "<f8>")   'fd-switch-dictionary)

;; --- Flyspell -----------------------------------------------------
;(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;; the default flyspell behaviour
;(put 'LeTex-mode 'flyspell-mode-predicate 'tex-mode-flyspell-verify)

;; some extra flyspell delayed command
;(mapcar 'flyspell-delay-command '(scroll-up1 scroll-down1))

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; ------------------------------------------------------------------


;; PHP-mode ( not up to date ? )
; (load "~klaar/.emacs.d/php-mode.el")
; (setq auto-mode-alist (cons '("\\.php" . php-mode) auto-mode-alist))

;; graphviz mode ( not up to date ? )
; (load "~klaar/.emacs.d/graphviz-dot-mode.el")
; (setq auto-mode-alist (cons '("\\.dot" . graphviz-dot-mode) auto-mode-alist))

(global-font-lock-mode t)                      ; Highlighting...
(setq font-lock-maximum-decoration t)          ; ...as much as possible...
;(setq font-lock-support-mode 'lazy-lock-mode)  ; ...in the background (?)...
;(setq lazy-lock-stealth-time 30)               ; ...after 30 seconds...
;(setq lazy-lock-stealth-verbose t)             ; ...and report doing so...
;(setq lazy-lock-defer-driven 1)                ; ...defer-driven "eventually".

;; Better suport for Swedish characters ( why would you use them ? )
;(set-language-environment "Latin-1")
;(set-terminal-coding-system 'latin-1)

;; Base colors (using emacs21 with white background for printing)
(if (string-match "^24" emacs-version)
    (progn 
      (set-background-color "Black")
      (set-foreground-color "White")
      (set-cursor-color     "ForestGreen"))
  (progn 
    (set-background-color "Black")
    (set-foreground-color "White")
    (set-cursor-color     "ForestGreen"))
  )

;; Used for C-u M-x ps-print-buffer-with-faces
;; ?? but not possible to set before doing M-x ps-print... once ??
(setq ps-print-header nil)
(setq ps-font-size 14)
(setq ps-landscape-mode t)
(setq ps-number-of-columns 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OLD Color settings, outdated with emacs version 22
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Different base setting depending on host
;; (if (string-match "astmatix.ida.liu.se" (getenv "HOST"))
;;     (progn 
;;       (set-background-color "Black")
;;       (set-foreground-color "White")
;;       (set-cursor-color     "White")))

;; ;; Färger i Emacs 19.XX
;; ;; Kodspecifika färger. För varje kodtyp anges följande:
;; ;;     (FACE FOREGROUND BACKGROUND BOLD-P ITALIC-P UNDERLINE-P)
;; (if (string-match "^19" emacs-version)
;;     (setq font-lock-face-attributes
;; 	  '((font-lock-comment-face       "FireBrick"   nil nil t   nil)
;; 	    (font-lock-function-name-face "Blue"        nil t   nil nil)
;; 	    (font-lock-keyword-face       "Black"       nil t   nil nil)
;; 	    (font-lock-string-face        "ForestGreen" nil nil t   nil)
;; 	    (font-lock-type-face          "Blue"        nil nil nil nil)
;; 	    (font-lock-variable-name-face "Black"       nil nil nil nil)
;; 	    (font-lock-reference-face     "ForestGreen" nil nil nil nil))))


;; ;; Färger i Emacs 20.XX
;; (if (string-match "^20" emacs-version)
;;     (progn
;;       (custom-set-variables)
;;       (custom-set-faces
;;        '(font-lock-comment-face ((((class color) (background light))
;; 				  (:italic t :foreground "Firebrick"))))
;;        '(font-lock-function-name-face ((((class color) (background light))
;; 					(:bold t :foreground "Blue"))))
;;        '(font-lock-keyword-face ((((class color) (background light))
;; 				  (:bold t :foreground "Black"))))
;;        '(font-lock-string-face ((((class color) (background light))
;; 				 (:italic t :foreground "ForestGreen"))))
;;        '(font-lock-type-face ((((class color) (background light))
;; 			       (:foreground "Blue"))))
;;        '(font-lock-variable-name-face ((((class color) (background light))
;; 					(:foreground "Black"))))
;;        '(font-lock-reference-face ((((class color) (background light))
;; 				    (:foreground "ForestGreen")))))))

;; ----------------------------------------------------------------------------
;; Några extra saker som kan vara trevliga att ha.
;; ----------------------------------------------------------------------------

;; Hantera character med kod 128+ (t. ex. svenska vokaler)
(set-input-mode (car (current-input-mode))
                     (nth 1 (current-input-mode))
                     0)

;; Delete-knapp raderar all text i ett markerat område
(delete-selection-mode t)

;; Invertera markerat område
;;(transient-mark-mode t)

;; "Ctrl-RET" för att fylla ut ett ord (ungefär som "TAB" i skalfönstret).
(global-set-key '[(control return)] 'dabbrev-expand)

;; Se till att man inte kan gå längre ner i filen än till sista raden
;; Gör att man inte får en massa tomma rader i slutet av filen
(setq next-line-add-newlines nil)

;; Gör så att man endast "scrollar" en rad i taget när man går uppåt
;; och neråt
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; Se till att vi håller reda på vilken rad och position på rad vi
;; befinner oss på.
(setq line-number-mode t)
(setq column-number-mode t)


;; Byt ordning på CR/LF Kommer att ge indrag på varje ny rad!
(setq foo (global-key-binding "\C-m"))              ; Spara CF
(global-set-key "\C-m" (global-key-binding "\C-j")) ; Sätt CR till LF
(global-set-key "\C-j" foo)                         ; Sätt LF till gamla CR


;; F5 ändrar "line-wrap".
(global-set-key [f5] 'toggle-truncate-lines)
(global-set-key [C-f1] 'toggle-menu-bar-mode-from-frame)
(global-set-key [C-f2] 'toggle-scroll-bar)
(global-set-key [C-f3] 'toggle-tool-bar-mode-from-frame)



;; C++ specifikt
;; Behandla *.h-filer som C++ ist.f. C
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;; Bra indrag
(setq c-default-style "ellemtel") ; ändra till "stroustrup" om man vill
(setq-default indent-tabs-mode nil)

;; Indent level, useful for Pintos
; (setq c-indent-level 2)
(setq c-basic-offset 2)
(setq tab-width 2)

;; Get rid of annoying startup-screen
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(inhibit-startup-screen t)
 '(py-python-command "python3")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)


