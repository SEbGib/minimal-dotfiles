# Installation Guide

Complete installation guide for minimal-dotfiles on macOS and Linux.

## Prerequisites

### Required
- **macOS 12+** or **Linux** (Ubuntu 20.04+, Arch, Debian)
- **Git** - For cloning the repository
- **curl** or **wget** - For downloading chezmoi
- **sudo access** - For installing system packages

### Recommended
- **Homebrew** (macOS) or **apt/pacman** (Linux)
- **1GB+ free disk space**
- **Internet connection** for downloading tools

---

## Quick Install

### One-Line Install

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply SEbGib/minimal-dotfiles
```

### Manual Install

```bash
# 1. Install chezmoi
curl -sfL https://git.io/chezmoi | sh

# 2. Initialize and apply
chezmoi init --apply SEbGib/minimal-dotfiles

# 3. Review changes (optional)
chezmoi diff
```

---

## Step-by-Step Installation

### 1. Fork This Repository

Click "Fork" on GitHub to create your own copy.

### 2. Set Environment Variables

Before running chezmoi, set your personal information:

```bash
export GIT_USER_EMAIL="your@email.com"
export GIT_USER_NAME="Your Name"
export GITHUB_USERNAME="yourusername"
```

**Permanent Setup** (add to ~/.zshrc or ~/.bashrc):
```bash
echo 'export GIT_USER_EMAIL="your@email.com"' >> ~/.zshrc
echo 'export GIT_USER_NAME="Your Name"' >> ~/.zshrc
echo 'export GITHUB_USERNAME="yourusername"' >> ~/.zshrc
source ~/.zshrc
```

### 3. Review Templates

Check what will be installed:
```bash
# List files that will be created
chezmoi managed

# Preview changes without applying
chezmoi diff
```

### 4. Apply Configuration

```bash
# Apply all configurations
chezmoi apply

# Apply specific file
chezmoi apply ~/.zshrc

# Apply with verbose output
chezmoi apply -v
```

### 5. Install Tools

After applying configs, install the tools:

```bash
# macOS
brew bundle --file=~/.config/brewfile

# Linux (Ubuntu/Debian)
sudo apt update && sudo apt install -y \
  zsh tmux neovim git curl wget \
  build-essential ripgrep fd-find bat eza fzf zoxide

# Arch Linux
sudo pacman -S zsh tmux neovim git curl wget \
  base-devel ripgrep fd bat eza fzf zoxide
```

---

## Optional Components

### n8n Automation Platform

Self-hosted automation (like Zapier):

```bash
# Skip during initial install
chezmoi apply --exclude scripts/run_once_18-install-n8n.sh.tmpl

# Install later if needed
~/.local/share/chezmoi/run_once_18-install-n8n.sh.tmpl
```

**Requires:** Docker installed and running

### MCP Memory Service

Persistent memory for AI tools (requires Claude Code):

```bash
# Skip during initial install
chezmoi apply --exclude scripts/run_once_19-install-mcp-memory-service.sh.tmpl

# Install later if needed (requires Claude Code)
~/.local/share/chezmoi/run_once_19-install-mcp-memory-service.sh.tmpl
```

### Obsidian Knowledge Base

Optional note-taking app:

```bash
# Skip during install
chezmoi apply --exclude scripts/run_once_16-install-obsidian.sh.tmpl
```

---

## Troubleshooting

### Chezmoi Not Found

```bash
# Add to PATH
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Permission Denied

```bash
# Make scripts executable
chmod +x ~/.local/share/chezmoi/run_once_*.sh
```

### Git Authentication Failed

```bash
# Use HTTPS instead of SSH
chezmoi init https://github.com/YOUR_USERNAME/minimal-dotfiles.git
```

### Templates Not Rendering

Ensure environment variables are set:
```bash
echo $GIT_USER_EMAIL  # Should print your email
echo $GIT_USER_NAME   # Should print your name
```

If empty, set them and re-apply:
```bash
export GIT_USER_EMAIL="your@email.com"
chezmoi apply --force
```

### Tool Installation Fails

**macOS:**
```bash
# Update Homebrew
brew update && brew upgrade

# Reinstall if needed
brew reinstall PACKAGE_NAME
```

**Linux:**
```bash
# Update package lists
sudo apt update

# Fix broken dependencies
sudo apt --fix-broken install
```

### Neovim LSP Not Working

```bash
# Install language servers manually
:LspInstall typescript
:LspInstall lua
:LspInstall python

# Check health
:checkhealth
```

---

## Uninstallation

### Remove Configurations

```bash
# Remove chezmoi and configs
chezmoi purge

# Manual cleanup
rm -rf ~/.local/share/chezmoi
rm -rf ~/.config/chezmoi
```

### Restore Backups

Chezmoi creates backups in `~/.local/share/chezmoi/backups/`:

```bash
# List backups
ls -la ~/.local/share/chezmoi/backups/

# Restore a file
cp ~/.local/share/chezmoi/backups/DOT_FILE ~/ORIGINAL_LOCATION
```

---

## Next Steps

After installation:

1. **Restart your terminal** - Load new configurations
2. **Test tools** - Run `nvim`, `tmux`, verify modern CLI tools
3. **Customize** - Edit configs in `~/.local/share/chezmoi/`
4. **Update** - Run `chezmoi update` to pull latest changes

---

## Getting Help

- **Documentation**: See [TOOLS.md](TOOLS.md) for tool list
- **Security**: See [SECURITY.md](SECURITY.md) for security best practices
- **Secrets**: See [SECURE_SECRETS_SETUP.md](SECURE_SECRETS_SETUP.md) for Bitwarden setup
- **Issues**: Report bugs at GitHub Issues
