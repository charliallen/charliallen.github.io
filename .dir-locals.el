((markdown-mode
  . ((eval . (progn
               (require 'yasnippet)
               (let ((root (locate-dominating-file default-directory ".dir-locals.el")))
                 (add-to-list 'yas-snippet-dirs (expand-file-name "dev/emacs/yasnippets" root))
                 (load (expand-file-name "dev/emacs/new-post.el" root)))
               (yas-reload-all)
               (local-set-key (kbd "C-c C-n") #'charliallen-blog-new-post))))))
