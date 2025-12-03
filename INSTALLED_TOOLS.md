# 📦 Installed Tools - Complete List

**Generated:** November 30, 2025  
**Dotfiles Version:** Latest  
**Author:** Your Name

---

## 🎯 Quick Summary

Total categories: **8**  
Estimated tools: **70+**

### By Category

- **Core CLI Tools:** 30+ tools
- **Development Environments:** 5 languages/platforms
- **Version Control:** 4 tools
- **AI/CLI Tools:** 3 tools
- **Databases:** 1 TUI
- **System Monitoring:** 5 tools
- **File Management:** 4 tools
- **Terminal/Shell:** 6 tools

---

## 🛠️ Core CLI Tools (01b - Core Tools)

### macOS (via Homebrew)

| Tool | Category | Description |
|------|----------|-------------|
| **neovim** | Editor | Modern Vim-based text editor (v0.11+) |
| **tmux** | Terminal | Terminal multiplexer |
| **git** | VCS | Version control system |
| **git-delta** | VCS | Syntax-highlighting pager for git |
| **gh** | VCS | GitHub CLI |
| **glab** | VCS | GitLab CLI |
| **starship** | Shell | Cross-shell prompt |
| **zoxide** | Navigation | Smarter cd command |
| **fzf** | Search | Fuzzy finder |
| **ripgrep** | Search | Fast grep alternative (rg) |
| **fd** | Search | Fast find alternative |
| **bat** | Utils | Cat with syntax highlighting |
| **eza** | Utils | Modern ls replacement |
| **yazi** | File Manager | Terminal file manager |
| **jq** | Utils | JSON processor |
| **btop** | Monitoring | Modern resource monitor |
| **htop** | Monitoring | Interactive process viewer |
| **gitui** | VCS | Terminal UI for git |
| **tldr** | Docs | Simplified man pages |
| **scc** | Dev | Code counter |
| **httpie** | Network | User-friendly HTTP client |
| **dust** | Utils | Disk usage analyzer |
| **duf** | Utils | Disk usage/free utility |
| **procs** | Monitoring | Modern ps replacement |
| **age** | Security | File encryption tool |
| **gnupg** | Security | GNU Privacy Guard |

### Linux (via apt/manual install)

**Base packages (apt):**
- `tmux`, `git`, `curl`, `wget`, `unzip`
- `build-essential`, `jq`, `python3`, `python3-pip`
- `software-properties-common`, `apt-transport-https`, `ca-certificates`
- `fzf`, `ripgrep`, `fd-find`, `bat`, `htop`, `httpie`
- `gh`, `gnupg2`, `golang-go`, `file`

**Manual installs (GitHub releases):**
- **Neovim v0.11.2** - From GitHub releases
- **glab** - GitLab CLI from releases
- **yazi** - Terminal file manager from releases
- **eza** - Modern ls (parallel download)
- **bat** - Cat alternative (parallel download)
- **fd** - Find alternative (parallel download)
- **delta** - Git diff pager (parallel download)

---

## 💻 Development Environments (01c - Dev Tools)

### Node.js Ecosystem

| Package | Type | Purpose |
|---------|------|---------|
| **node** | Runtime | Node.js LTS |
| **npm** | Package Manager | Node package manager |
| **typescript** | Language | TypeScript compiler |
| **ts-node** | Runtime | TypeScript execution |
| **@types/node** | Types | Node.js type definitions |
| **eslint** | Linter | JavaScript linter |
| **prettier** | Formatter | Code formatter |
| **nodemon** | Dev Tool | Auto-restart on changes |
| **pm2** | Process Manager | Production process manager |
| **yarn** | Package Manager | Alternative to npm |
| **@anthropic-ai/claude-code** | AI | Claude Code CLI |

**NPM Config:**
- Global prefix: `~/.npm-global`
- User-level installations (no sudo)

### PHP Ecosystem

| Tool | Purpose |
|------|---------|
| **php** | PHP runtime |
| **php-cli** | PHP command-line |
| **php-mbstring** | Multibyte string extension |
| **php-xml** | XML extension |
| **php-zip** | ZIP extension |
| **php-curl** | cURL extension |
| **composer** | PHP package manager |
| **symfony-cli** | Symfony CLI tool |

### Python Ecosystem

**Linux (via pipx - PEP 668 compliant):**
- **black** - Code formatter
- **flake8** - Linter
- **mypy** - Type checker
- **pytest** - Testing framework (via apt)
- **requests** - HTTP library (via apt)
- **pynvim** - Neovim Python support (via apt)

**macOS (via pip --user):**
- Same tools as Linux, installed via pip

**PATH:** `~/.local/bin` for pipx tools

### Docker

| Component | Description |
|-----------|-------------|
| **docker-ce** | Docker Community Edition |
| **docker-ce-cli** | Docker CLI |
| **containerd.io** | Container runtime |
| **docker-compose-plugin** | Docker Compose v2 |

**Note:** User added to `docker` group (requires logout/login)

---

## 📥 Downloaded Tools (01d - GitHub Releases)

### Installed via Scripts

| Tool | Source | Description |
|------|--------|-------------|
| **starship** | starship.rs | Cross-shell prompt |
| **lazygit** | GitHub | Terminal UI for git |
| **lazydocker** | GitHub | Terminal UI for Docker |
| **rainfrog** | GitHub/Cargo | Database TUI client |
| **chezmoi** | get.chezmoi.io | Dotfiles manager |

**Download Strategy:**
- Parallel downloads (max 3 concurrent)
- Retry mechanism (3 attempts)
- Automatic extraction and installation

---

## 🔧 Shell & Terminal

| Tool | Type | Description |
|------|------|-------------|
| **zsh** | Shell | Z shell (default) |
| **oh-my-zsh** | Framework | Zsh configuration framework |
| **starship** | Prompt | Cross-shell prompt |
| **tmux** | Multiplexer | Terminal multiplexer |
| **ghostty** | Emulator | Modern terminal emulator |
| **fzf** | Fuzzy Finder | Command-line fuzzy finder |

**Zsh Plugins:**
- zsh-autosuggestions
- zsh-syntax-highlighting
- zsh-completions

---

## 🗄️ Database Tools

| Tool | Databases Supported | Description |
|------|---------------------|-------------|
| **rainfrog** | PostgreSQL, MySQL, SQLite | Terminal UI database client |

---

## 📊 Monitoring & System Tools

| Tool | Category | Purpose |
|------|----------|---------|
| **btop** | Monitor | Modern resource monitor |
| **htop** | Monitor | Interactive process viewer |
| **procs** | Monitor | Modern ps replacement |
| **dust** | Disk | Disk usage analyzer |
| **duf** | Disk | Disk usage/free utility |

---

## 🔒 Security & Encryption

| Tool | Purpose |
|------|---------|
| **age** | File encryption |
| **gnupg** | GPG encryption (installed but not configured) |

**Note:** GPG/GnuPG is installed as a dependency for other tools (Docker, git signing) but is not automatically configured. Manual setup required if needed.

---

## 🎨 Editor & IDE

### Neovim Configuration

**Installation:**
- **Version:** v0.11.2+ (LazyVim requirement)
- **Config Location:** `~/.config/nvim/`
- **Plugin Manager:** lazy.nvim
- **Distribution:** LazyVim

**Key Plugins:**
- LSP support (language servers)
- Treesitter (syntax highlighting)
- Telescope (fuzzy finder)
- Neo-tree (file explorer)
- Git integration (gitsigns, fugitive)

---

## 🌐 Network & API Tools

| Tool | Purpose |
|------|---------|
| **httpie** | User-friendly HTTP client |
| **curl** | Command-line URL tool |
| **wget** | Network downloader |

---

## 📦 Package Managers Used

| OS | Package Manager | Usage |
|----|-----------------|-------|
| **macOS** | Homebrew | Primary package manager |
| **Linux (Ubuntu/Debian)** | apt | System packages |
| **Linux (Arch)** | pacman | System packages |
| **Node.js** | npm, yarn | JavaScript packages |
| **PHP** | composer | PHP packages |
| **Python** | pipx, pip | Python tools/packages |
| **Rust** | cargo | Rust packages (optional) |

---

## 🚀 AI & Modern CLI Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| **claude-code** | Anthropic's Claude AI CLI | npm global |
| **opencode** | OpenCode CLI | npm global (community) |
| **gh** | GitHub CLI | Homebrew/apt |
| **glab** | GitLab CLI | Homebrew/manual |

---

## 📁 File Management

| Tool | Purpose |
|------|---------|
| **yazi** | Terminal file manager |
| **eza** | Modern ls with colors/icons |
| **fd** | Fast find alternative |
| **bat** | Cat with syntax highlighting |

---

## 🔍 Search & Navigation

| Tool | Purpose | Key Features |
|------|---------|--------------|
| **fzf** | Fuzzy finder | Interactive search |
| **ripgrep (rg)** | Fast grep | Recursive search |
| **fd** | Fast find | File search |
| **zoxide** | Smart cd | Directory jumping |

---

## 🎯 Installation Scripts

### Run Once Scripts

| Script | Purpose | Priority |
|--------|---------|----------|
| `00-backup-existing-configs.sh` | Backup existing configs | First |
| `00-install-bitwarden-cli.sh` | ~~Bitwarden CLI~~ | **REMOVED** |
| `01b-install-core-tools.sh` | Core CLI tools | High |
| `01c-install-dev-tools.sh` | Development environments | High |
| `01d-install-downloaded-tools.sh` | GitHub releases | Medium |
| `02-setup-zsh-plugins.sh` | Zsh configuration | Medium |
| `03-setup-directories.sh` | Directory structure | Medium |
| ~~`04-setup-gpg.sh`~~ | ~~GPG configuration~~ | **REMOVED** |
| `05-setup-secure-mcp.sh` | MCP servers | Medium |
| `06-setup-secure-secrets.sh` | Secrets management | Medium |
| `07-migrate-secrets-to-bitwarden.sh` | ~~Bitwarden migration~~ | **REMOVED** |
| `08-create-bitwarden-placeholders.sh` | ~~Bitwarden placeholders~~ | **REMOVED** |
| `11-setup-zen-transparency.sh` | Zen browser config | Low |
| `12-install-barrier.sh` | ~~Barrier KVM~~ | **REMOVED** |
| `16-install-obsidian.sh` | Obsidian notes | Low |
| `17-install-nerd-font.sh` | Nerd Fonts | Medium |
| `18-install-n8n.sh` | n8n automation | Optional |
| `19-install-mcp-memory-service.sh` | MCP Memory Service | Optional |

---

## 🔧 Configuration Management

### Chezmoi

**Source Directory:** `~/projects/dotfiles/`  
**Target Directory:** `~/` (home directory)  

**Key Commands:**
```bash
chezmoi apply          # Apply changes
chezmoi diff           # Preview changes
chezmoi update         # Update from remote
```

---

## 📊 Estimated Disk Usage

| Category | Size |
|----------|------|
| Core tools | ~500 MB |
| Node.js + packages | ~300 MB |
| PHP + Composer | ~150 MB |
| Python tools | ~100 MB |
| Docker | ~200 MB |
| Neovim + plugins | ~100 MB |
| Downloaded tools | ~50 MB |
| **Total** | **~1.4 GB** |

---

## 🎓 Platform Support

| Platform | Support Level |
|----------|---------------|
| **macOS (Darwin)** | ✅ Full support (Homebrew) |
| **Linux (Ubuntu/Debian)** | ✅ Full support (apt) |
| **Linux (Arch)** | ✅ Full support (pacman) |
| **Other Linux** | ⚠️ Partial (manual installs) |
| **Windows** | ❌ Not supported |

---

## 🚫 Removed/Disabled Tools

| Tool | Reason | Date |
|------|--------|------|
| **Bitwarden CLI** | User request | Nov 30, 2025 |
| **Barrier KVM** | User request | Nov 30, 2025 |
| ~~Python auto-install~~ | Manual pipx preferred | Earlier |

**Note:** Bitwarden and Barrier removed per user request. Templates updated to use static configuration instead.

---

## 📝 Manual Configuration Required

### After Installation

1. **Git Configuration**
   - Set name: `git config --global user.name "Your Name"`
   - Set email: `git config --global user.email "your@email.com"`

2. **GPG Key** (Optional - for commit signing)
   - Generate key: `gpg --full-generate-key`
   - Configure git: `git config --global user.signingkey <KEY_ID>`
   - Enable signing: `git config --global commit.gpgsign true`

3. **GitHub/GitLab**
   - Login gh: `gh auth login`
   - Login glab: `glab auth login`

4. **Docker**
   - Logout/login after installation (for group permissions)

5. **Neovim**
   - First launch installs plugins automatically
   - Run `:checkhealth` to verify setup

---

## 🔄 Update Commands

```bash
# Update all tools
chezmoi update

# Update specific tools
brew upgrade              # macOS
sudo apt update && sudo apt upgrade  # Linux
npm update -g             # Node.js global packages
composer global update    # PHP global packages

# Update Neovim plugins
nvim +Lazy! sync +qa
```

---

## 📚 Documentation

### Tool Documentation

- **Neovim:** `:help` in nvim, https://neovim.io/doc/
- **Tmux:** `man tmux`, https://github.com/tmux/tmux/wiki
- **Starship:** https://starship.rs/config/
- **Chezmoi:** https://www.chezmoi.io/
- **LazyVim:** https://www.lazyvim.org/

### Dotfiles Docs

- **Main README:** `~/projects/dotfiles/README.md`
- **AGENTS.md:** OpenCode agent configuration
- **PLUGINS_USAGE_GUIDE.md:** OpenCode plugins guide
- **AUTO_ROUTER_GUIDE.md:** Auto-router plugin guide

---

## ✅ Verification Commands

```bash
# Check installed tools
command -v nvim tmux git gh glab starship fzf rg fd bat eza

# Check versions
nvim --version | head -1
node --version
npm --version
php --version
docker --version

# Check Neovim health
nvim --headless -c "checkhealth" -c "qa"

# List npm global packages
npm list -g --depth=0

# List pipx packages (Linux)
pipx list
```

---

## 🎯 Quick Start After Installation

```bash
# 1. Verify installation
./test-installation.sh --quick

# 2. Configure git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# 3. Login to GitHub/GitLab
gh auth login
glab auth login

# 4. Test Neovim
nvim +checkhealth +qa

# 5. Test terminal setup
echo $SHELL  # Should be /bin/zsh or similar
starship --version
tmux -V
```

---

**Total Tools:** 70+  
**Disk Space:** ~1.4 GB  
**Installation Time:** ~15-30 minutes (depending on internet speed)

**Status:** ✅ Comprehensive modern development environment

**Last Updated:** November 30, 2025  
**Maintained by:** Your Name
