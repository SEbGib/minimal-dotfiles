# Installed Tools

Complete list of tools included in minimal-dotfiles, categorized by purpose.

---

## 📝 Text Editors & IDEs

### Neovim
**Modern modal text editor with LSP support**
- **Config**: `~/.config/nvim/`
- **Plugins**: LazyVim, nvim-tree, telescope, LSP, autocompletion
- **Languages**: TypeScript, Python, Lua, PHP, Go, Rust
- **Features**: File explorer, fuzzy finding, Git integration

---

## 🖥️ Terminal & Shell

### Zsh
**Modern shell with plugins**
- **Config**: `~/.zshrc`
- **Plugins**: zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions
- **Features**: Smart history, auto-suggestions, syntax highlighting

### tmux
**Terminal multiplexer**
- **Config**: `~/.config/tmux/tmux.conf`
- **Features**: Session management, pane splitting, vim-like navigation
- **Plugins**: tmux-resurrect, tmux-continuum

### Starship
**Fast, customizable prompt**
- **Config**: `~/.config/starship.toml`
- **Features**: Git status, language versions, execution time

---

## 🔍 Modern CLI Tools

### File Management

| Tool | Purpose | Replaces |
|------|---------|----------|
| **eza** | Enhanced ls | `ls` |
| **bat** | Syntax-highlighted cat | `cat` |
| **fd** | Fast find | `find` |
| **zoxide** | Smart cd | `cd` |

### Search & Navigation

| Tool | Purpose | Use Case |
|------|---------|----------|
| **ripgrep (rg)** | Fast grep | Code search |
| **fzf** | Fuzzy finder | File/history search |
| **delta** | Better git diff | Git diffs |

### Development

| Tool | Purpose | Features |
|------|---------|----------|
| **lazygit** | Git TUI | Interactive git |
| **lazydocker** | Docker TUI | Container management |
| **rainfrog** | PostgreSQL TUI | Database client |

---

## 🛠️ Development Tools

### Version Control
- **Git** - Enhanced config with GPG signing, aliases
- **gh** - GitHub CLI for issues, PRs, workflows
- **glab** - GitLab CLI

### Languages & Runtimes
- **Node.js** (via nvm) - JavaScript runtime
- **Python** (3.x) - Python interpreter
- **PHP** (8.x) - PHP interpreter
- **Bun** - Fast JavaScript runtime

### Package Managers
- **npm** - Node package manager
- **pip** - Python package manager
- **composer** - PHP package manager

### Containers
- **Docker** - Container platform
- **Docker Compose** - Multi-container orchestration

---

## 📦 Utilities

### System
- **htop** - Process viewer
- **ncdu** - Disk usage analyzer
- **tree** - Directory tree viewer
- **watch** - Execute command periodically

### Network
- **curl** - Transfer data with URLs
- **wget** - Download files
- **nmap** - Network scanner
- **netcat (nc)** - Network utility

### Compression
- **tar** - Archive utility
- **zip/unzip** - Zip compression
- **gzip/gunzip** - Gzip compression

---

## ⚙️ Configuration Management

### Chezmoi
**Dotfiles manager**
- **Purpose**: Manage dotfiles across machines
- **Features**: Templates, encryption, cross-platform
- **Commands**:
  ```bash
  chezmoi apply    # Apply configs
  chezmoi update   # Pull and apply latest
  chezmoi diff     # Preview changes
  ```

---

## 🔒 Security & Secrets

### Bitwarden CLI (Optional)
**Password manager**
- **Purpose**: Secure secret management
- **Integration**: Template variables for sensitive data
- **Setup**: See [SECURE_SECRETS_SETUP.md](SECURE_SECRETS_SETUP.md)

### GPG
**Encryption tool**
- **Purpose**: Sign commits, encrypt files
- **Config**: Git commit signing enabled by default

---

## 🤖 Optional Services

### n8n (Optional)
**Self-hosted automation platform**
- **Purpose**: Workflow automation (like Zapier)
- **Requires**: Docker
- **Setup**: `run_once_18-install-n8n.sh.tmpl`
- **Access**: http://localhost:5678

### MCP Memory Service (Optional)
**Persistent memory for AI tools**
- **Purpose**: Cross-session context for Claude Code
- **Requires**: Claude Code
- **Setup**: `run_once_19-install-mcp-memory-service.sh.tmpl`

### Obsidian (Optional)
**Knowledge management**
- **Purpose**: Note-taking and knowledge graphs
- **Setup**: `run_once_16-install-obsidian.sh.tmpl`

---

## 📚 Documentation Tools

### Markdown Viewers
- **glow** - Terminal markdown renderer
- **mdcat** - Markdown cat with syntax highlighting

---

## 🎨 Themes & Fonts

### Rose Pine
**Color scheme** across Neovim, tmux, terminal
- **Variants**: Main, Moon, Dawn
- **Files**: Applied automatically to all tools

### Nerd Fonts
**Icon-enhanced fonts**
- **Installed**: JetBrainsMono Nerd Font
- **Purpose**: Icons in terminal, Neovim

---

## Tool Installation by Platform

### macOS
```bash
brew bundle --file=~/.config/brewfile
```

### Ubuntu/Debian
```bash
sudo apt install zsh tmux neovim git curl wget \
  build-essential ripgrep fd-find bat eza fzf zoxide
```

### Arch Linux
```bash
sudo pacman -S zsh tmux neovim git curl wget \
  base-devel ripgrep fd bat eza fzf zoxide
```

---

## Customization

### Add Your Own Tools

1. **Fork this repo**
2. **Edit installation scripts**: `run_once_01c-install-dev-tools.sh.tmpl`
3. **Add to Brewfile** (macOS): `dot_config/brewfile`
4. **Apply**: `chezmoi apply`

### Remove Unwanted Tools

```bash
# Skip specific installation script
chezmoi apply --exclude scripts/run_once_XX-*.sh.tmpl

# Uninstall manually
brew uninstall PACKAGE  # macOS
sudo apt remove PACKAGE # Linux
```

---

## Tool Versions

Tools are installed from official sources:
- **Latest stable** for most tools
- **LTS versions** for Node.js, Python
- **Package manager defaults** for system tools

Check versions:
```bash
nvim --version
tmux -V
zsh --version
git --version
```

---

## Getting Help

- **Neovim**: `:help` or `:checkhealth`
- **tmux**: `tmux list-keys` (show keybindings)
- **Tool docs**: Most tools have `--help` or `man TOOL`
- **Community**: Ask in tool-specific GitHub discussions
