#!/usr/bin/env bash
#
# Dotfiles installer — cross-OS (macOS + Linux), idempotent, safe to re-run.
#
# One-liner:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/jonogould/dotfiles/master/install.sh)"
#
# What it does:
#   1. Self-bootstraps: clones (or pulls) the repo into ~/.dotfiles, then re-execs.
#   2. Installs dependencies (Homebrew + Brewfile on macOS; apt/dnf/pacman on Linux).
#   3. Symlinks config files into $HOME, backing up any existing real files first.
#   4. Post-link setup: antidote, nvm, .env, zsh recompile, default shell.
#
# Optional non-interactive provisioning:
#   DOTFILES_PROFILE=/path/to/dotfiles.profile.yml bash -c "$(curl -fsSL …)"
# revives personal/employer-specific details (git identity, secrets, GOPRIVATE,
# aliases) from a private YAML profile. See dotfiles.profile.example.
#
set -euo pipefail

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
DOTFILES_DIR="$HOME/.dotfiles"
REPO_HTTPS_URL="https://github.com/jonogould/dotfiles.git"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$HOME/.dotfiles-backup-$TIMESTAMP"

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m %s\n' "$*" >&2; }
ok()    { printf '\033[1;32m  ✓\033[0m %s\n' "$*"; }

# ---------------------------------------------------------------------------
# 0. Self-bootstrap: ensure we are running from ~/.dotfiles
# ---------------------------------------------------------------------------
# Resolve the directory this script actually lives in (handles symlinks/curl).
resolve_script_dir() {
    local src="${BASH_SOURCE[0]:-}"
    if [[ -z "$src" || ! -f "$src" ]]; then
        # Running via `curl | bash` (no real file on disk).
        echo ""
        return 0
    fi
    while [[ -h "$src" ]]; do
        local dir
        dir="$(cd -P "$(dirname "$src")" >/dev/null 2>&1 && pwd)"
        src="$(readlink "$src")"
        [[ "$src" != /* ]] && src="$dir/$src"
    done
    cd -P "$(dirname "$src")" >/dev/null 2>&1 && pwd
}

SCRIPT_DIR="$(resolve_script_dir)"

if [[ "$SCRIPT_DIR" != "$DOTFILES_DIR" ]]; then
    info "Bootstrapping dotfiles into $DOTFILES_DIR"
    if [[ -d "$DOTFILES_DIR/.git" ]]; then
        info "Repo already present; pulling latest"
        git -C "$DOTFILES_DIR" pull --ff-only || warn "git pull failed; continuing with existing checkout"
    else
        if ! command -v git >/dev/null 2>&1; then
            warn "git is required to clone the repo but was not found."
            warn "Install git first, then re-run this installer."
            exit 1
        fi
        # Skip LFS smudge on clone so we pull pointers only (a few KB), not all
        # prebuilt binaries. setup_env later fetches just the host's binary.
        GIT_LFS_SKIP_SMUDGE=1 git clone "$REPO_HTTPS_URL" "$DOTFILES_DIR"
    fi
    ok "Repo ready at $DOTFILES_DIR"
    info "Re-executing installer from cloned repo"
    exec bash "$DOTFILES_DIR/install.sh" "$@"
fi

info "Running installer from $DOTFILES_DIR"

# ---------------------------------------------------------------------------
# 1. OS detection
# ---------------------------------------------------------------------------
OS="$(uname -s)"
info "Detected OS: $OS"

# ---------------------------------------------------------------------------
# 2. Dependency installation
# ---------------------------------------------------------------------------
install_macos_deps() {
    if ! command -v brew >/dev/null 2>&1; then
        info "Homebrew not found; installing"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Load brew into this shell for the rest of the run.
        if [[ -x /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        ok "Homebrew present"
    fi

    if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
        info "Installing Brewfile dependencies"
        brew bundle --file="$DOTFILES_DIR/Brewfile"
        ok "Brewfile complete"
    else
        warn "No Brewfile found at $DOTFILES_DIR/Brewfile; skipping brew bundle"
    fi
}

install_linux_deps() {
    # Maps logical deps to per-manager package names.
    # Logical set: git, git-lfs, zsh, go, jq, grc, curl
    if command -v apt-get >/dev/null 2>&1; then
        info "Installing dependencies via apt-get"
        sudo apt-get update
        sudo apt-get install -y git git-lfs zsh golang-go jq grc curl
        ok "apt-get dependencies installed"
    elif command -v dnf >/dev/null 2>&1; then
        info "Installing dependencies via dnf"
        sudo dnf install -y git git-lfs zsh golang jq grc curl
        ok "dnf dependencies installed"
    elif command -v pacman >/dev/null 2>&1; then
        info "Installing dependencies via pacman"
        sudo pacman -Sy --needed --noconfirm git git-lfs zsh go jq grc curl
        ok "pacman dependencies installed"
    else
        warn "No supported package manager found (apt-get/dnf/pacman)."
        warn "Install these manually: git git-lfs zsh go jq grc curl"
    fi
}

case "$OS" in
    Darwin) install_macos_deps ;;
    Linux)  install_linux_deps ;;
    *)      warn "Unsupported OS '$OS'; skipping dependency install" ;;
esac

# ---------------------------------------------------------------------------
# 3. Symlink map (with backup)
# ---------------------------------------------------------------------------
# Format: "<source relative to DOTFILES_DIR>:<absolute target>"
SYMLINKS=(
    "zsh/zshrc:$HOME/.zshrc"
    "git/gitconfig:$HOME/.gitconfig"
    "editorconfig/editorconfig:$HOME/.editorconfig"
    "ack/ackrc:$HOME/.ackrc"
)

link_file() {
    local src="$1" target="$2"

    if [[ ! -e "$src" ]]; then
        warn "Source missing, skipping: $src"
        return 0
    fi

    # Already the correct symlink? Nothing to do.
    if [[ -L "$target" && "$(readlink "$target")" == "$src" ]]; then
        ok "Already linked: $target"
        return 0
    fi

    # Anything else that exists at the target gets backed up first.
    if [[ -e "$target" || -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        info "Backing up existing $target -> $BACKUP_DIR/"
        mv "$target" "$BACKUP_DIR/"
    fi

    ln -sfn "$src" "$target"
    ok "Linked $target -> $src"
}

info "Linking config files"
for pair in "${SYMLINKS[@]}"; do
    src_rel="${pair%%:*}"
    target="${pair#*:}"
    link_file "$DOTFILES_DIR/$src_rel" "$target"
done

# ---------------------------------------------------------------------------
# 4. Post-link setup
# ---------------------------------------------------------------------------

# 4a. antidote + plugin manifest
#
# antidote comes from Homebrew on macOS (see Brewfile). On Linux (no brew) we
# fall back to a shallow git clone into ~/.antidote. Either way we generate the
# static ~/.zsh_plugins.zsh that zshrc sources. Guarded so it never aborts.
setup_antidote() {
    local antidote_zsh=""

    if command -v brew >/dev/null 2>&1; then
        # Homebrew-managed antidote (installed via `brew bundle`).
        local brew_antidote
        brew_antidote="$(brew --prefix antidote 2>/dev/null)/share/antidote/antidote.zsh"
        if [[ -f "$brew_antidote" ]]; then
            antidote_zsh="$brew_antidote"
            ok "antidote present (Homebrew)"
        else
            warn "antidote not found via Homebrew; did 'brew bundle' run?"
        fi
    else
        # Linux / no-Homebrew fallback: git clone into ~/.antidote (idempotent).
        if [[ ! -d "$HOME/.antidote" ]]; then
            info "Installing antidote into ~/.antidote (git clone fallback)"
            if git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"; then
                ok "antidote installed"
            else
                warn "antidote clone failed; continuing"
            fi
        else
            ok "antidote present (~/.antidote)"
        fi
        [[ -f "$HOME/.antidote/antidote.zsh" ]] && antidote_zsh="$HOME/.antidote/antidote.zsh"
    fi

    if [[ ! -f "$HOME/.zsh_plugins.txt" ]]; then
        info "Creating default ~/.zsh_plugins.txt"
        cat > "$HOME/.zsh_plugins.txt" <<'PLUGINS'
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
PLUGINS
        ok "Wrote ~/.zsh_plugins.txt"
    fi

    if [[ -z "$antidote_zsh" ]]; then
        warn "antidote.zsh not found; skipping ~/.zsh_plugins.zsh generation"
        return 0
    fi

    if command -v zsh >/dev/null 2>&1; then
        info "Generating ~/.zsh_plugins.zsh via antidote"
        if zsh -c "source '$antidote_zsh' && antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins.zsh"; then
            ok "Generated ~/.zsh_plugins.zsh"
        else
            warn "antidote bundle failed; ~/.zsh_plugins.zsh not generated"
        fi
    else
        warn "zsh not available; skipping antidote bundle"
    fi
    return 0
}
setup_antidote

# 4b. nvm (optional, guarded)
#
# nvm comes from Homebrew on macOS (see Brewfile); we only ensure the NVM_DIR
# data dir exists, since Homebrew's nvm requires ~/.nvm to be present. On Linux
# (no brew) we fall back to the upstream install script into ~/.nvm.
setup_nvm() {
    if command -v brew >/dev/null 2>&1; then
        # Homebrew-managed nvm: ensure the data dir exists for $NVM_DIR.
        mkdir -p "$HOME/.nvm" 2>/dev/null || warn "could not create ~/.nvm data dir"
        ok "nvm present (Homebrew); ensured ~/.nvm data dir"
        return 0
    fi

    # Linux / no-Homebrew fallback: install into ~/.nvm (idempotent).
    if [[ -d "$HOME/.nvm" ]]; then
        ok "nvm present (~/.nvm)"
        return 0
    fi
    info "Installing nvm into ~/.nvm (install-script fallback)"
    if curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash; then
        ok "nvm installed"
    else
        warn "nvm install failed (optional); continuing"
    fi
    return 0
}
setup_nvm

# 4c. .env setup
#
# Non-interactive fast path: if $DOTFILES_PROFILE points at a readable YAML
# profile, the prebuilt helper's `apply` mode regenerates all gitignored local
# files (git/identity.local, .env, zsh/local.zsh) from it and skips every
# prompt. See dotfiles.profile.example for the schema. Otherwise we fall back to
# the interactive walkthrough below.
#
# On an explicit "yes", a prebuilt Go TUI (scripts/envsetup/bin/
# envsetup-<os>-<arch>, stored in Git LFS) walks through each variable in
# .env.example and prompts for a value (offering the current/.env value or the
# template placeholder as the default, masking secret-looking keys). The binary
# reads /dev/tty so it works under `curl | bash`. We fetch only the single
# binary matching this host via `git lfs pull --include`, so a fresh install on
# e.g. a Raspberry Pi never downloads the other platforms' binaries. When run
# non-interactively (no tty), when the user declines, when no matching binary or
# git-lfs is available, or if the helper fails, we fall back to copying the
# template (.env.example -> .env only if missing). Guarded so it never aborts
# the `set -euo pipefail` run.

# Reserved exit code the helper uses to signal "non-interactive" (no tty).
ENVSETUP_NONINTERACTIVE=2

# Copy-template fallback: create .env from the template only if missing.
copy_env_template() {
    local example="$1" envfile="$2"
    if [[ -f "$envfile" ]]; then
        ok ".env already exists; leaving untouched"
    else
        cp "$example" "$envfile" && ok "Created .env from .env.example — fill in your secrets"
    fi
}

# Map uname -s / -m to the "<os>-<arch>" suffix used for the prebuilt binaries.
envsetup_platform() {
    local os arch
    case "$(uname -s)" in
        Darwin) os=darwin ;;
        Linux)  os=linux ;;
        *) return 1 ;;
    esac
    case "$(uname -m)" in
        x86_64|amd64)  arch=amd64 ;;
        arm64|aarch64) arch=arm64 ;;
        *) return 1 ;;
    esac
    printf '%s-%s' "$os" "$arch"
}

# True if the file is missing or is still an unresolved Git LFS pointer.
envsetup_needs_pull() {
    local f="$1"
    [[ ! -f "$f" ]] && return 0
    head -c 100 "$f" 2>/dev/null | grep -q "git-lfs.github.com"
}

# Fetch (if needed) and print the path to this host's prebuilt envsetup binary.
# Only the matching binary is pulled from LFS. All status output goes to stderr
# so the path is the sole stdout; returns non-zero if it can't be made ready.
ensure_envsetup_bin() {
    local platform rel bin
    if ! platform="$(envsetup_platform)"; then
        warn "Unsupported platform $(uname -s)/$(uname -m)"
        return 1
    fi
    rel="scripts/envsetup/bin/envsetup-$platform"
    bin="$DOTFILES_DIR/$rel"

    # Fetch ONLY this host's binary from LFS if it's missing or still a pointer.
    if envsetup_needs_pull "$bin"; then
        if git lfs version >/dev/null 2>&1; then
            info "Fetching env helper binary via Git LFS ($rel)" >&2
            git -C "$DOTFILES_DIR" lfs pull --include="$rel" >/dev/null 2>&1 \
                || warn "git lfs pull failed for $rel"
        else
            warn "git-lfs unavailable; cannot fetch the env helper binary"
        fi
    fi

    if envsetup_needs_pull "$bin"; then
        warn "Env helper binary unavailable ($rel)"
        return 1
    fi

    chmod +x "$bin" 2>/dev/null || true
    printf '%s' "$bin"
}

# Profile-driven, non-interactive provisioning. Regenerates the gitignored
# local files (git/identity.local, .env, zsh/local.zsh) from a private YAML
# profile via the prebuilt helper. Returns non-zero on any failure so the
# caller can fall back to the interactive flow.
apply_profile() {
    local profile="$1" bin
    if ! bin="$(ensure_envsetup_bin)"; then
        return 1
    fi
    info "Applying profile (non-interactive): $profile"
    if DOTFILES="$DOTFILES_DIR" "$bin" apply "$profile"; then
        ok "Provisioned local files from profile"
        return 0
    fi
    warn "Profile apply failed"
    return 1
}

setup_env() {
    local example="$DOTFILES_DIR/.env.example"
    local envfile="$DOTFILES_DIR/.env"

    if [[ ! -f "$example" ]]; then
        warn "No .env.example found; skipping .env creation"
        return 0
    fi

    # Profile-driven provisioning takes precedence: when $DOTFILES_PROFILE points
    # at a readable YAML file, regenerate all local files from it non-interactively
    # (no prompts, no wizard). Falls through to the interactive flow on failure.
    if [[ -n "${DOTFILES_PROFILE:-}" ]]; then
        if [[ -r "$DOTFILES_PROFILE" ]]; then
            if apply_profile "$DOTFILES_PROFILE"; then
                return 0
            fi
            warn "Falling back from profile to interactive/template setup"
        else
            warn "DOTFILES_PROFILE set but not readable: $DOTFILES_PROFILE"
        fi
    fi

    # Ask once whether to run the interactive walkthrough at all (default No).
    # If there's no usable terminal (CI / piped stdin with no /dev/tty), don't
    # hang — fall straight back to the copy-template behavior.
    if [[ ! -t 0 ]] && ! { [[ -r /dev/tty ]] && { exec 3</dev/tty; } 2>/dev/null; }; then
        warn "Non-interactive shell; skipping env var prompts"
        copy_env_template "$example" "$envfile"
        return 0
    fi
    exec 3<&- 2>/dev/null || true  # close the probe fd if we opened it

    local answer=""
    printf '\033[1;34m==>\033[0m %s' "Configure environment variables now? [y/N] " >/dev/tty
    read -r answer </dev/tty || answer=""
    case "$answer" in
        [Yy]|[Yy][Ee][Ss]) : ;;  # proceed to the helper
        *)
            info "Skipping interactive env setup"
            copy_env_template "$example" "$envfile"
            return 0
            ;;
    esac

    # Fetch this host's prebuilt binary (LFS) for the interactive walkthrough.
    local bin
    if ! bin="$(ensure_envsetup_bin)"; then
        warn "Falling back to template copy"
        copy_env_template "$example" "$envfile"
        return 0
    fi

    info "Launching env helper"
    local rc=0
    DOTFILES="$DOTFILES_DIR" "$bin" "$example" "$envfile" || rc=$?
    if [[ "$rc" -eq 0 ]]; then
        ok "Environment variables configured"
    elif [[ "$rc" -eq "$ENVSETUP_NONINTERACTIVE" ]]; then
        warn "Env helper reported no interactive terminal; falling back to template copy"
        copy_env_template "$example" "$envfile"
    else
        warn "Env helper exited $rc; falling back to template copy"
        copy_env_template "$example" "$envfile"
    fi
    return 0
}
setup_env

# 4d. Recompile zsh files
recompile_zsh() {
    if command -v zsh >/dev/null 2>&1 && [[ -f "$DOTFILES_DIR/zsh/compile.zsh" ]]; then
        info "Recompiling zsh files"
        zsh "$DOTFILES_DIR/zsh/compile.zsh" || warn "zsh recompile reported an error; continuing"
    else
        warn "zsh or compile.zsh unavailable; skipping recompile"
    fi
}
recompile_zsh

# 4e. Default shell -> zsh (only if safe)
set_default_shell() {
    local zsh_path
    zsh_path="$(command -v zsh || true)"
    if [[ -z "$zsh_path" ]]; then
        warn "zsh not installed; cannot set default shell"
        return 0
    fi
    if [[ "${SHELL:-}" == "$zsh_path" ]]; then
        ok "Default shell already zsh"
        return 0
    fi
    if grep -qxF "$zsh_path" /etc/shells 2>/dev/null; then
        info "Setting default shell to $zsh_path"
        chsh -s "$zsh_path" || warn "chsh failed; change your shell manually"
    else
        warn "$zsh_path not in /etc/shells; skipping chsh"
    fi
}
set_default_shell

info "Dotfiles installation complete."
info "Restart your shell (or run: exec zsh) to apply changes."
