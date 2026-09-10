(define-module (packages charliallen)
  #:use-module (guix build-system copy)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages guile-xyz)
  #:export (charliallen-github-io))

;; Limit the source checkout to files under version control, per
;; https://guix.gnu.org/cookbook/en/html_node/Building-with-Guix.html
(define vcs-file?
  (or (git-predicate (dirname (dirname (dirname (current-source-directory)))))
      (const #t)))                     ;not in a Git checkout

(define-public charliallen-github-io
  (package
    (name "charliallen-github-io")
    (version "0.1.0-git")
    ;; This module lives in env/guix/packages/, so ../../.. is the channel root.
    (source (local-file "../../.." "charliallen-github-io-checkout"
                        #:recursive? #t
                        #:select? vcs-file?))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan #~'(("target/" "www/site"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'build-site
            (lambda _
              (with-directory-excursion "src/site"
                (invoke "haunt" "build")))))))
    (native-inputs (list haunt))
    (synopsis "Charli Allen's personal website")
    (description "Static site for charliallen.github.io, built with Haunt.")
    (home-page "https://charliallen.github.io")
    (license license:gpl3+)))

;; Keep this usable with `guix build -f` as well as from the channel.
charliallen-github-io
