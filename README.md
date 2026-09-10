# Charli's Blog

The source for Charli's personal blog, built with [Haunt](https://dthompson.us/projects/haunt.html), a static-site generator written in Guile Scheme.

Posts live in `src/site/posts/`; pages, the theme, and static assets live alongside them in `src/site/`.  The generated site is intentionally not committed.

## Building

The project uses Guix for its development environment.  From the repository root:

```sh
make build
```

For iterative work, run Haunt from the directory containing its configuration:

```sh
cd src/site
guix shell -m ../../manifest.scm -- haunt build -c haunt.scm
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

The command uses the Guix build defined by `guix.scm`, creates a temporary Git
worktree, and replaces only the remote `gh-pages` branch.  It never changes
your current branch or working tree.
