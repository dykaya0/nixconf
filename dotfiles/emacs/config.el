;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; Options
(setq display-line-numbers-type 'relative)

;; *Set week start to Monday*
(setq calendar-week-start-day 1)

;; Global keybinds
(after! evil
  (evil-ex-define-cmd "W" #'save-buffer))

(map! :leader
      :desc "Vertical split"
      "s v" #'+evil/window-vsplit-and-follow)
(map! :leader
      :desc "Close window"
      "s s" #'delete-window)
(map! "C-l" #'evil-window-right)
(map! "C-h" #'evil-window-left)
(map! "C-k" #'evil-window-up)
(map! "C-j" #'evil-window-down)

(map! :leader
      "f f" nil)
(map! :leader
      :desc "Find file"
      "s f" #'find-file)

(map! :leader
      "f r" nil)
(map! :leader
      "s r" nil)
(map! :leader
      :desc "Recent files"
      "s r" #'consult-recent-file)

;; Org Global Settings
(after! org
(setq org-directory "~/org")
(setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))
(setq org-log-done 'time)
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)
;; Enable syntax highlighting for Org source blocks
(setq org-src-fontify-natively t)
;; Ensure Org knows rust -> rust-mode
(add-to-list 'org-src-lang-modes '("rust" . rust))
(setq org-todo-keywords
      '((sequence "PROJ(p)" "LOOP(l)" "BACK(b)" "TODO(t)"
                  "STRT(s)" "HOLD(h)" "WAIT(w)" "IDEA(i)"
                  "|"
                  "DONE(d)" "KILL(k)")))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "OrangeRed"      :weight bold))
        ("PROJ" . (:foreground "MediumPurple"   :weight bold))
        ("LOOP" . (:foreground "MediumOrchid"   :weight bold))
        ("STRT" . (:foreground "chartreuse"     :weight bold))
        ("WAIT" . (:foreground "goldenrod"      :weight bold))
        ("HOLD" . (:foreground "SteelBlue"      :weight bold))
        ("IDEA" . (:foreground "CadetBlue"      :weight normal))
        ("BACK" . (:foreground "SlateGray"     :weight normal))
        ("DONE" . (:foreground "DimGray"        :weight bold))
        ("KILL" . (:foreground "gray30"         :weight bold :strike-through t))))

(custom-set-faces
  '(org-level-1 ((t (:foreground "floral white" :weight bold ))))
  '(org-level-2 ((t (:foreground "GhostyWhite" :weight bold ))))
  '(org-level-3 ((t (:foreground "Silver" ))))
  '(org-level-4 ((t (:foreground "Ivory" ))))
  '(org-level-5 ((t (:foreground "Ivory" ))))
  '(org-level-6 ((t (:foreground "Ivory" ))))
  '(org-level-7 ((t (:foreground "Ivory" ))))
  '(org-level-8 ((t (:foreground "Ivory" )))))


;; Org keybinds
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c t") #'org-todo)


;; Org Capure Templates
(setq org-capture-templates
      '(
        ("i" "New idea" entry (file+headline (lambda () (concat org-directory "/ideas.org")) "Ideas")
         "* IDEA %?\n  %i\n ")
        ("t" "New todo" entry (file+headline (lambda () (concat org-directory "/life.org")) "Todos")
         "* TODO %?\n  %i\n ")
        ))

;; Org Agenda Views
(setq org-agenda-block-separator ?~)
(setq org-agenda-time-grid
      (quote
       ((daily today remove-match)
        (600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1800 2000 2200)
        "......" "----------------")))

(setq org-agenda-custom-commands
      '(
        ("v" "More comprehensive agenda view"
         ((tags "PRIORITY=\"A\"+TODO=\"TODO\""
                ((org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "")
          (tags "TODO=\"TODO\""
                ((org-agenda-overriding-header "All unfinished tasks:")))
          ))
        ("k" "Kanban view"
         ((tags "TODO=\"BACK\""
                ((org-agenda-overriding-header "BACK (unscheduled)")))
          (tags "TODO=\"TODO\""
                ((org-agenda-overriding-header "TODO (scheduled, awaiting)")))
          (tags "TODO=\"STRT\""
                ((org-agenda-overriding-header "STRT (started, in progress)")))
          (tags "TODO=\"WAIT\""
                ((org-agenda-overriding-header "WAIT (waiting on external factor)")))
          (tags "TODO=\"HOLD\""
                ((org-agenda-overriding-header "HOLD (paused, stopped working on it for a temporary time)")))
          (tags "TODO=\"DONE\""
                ((org-agenda-overriding-header "DONE (finished)")))
          (tags "TODO=\"KILL\""
                ((org-agenda-overriding-header "KILL (canceled, abandoned)")))
          )
         ((org-agenda-files
           (remove
            (concat org-directory "/habits.org")
            (remove
             (concat org-directory "/content.org")
             org-agenda-files))))

         )
        )
      )


) ;; after! org

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
