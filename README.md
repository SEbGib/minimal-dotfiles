# 🎨 Minimal Dotfiles Configuration

A clean, modern development environment setup for macOS and Linux with Neovim, tmux, Zsh, and essential productivity tools.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Chezmoi](https://img.shields.io/badge/managed%20with-chezmoi-blue)](https://www.chezmoi.io/)

---

## ⚠️ Before You Start

**IMPORTANT:** This repository contains **configuration templates**, not ready-to-use configs.

### Required Setup

1. **Personal Information** - Set environment variables:
   ```bash
   export GIT_USER_EMAIL="your@email.com"
   export GIT_USER_NAME="Your Name"
   export GITHUB_USERNAME="yourusername"
   ```

2. **SSH Keys** - Generate your own (never use someone else's):
   ```bash
   ssh-keygen -t ed25519 -C "your@email.com"
   ```

3. **Review Templates** - Check what will be installed:
   - See [INSTALLED_TOOLS.md](INSTALLED_TOOLS.md) for complete list
   - Review all `.tmpl` files before applying

4. **Test First** - Try in a VM before applying to your main system

---

## ✨ Features

- **🚀 One-Command Install** - Automated setup with chezmoi
- **🎨 Modern UI** - Coordinated theme (Neovim + tmux + Starship)
- **⚡ Performance** - Optimized configs with lazy loading
- **🌐 Cross-Platform** - macOS, Linux (Ubuntu, Arch)
- **🔒 Security-First** - No hardcoded secrets, secure by default
- **📦 Essential Tools** - Curated modern CLI toolkit
- **🔧 Optional Services** - n8n automation, MCP Memory (if needed)

---

## 📦 What's Included

### ✅ Core Tools
- **Neovim** - Modern text editor with LSP, autocomplete, file explorer
- **tmux** - Terminal multiplexer with custom keybindings
- **Zsh** - Modern shell with plugins (zsh-autosuggestions, syntax highlighting)
- **Starship** - Fast, customizable prompt
- **Modern CLI** - eza, bat, fzf, zoxide, ripgrep, fd

### ✅ Development Tools
- **Git** - Enhanced config with GPG signing, aliases
- **Docker** - Container development with lazydocker TUI
- **Languages** - Node.js, Python, PHP support
- **Database** - PostgreSQL client (rainfrog TUI)

### ⚠️ Optional Components
- **n8n** - Self-hosted automation platform (requires setup)
- **MCP Memory Service** - Persistent memory for AI tools (requires Claude Code)
- **Obsidian** - Knowledge management (optional install)

### ❌ Not Included
- Claude Code/OpenCode agents (these require proprietary tools)
- Custom automation workflows
- Session-specific documentation

---

## 🚀 Quick Start

### 1. Install Chezmoi + Dotfiles

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/YOUR_USERNAME/dotfiles.git
```

### 2. Configure Personal Info

```bash
# Add to ~/.zshrc or ~/.bashrc
export GIT_USER_EMAIL="your@email.com"
export GIT_USER_NAME="Your Name"
export GITHUB_USERNAME="yourusername"

# Apply changes
source ~/.zshrc
chezmoi apply --force
```

### 3. Generate SSH Keys

```bash
ssh-keygen -t ed25519 -C "your@email.com"
ssh-add ~/.ssh/id_ed25519
```

### 4. Verify Installation

```bash
# Quick test
./test-installation.sh --quick

# Full test
./test-installation.sh
```

---

## 📦 What Gets Installed

### Core Tools (30+)

| Tool | Category | Description |
|------|----------|-------------|
| **neovim** | Editor | Modern text editor (v0.11+) |
| **tmux** | Terminal | Terminal multiplexer |
| **zsh** | Shell | Z shell with Oh My Zsh |
| **starship** | Prompt | Cross-shell prompt |
| **fzf** | Search | Fuzzy finder |
| **ripgrep** | Search | Fast grep alternative |
| **bat** | Utils | Cat with syntax highlighting |
| **eza** | Utils | Modern ls replacement |
| **lazygit** | Git | Terminal UI for git |
| **gh** | Git | GitHub CLI |
| **glab** | Git | GitLab CLI |

### Development Environments

- **Node.js** - JavaScript/TypeScript runtime + npm
- **PHP** - PHP runtime + Composer + Symfony CLI
- **Python** - Python 3 + pipx for tools
- **Docker** - Container platform

### AI & Productivity

- **OpenCode Plugins** - 6 custom plugins (auto-router, project-switcher, etc.)
- **MCP Servers** - Context7, Memory Service (optional)
- **n8n** - Self-hosted automation platform (optional)

**Complete list:** See [INSTALLED_TOOLS.md](INSTALLED_TOOLS.md)

**Disk Usage:** ~1.4 GB  
**Installation Time:** 15-30 minutes

---

## 🎯 Key Configurations

### Neovim (LazyVim)

- **Version:** 0.11.2+ required
- **Distribution:** LazyVim
- **LSP Support:** TypeScript, PHP, Python, Go, Rust
- **Plugins:** 40+ pre-configured
- **Config:** `~/.config/nvim/`

### Zsh + Oh My Zsh

- **Plugins:** autosuggestions, syntax-highlighting, completions
- **Theme:** Starship (fast, customizable)
- **Config:** `~/.zshrc`

### Tmux

- **Prefix:** `Ctrl-a` (default)
- **Theme:** Rose Pine
- **Plugins:** tmux-resurrect, tmux-continuum
- **Config:** `~/.config/tmux/tmux.conf`

### Git

- **Delta:** Syntax-highlighting pager
- **Aliases:** 20+ productive shortcuts
- **Config:** `~/.gitconfig`

---

## 🔧 Customization

### Modify Configurations

```bash
# Edit any file
chezmoi edit ~/.zshrc

# See what changed
chezmoi diff

# Apply changes
chezmoi apply
```

### Add Your Own Files

```bash
# Add new file to dotfiles
chezmoi add ~/.config/yourfile

# Edit it
chezmoi edit ~/.config/yourfile

# Apply
chezmoi apply
```

### Update From Remote

```bash
# Pull latest changes
chezmoi update

# Or manually
chezmoi cd
git pull
exit
chezmoi apply
```

---

## 🔒 Security

### No Secrets Committed

✅ **This repository is public-safe:**
- No API keys
- No passwords
- No tokens
- No personal emails
- No private SSH keys

### How Secrets Are Handled

**Environment Variables (Recommended):**
```bash
# In ~/.zshrc
export GITHUB_TOKEN="your_token"
export OPENAI_API_KEY="your_key"
```

**Secure Permissions:**
- `private_*` files → mode 600 (owner only)
- `.ssh/` directory → mode 700
- `.env` files → mode 600

See [SECURITY.md](SECURITY.md) for complete security guidelines.

---

## 📚 Documentation

### Quick References

- **[INSTALLED_TOOLS.md](INSTALLED_TOOLS.md)** - Complete list of 70+ tools
- **[PLUGINS_START_HERE.md](PLUGINS_START_HERE.md)** - OpenCode plugins guide
- **[AUTO_ROUTER_GUIDE.md](AUTO_ROUTER_GUIDE.md)** - Auto-routing for agents
- **[KEYBINDS.md](KEYBINDS.md)** - Keyboard shortcuts reference

### Session Summaries

- **[SESSION_SUMMARY_2025-11-30.md](SESSION_SUMMARY_2025-11-30.md)** - Latest improvements

### Technical Docs

- **[SECURITY.md](SECURITY.md)** - Security policy and best practices
- **[AGENTS.md](AGENTS.md)** - OpenCode agent configuration
- **[BITWARDEN_BARRIER_REMOVAL.md](BITWARDEN_BARRIER_REMOVAL.md)** - Simplification history

---

## 🧪 Testing

### Quick Test (5 minutes)

```bash
./test-installation.sh --quick
```

### Full Test (15 minutes)

```bash
./test-installation.sh
```

### Test in Docker

```bash
docker run -it ubuntu:22.04
# Then run installation
```

---

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Areas for Contribution

- Additional tools/plugins
- Platform support (Fedora, Debian, etc.)
- Documentation improvements
- Bug fixes

---

## 📝 License

MIT License - See [LICENSE](LICENSE) for details.

Free to use, modify, and distribute.

---

## 🙏 Acknowledgments

### Inspiration & Tools

- [chezmoi](https://www.chezmoi.io/) - Dotfiles manager
- [LazyVim](https://www.lazyvim.org/) - Neovim distribution
- [Oh My Zsh](https://ohmyz.sh/) - Zsh framework
- [Starship](https://starship.rs/) - Cross-shell prompt

### Community

Thanks to all the open-source projects that make this possible!

---

## 📊 Stats

- **Files:** 200+ configuration files
- **Tools:** 70+ modern CLI tools
- **Plugins:** 6 custom OpenCode plugins
- **Documentation:** 10,000+ lines
- **Disk Usage:** ~1.4 GB
- **Last Updated:** November 30, 2025

---

## 🔗 Links

- **Documentation:** See `/docs` directory (if created)
- **Issues:** [GitHub Issues](https://github.com/YOUR_USERNAME/dotfiles/issues)
- **Security:** [SECURITY.md](SECURITY.md)

---

**⭐ If you find this useful, consider starring the repo!**

Made with ❤️ for the developer community
