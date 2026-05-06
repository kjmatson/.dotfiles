# dotfiles

Personal configuration files managed with a bare git repository.
No symlinks, no extra tooling — just git.

---

## How it works

`~/.dotfiles` is a bare git repo. The home directory (`~`) is used as the
working tree. A `config` alias wraps git with the correct flags so you can
manage dotfiles from anywhere without affecting other git repos.

---

## Setting up a new computer

### 1. Install prerequisites

Make sure `git` and `fish` are installed before continuing.

### 2. Set up SSH authentication

Generate an SSH key and add it to GitHub so you never have to enter credentials.

```bash
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub
```

Copy the output, then go to:
**GitHub → Settings → SSH and GPG keys → New SSH key** → paste and save.

Test it:

```bash
ssh -T git@github.com
```

You should see: `Hi kjmatson! You've successfully authenticated...`

### 3. Clone the bare repo

```bash
git clone --bare git@github.com:kjmatson/.dotfiles.git $HOME/.dotfiles
```

### 4. Set up the `config` alias temporarily

In your current shell session:

```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

### 5. Check out your dotfiles

```bash
config checkout
```

> If you see errors about existing files being overwritten, back them up first:
> ```bash
> mkdir -p ~/.dotfiles-backup
> config checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | \
>   xargs -I{} mv $HOME/{} $HOME/.dotfiles-backup/{}
> config checkout
> ```

### 6. Hide untracked files

Prevents `config status` from showing every file in your home directory:

```bash
config config --local status.showUntrackedFiles no
```

### 7. Add the alias permanently to fish

```bash
echo "alias config='/usr/bin/git --git-dir=\$HOME/.dotfiles --work-tree=\$HOME'" \
  >> ~/.config/fish/config.fish
```

Reload fish:

```bash
source ~/.config/fish/config.fish
```

---

## Daily usage

| Command | Description |
|---|---|
| `config status` | See tracked files with changes |
| `config add ~/.config/foo/bar` | Start tracking or stage a file |
| `config commit -m "message"` | Commit changes |
| `config push` | Push to GitHub |
| `config pull` | Pull latest from GitHub |
| `config diff` | See unstaged changes |

## Tracking a new file

```bash
config add ~/.config/someapp/config
config commit -m "add someapp config"
config push
```

Only explicitly added files are tracked — your home directory is not
committed wholesale.
