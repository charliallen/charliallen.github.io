# Charli's Website!

Hello, welcome to my website. Eventually this will be cooler but it turns out building pages with a cursed setup is difficult.

## Information

- Pronouns: she/her, or it/its if you're not a coward
- Graduated from UCI with a BS in physics
- Self-taught programmer
- Fan of scheme and guix
- Willing to stare into the unblinking eye of infinity until it blinks
- Currently working at Red Hat

## Links

- [GitHub Account](https://github.com/charliallen)
- [My public zettelkasten](https://charliallen.github.io/zettelkasten)


Unless stated otherwise this site is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)

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
