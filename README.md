# dotfiles

System configurations, now managed with [chezmoi]("http://www.chezmoi.io").

## New system setup

chezmoi can be installed into `~/.local/bin/chezmoi` and dotfiles can
be applied on an empty machine with a single command:

```bash
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply https://github.com/mrichardson03/dotfiles.git
```

chezmoi can also be [installed via a package manager](https://www.chezmoi.io/install/).

Once installed, updating dotfiles can be performed via a single command:

```bash
chezmoi update
```
