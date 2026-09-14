;; SPDX-License-Identifier: GPL-3.0-or-later
(define-module (haunt)
  #:use-module (haunt asset)
  #:use-module (haunt builder atom)
  #:use-module (haunt builder assets)
  #:use-module (haunt builder blog)
  #:use-module (haunt builder flat-pages)
  #:use-module (haunt post)
  #:use-module (haunt reader commonmark)
  #:use-module (haunt reader skribe)
  #:use-module (haunt site)
  #:use-module (theme)
  #:use-module (utils))

(define post-prefix "/posts")

(define collections
  `(("Recent Posts" "blog.html" ,posts/reverse-chronological)))

(site #:title
      "Charli's Web"
      #:domain
      "charlilefay.com"
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
	    (static-directory "css")
            (static-directory "images")
	    (static-directory "keys")
            (static-directory "videos"))
      #:build-directory "../../target/")
