;; SPDX-License-Identifier: GPL-3.0-or-later

;; Modified from dthompson's theme https://git.dthompson.us/blog/tree/theme.scm
(define-module (theme)
  #:use-module (haunt artifact)
  #:use-module (haunt builder blog)
  #:use-module (haunt html)
  #:use-module (haunt post)
  #:use-module (haunt site)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-19)
  #:use-module (utils)
  #:export (charli-theme
            flat-page-template
            static-page))

(define %cc-by-sa-link
  '(a (@ (href "https://creativecommons.org/licenses/by-sa/4.0/"))
      "Creative Commons Attribution Share-Alike 4.0 International"))

(define %cc-by-sa-button
  '(a (@ (class "cc-button")
         (href "https://creativecommons.org/licenses/by-sa/4.0/"))
      (img (@ (src "https://licensebuttons.net/l/by-sa/4.0/80x15.png")))))

(define (first-paragraph post)
  (let loop ((sxml (post-sxml post)))
    (match sxml
      (() '())
      (((and paragraph ('p . _)) . _)
       (list paragraph))
      ((head . tail)
       (cons head (loop tail))))))

(define nav
  `(nav
    (ul (li ,(link "Charli" "/")))
    (ul (li ,(link "About" "/about.html"))
        (li ,(link "Blog" "/blog.html")))))

(define footer
  `(footer (@ (class "text-center"))
           (p (@ (class "copyright"))
              "© 2026 Charli Allen"
              ,%cc-by-sa-button)
           (p "The text and images on this site are
free culture works available under the " ,%cc-by-sa-link " license.")
           (p "This website is built with "
              (a (@ (href "https://dthompson.us/projects/haunt.html"))
                 "Haunt")
              ", a static site generator written in "
              (a (@ (href "https://gnu.org/software/guile"))
                 "Guile Scheme")
              ".")))

(define charli-theme
  (theme #:name "charli"
         #:layout
         (lambda (site title body)
           `((doctype "html")
             (head
              (meta (@ (charset "utf-8")))
              (meta (@ (name "viewport")
                       (content "width=device-width, initial-scale=1")))
              (title ,(string-append title " — " (site-title site)))
              (link (@ (rel "alternate")
                       (type "application/atom+xml")
                       (title "Atom feed")
                       (href "/feed.xml")))
              ,(stylesheet "reset")
              ,(stylesheet "fonts")
              ,(stylesheet "charli"))
             (body
              (div (@ (class "container"))
                   ,nav
                   ,body
                   ,footer))))
         #:post-template
         (lambda (post)
           `((article (@ (class "h-entry"))
              (h1 (@ (class "p-name title")) ,(post-ref post 'title))
              (div (@ (class "date"))
                   (time (@ (class "dt-published")
                            (datetime ,(date->string (post-date post)
                                                     "~Y-~M-~d ~H:~m")))
                         ,(date->string (post-date post)
                                        "~B ~d, ~Y")))
              (div (@ (class "h-card author"))
                   (a (@ (class "u-url")
                         (href "/"))
                      "Charli Allen"))
              #;(div (@ (class "tags"))
                   "Tags:"
                   (ul ,@(map (lambda (tag)
                                `(li (a (@ (href ,(string-append "/feeds/tags/"
                                                                 tag ".xml")))
                                        ,tag)))
                              (assq-ref (post-metadata post) 'tags))))
              (div (@ (class "post"))
                   ,(post-sxml post)))))
         #:collection-template
         (lambda (site title posts prefix)
           (define (post-uri post)
             (string-append prefix "/" (site-post-slug site post) ".html"))

           `((h1 ,title
                 (a (@ (href "/feed.xml"))
                    (img (@ (class "feed-icon") (src "images/feed.png")))))
             ,(map (lambda (post)
                     (let ((uri (post-uri post)))
                       `(article (@ (class "summary"))
                                 (h2 (a (@ (href ,uri))
                                        ,(post-ref post 'title)))
                                 (div (@ (class "date"))
                                      ,(date->string (post-date post)
                                                     "~B ~d, ~Y"))
                                 (div (@ (class "post"))
                                      ,(first-paragraph post))
                                 (a (@ (href ,uri)) "read more →"))))
                   posts)))
         #:pagination-template
         (lambda (site body previous-page next-page)
           `(,@body
             (div (@ (class "paginator"))
                  ,(if previous-page
                       `(a (@ (class "paginator-prev") (href ,previous-page))
                           "← Newer")
                       '())
                  ,(if next-page
                       `(a (@ (class "paginator-next") (href ,next-page))
                           "Older →")
                       '()))))))

(define (flat-page-template site metadata body)
  ((theme-layout charli-theme) site (assq-ref metadata 'title) body))

(define (static-page title file-name body)
  (lambda (site posts)
    (serialized-artifact file-name
                         (with-layout charli-theme site title body)
                         sxml->html)))
