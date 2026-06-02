<div align="center">

# 🛠️ .dotfiles

### One command. Any machine. A beautiful shell. ✨

*Cross-platform dotfiles that bootstrap a fresh **macOS** or **Linux** box —
from zero to a fully wired Zsh in a single paste.*

<br />

![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Zsh](https://img.shields.io/badge/Zsh-1A2C34?style=for-the-badge&logo=gnubash&logoColor=4EAA25)
![Go](https://img.shields.io/badge/Go_1.25-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![Bubble Tea](https://img.shields.io/badge/Bubble%20Tea-FF75B7?style=for-the-badge&logo=charm&logoColor=white)
![Git LFS](https://img.shields.io/badge/Git%20LFS-F64935?style=for-the-badge&logo=git&logoColor=white)

</div>

---

## 🚀 Quick start

> [!TIP]
> Fresh machine? This is the only command you need. It bootstraps **everything**.

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jonogould/dotfiles/master/install.sh)"
```

That's it. ☕ The installer clones this repo to `~/.dotfiles` (over HTTPS — **no
SSH keys required**), re-execs itself from there, and is **100% safe to re-run**.

---

## ✨ Highlights

| | |
| --- | --- |
| 🖥️ **Cross-OS** | One installer, identical result on macOS & Linux |
| 🔁 **Idempotent** | Re-run anytime — it heals drift and never clobbers your secrets |
| 🧳 **Auto-backup** | Existing files are stashed in a timestamped folder before linking |
| 🎨 **Gorgeous `.env` wizard** | A Bubble Tea TUI walks you through your secrets |
| 🪶 **Featherweight clone** | Git LFS pulls *only* the binary your CPU needs |
| 🍓 **Raspberry-Pi friendly** | No bloated downloads, no Go required at install |

---

## 📦 What `install.sh` does

```mermaid
flowchart LR
    A[📥 Bootstrap clone] --> B[🧱 Install deps]
    B --> C[🔗 Symlink configs]
    C --> D[⚙️ Post-link setup]
    D --> E[🐚 Set Zsh default]
```

1. **🥾 Self-bootstrap** — clones the repo to `~/.dotfiles` (or `git pull`s if it
   already exists), then re-runs from the cloned copy.
2. **🧱 Dependencies**
   - 🍎 **macOS** — installs [Homebrew](https://brew.sh) if missing, then
     `brew bundle` from the [`Brewfile`](Brewfile).
   - 🐧 **Linux** — detects `apt-get` / `dnf` / `pacman` and installs
     `git git-lfs zsh go jq grc curl`.
3. **🔗 Symlinks** — links config files into `$HOME`. Any existing real file is
   moved to `~/.dotfiles-backup-<timestamp>/` first, then replaced with a
   symlink (`ln -sfn`).
4. **⚙️ Post-link setup**
   - 🔌 [antidote](https://github.com/mattmc3/antidote) — from Homebrew on macOS
     (it's in the [`Brewfile`](Brewfile)); on Linux without Homebrew it falls
     back to a git clone into `~/.antidote`. Either way it regenerates
     `~/.zsh_plugins.zsh` (from `~/.zsh_plugins.txt`).
   - 📦 [nvm](https://github.com/nvm-sh/nvm) — from Homebrew on macOS (the
     installer just ensures the `~/.nvm` data dir exists); on Linux without
     Homebrew it falls back to the upstream install script into `~/.nvm`.
   - 🔐 **`.env` wizard** — see [Secrets](#-secrets--env) below.
   - ⚡ Recompiles zsh files via [`zsh/compile.zsh`](zsh/compile.zsh).
   - 🐚 Sets Zsh as the default shell (only if it's listed in `/etc/shells`).

---

## 🗺️ Symlink map

| 📄 Source (in repo)           | 🎯 Target         |
| ----------------------------- | ----------------- |
| `zsh/zshrc`                   | `~/.zshrc`        |
| `git/gitconfig`               | `~/.gitconfig`    |
| `editorconfig/editorconfig`   | `~/.editorconfig` |
| `ack/ackrc`                   | `~/.ackrc`        |

---

## 🔐 Secrets / `.env`

API keys for AI tooling are sourced by [`zsh/ai.zsh`](zsh/ai.zsh) from
`~/.dotfiles/.env` — which is **🙈 gitignored and never committed.**

When run interactively, the installer launches a prebuilt **Bubble Tea TUI**
([`scripts/envsetup`](scripts/envsetup)) that walks you through each variable:

- ⌨️ Pre-fills the existing/template value — just hit **Enter** to keep it.
- 🕶️ **Masks** secret-looking keys (`*TOKEN*`, `*KEY*`, `*SECRET*`, …) as you type.
- 💾 Writes `.env` **atomically** with `0600` perms.
- 🪄 Works even under `curl | bash` because it reads from `/dev/tty`.

> [!NOTE]
> When run non-interactively (CI / no tty), if you decline the prompt, or if
> git-lfs / the matching binary is unavailable, it gracefully falls back to
> copying the template **only if `.env` is missing** — so you can fill it in by hand:

```sh
cp ~/.dotfiles/.env.example ~/.dotfiles/.env
$EDITOR ~/.dotfiles/.env
```

🔑 Keys: `GOCODE_API_TOKEN` · `OPENAI_API_KEY` · `BITRISE_PAT`

---

## 🎨 The `.env` wizard (`scripts/envsetup`)

The interactive wizard is a tiny Go program built with the **v2**
[Charm](https://charm.land) stack — [Bubble Tea](https://github.com/charmbracelet/bubbletea),
[Bubbles](https://github.com/charmbracelet/bubbles), and
[Lip Gloss](https://github.com/charmbracelet/lipgloss).

Prebuilt binaries for `darwin` / `linux` × `amd64` / `arm64` live under
[`scripts/envsetup/bin/`](scripts/envsetup/bin) and are tracked with **Git LFS**:

- 🪶 A fresh clone / bootstrap uses `GIT_LFS_SKIP_SMUDGE=1` and pulls only LFS
  pointers (a few **KB**).
- 🎯 The installer then `git lfs pull --include`s **just the one binary** for the
  current host — a Raspberry Pi never downloads the other platforms' builds.

### 🔧 Rebuilding (maintainers)

Built with the pinned Go toolchain `go1.25.11` (auto-downloaded via the
`toolchain` directive). After editing `scripts/envsetup/main.go` or its deps:

```sh
./scripts/envsetup/build.sh   # 🏗️  cross-compiles all four targets into bin/
git add scripts/envsetup/bin  # 📦  LFS-tracked via .gitattributes
git commit
```

> [!IMPORTANT]
> Contributors need Git LFS installed once: `git lfs install`.

---

## 🔄 Re-running / updating

The installer is **idempotent** — re-running pulls the latest repo, re-links
anything that drifted (backing up first), and re-runs post-link setup **without
clobbering your `.env`.** To update later:

```sh
bash ~/.dotfiles/install.sh
```

---

## ⚡ Zsh recompile

`.zwc` files are compiled bytecode that speed up shell startup. They're
gitignored and regenerated automatically during install. After editing any
`.zsh` file, recompile:

```sh
zsh ~/.dotfiles/zsh/compile.zsh
```

---

<div align="center">

**Built with 🐚 Zsh, 🐹 Go, and a lot of ☕.**

</div>
