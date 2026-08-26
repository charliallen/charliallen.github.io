;;; new-post.el --- Quickly scaffold a new blog post -*- lexical-binding: t; -*-

(defun charliallen-blog--slugify (title)
  (let* ((lower (downcase title))
         (slug (replace-regexp-in-string "[^a-z0-9]+" "-" lower)))
    (string-trim slug "-+" "-+")))

(defun charliallen-blog-new-post (title)
  "Create a new post under src/site/posts/ named YYYY-MM-DD-TITLE.md,
open it, and insert the frontmatter."
  (interactive "sPost title: ")
  (let* ((root (locate-dominating-file default-directory ".dir-locals.el"))
         (slug (charliallen-blog--slugify title))
         (date (format-time-string "%Y-%m-%d"))
         (path (expand-file-name (format "src/site/posts/%s-%s.md" date slug) root)))
    (when (file-exists-p path)
      (user-error "Post already exists: %s" path))
    (find-file path)
    (insert (format "title: %s\ndate: %s %s\nsummary: \ntags: \n---\n\n"
                     title date (format-time-string "%H:%M")))
    (goto-char (point-max))))

;;; new-post.el ends here
