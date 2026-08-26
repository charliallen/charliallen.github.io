;; SPDX-License-Identifier: GPL-3.0-or-later

(use-modules
 (haunt asset)
 (haunt builder atom)
 (haunt builder assets)
 (haunt builder blog)
 (haunt builder flat-pages)
 (haunt post)
 (haunt reader commonmark)
 (haunt reader skribe)
 (haunt site)
 (theme)
 (utils))

(define post-prefix "/posts")

(define collections
  `(("Recent Posts" "blog.html" ,posts/reverse-chronological)))

(site #:title
      "Charli's Web"
      #:domain
      "charliallen.github.io"
      #:default-metadata
      '((author . "Charli Allen"))
      #:readers
      (list commonmark-reader skribe-reader)
      #:builders
      (list (blog #:theme charli-theme
                  #:collections collections
                  #:post-prefix post-prefix
                  #:posts-per-page 10)
            (atom-feed #:blog-prefix post-prefix)
            (atom-feeds-by-tag #:blog-prefix post-prefix)
            (flat-pages "pages" #:template flat-page-template)
            (static-directory "images")
            (static-directory "videos")
            (static-directory "css"))
      #:build-directory "../../target/")
