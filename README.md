# Charli's Blog

The source for Charli's personal blog, built with [Haunt](https://dthompson.us/projects/haunt.html), a static-site generator written in Guile Scheme.

Posts live in `src/site/posts/`; pages, the theme, and static assets live alongside them in `src/site/`.  The generated site is intentionally not committed.

## Guix channel

This repository is also a Guix channel.  It exports the
`charliallen-github-io` package from the `(packages charliallen)` module.  Add it to
`~/.config/guix/channels.scm` alongside the default channels:

```scheme
(cons (channel
       (name 'charliallen)
       (url "https://github.com/charliallen/charliallen.github.io.git")
       (introduction
        (make-channel-introduction
         "4682bffef951b247d4d5f47bb213d33caa9a3dc4"
         (openpgp-fingerprint
          "5B7C EEC8 8CEF 9EE0 3352 7917 88EB B04F ED20 ECB6"))))
      %default-channels)
```

The introduction anchors the channel at its first channel commit and requires
subsequent commits to be signed by Charli Allen's OpenPGP key.  Then run
`guix pull`; the package is available as `charliallen-github-io`.
During development from this checkout, use `-L env/guix` to expose the
module to Guix.

## Building

The project uses Guix for its development environment.  From the repository root:

```sh
make build
```

For iterative work, run Haunt from the directory containing its configuration:

```sh
cd src/site
guix shell -m ../../env/guix/manifest.scm -- haunt build -c haunt.scm
```

Unless stated otherwise, site content is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).

## Deploying

The site is built on your machine and the generated files are force-pushed to
the `gh-pages` branch.  This avoids installing and updating Guix on a GitHub
Actions runner.

After committing the site source and its Guix configuration, create the
deployment branch with:

```sh
make deploy
```

Then configure **Settings → Pages → Build and deployment → Source** as
**Deploy from a branch**, and select the newly-created `gh-pages` branch and
the `/(root)` folder.  Future deployments use the same command.

The command uses the Guix build defined by `env/guix/guix.scm`, creates a temporary Git
worktree, and replaces only the remote `gh-pages` branch.  It never changes
your current branch or working tree.
