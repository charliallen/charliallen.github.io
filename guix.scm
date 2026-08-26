(use-modules (guix packages)
             (guix gexp)
             (guix utils)
             (guix git-download)
             (guix build-system copy)
             ((guix licenses) #:prefix license:)
             (gnu packages guile-xyz))

;; Limit the source checkout to files under version control, per
;; https://guix.gnu.org/cookbook/en/html_node/Building-with-Guix.html
(define vcs-file?
  (or (git-predicate (current-source-directory))
      (const #t)))                     ;not in a Git checkout

(package
  (name "charliallen-github-io")
  (version "0.1.0-git")
  (source (local-file "." "charliallen-github-io-checkout"
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
              (invoke "haunt" "build" "-c" "haunt.scm")))))))
  (native-inputs (list haunt))
  (synopsis "Charli Allen's personal website")
  (description "Static site for charliallen.github.io, built with Haunt.")
  (home-page "https://charliallen.github.io")
  (license license:gpl3+))
