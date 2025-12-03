#   Installation Troubleshooting Guide

Comprehensive guide for resolving common installation issues with the dotfiles configuration.

##   Quick Diagnostic Commands

### Check Installation Status
```bash
# Test all components
./test-installation.sh

# Quick status check
./test-installation.sh --quick

# List available tests
./test-installation.sh --list
```

### Verify Core Dependencies
```bash
# Check if essential tools are available
command -v chezmoi >/dev/null && echo "  Chezmoi installed" || echo "  Chezmoi missing"
command -v git >/dev/null && echo "  Git installed" || echo "  Git missing"
command -v curl >/dev/null && echo "  Curl installed" || echo "  Curl missing"

# Check available package managers
command -v apt >/dev/null && echo "📦 Using apt" || echo "  apt not available"
command -v pacman >/dev/null && echo "📦 Using pacman" || echo "  pacman not available"
command -v brew >/dev/null && echo "📦 Using Homebrew" || echo "  Homebrew not available"
```

## 🐛 Common Issues & Solutions

### 1. Slow Installation (>15 minutes)

**Symptoms:**
- Installation hangs for extended periods
- Download timeouts
- Network connectivity issues

**Solutions:**

#### Check Internet Connection
```bash
# Test basic connectivity
ping -c 3 8.8.8.8

# Test GitHub accessibility
curl -I https://github.com

# Check DNS resolution
nslookup github.com
```

#### Optimize Network Settings
```bash
# Temporarily disable VPN (if using)
# VPN can significantly slow down GitHub downloads

# Use faster DNS (optional)
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

# Increase curl timeouts
export CURL_TIMEOUT=300
```

#### Use GitHub Token for Faster Downloads
```bash
# Create personal access token: https://github.com/settings/tokens
export GITHUB_TOKEN="ghp_your_token_here"
export CHEZMOI_GITHUB_TOKEN="$GITHUB_TOKEN"

# Retry installation
chezmoi apply
```

### 2. Permission Errors

**Symptoms:**
- `sudo: command not found`
- `Permission denied` errors
- Cannot write to system directories

**Solutions:**

#### Fix sudo Configuration
```bash
# Check if user is in sudo group
groups | grep -q sudo || sudo usermod -aG sudo $USER

# Test sudo access
sudo -v

# If sudo not available, use alternative installation methods
# The scripts will automatically fall back to user-space installation
```

#### Fix Directory Permissions
```bash
# Fix common permission issues
mkdir -p ~/.local/bin ~/.npm-global
chmod 755 ~/.local/bin ~/.npm-global

# Ensure PATH includes user directories
echo 'export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
```

### 3. Package Manager Issues

**Symptoms:**
- `apt: command not found`
- `pacman: command not found`
- Package installation failures

**Solutions:**

#### Ubuntu/Debian Systems
```bash
# Update package lists
sudo apt update

# Install required dependencies
sudo apt install -y curl wget git

# If apt is broken, fix it
sudo apt --fix-broken install
```

#### Arch Linux Systems
```bash
# Update system
sudo pacman -Syu

# Install base development tools
sudo pacman -S base-devel git curl wget
```

#### macOS Systems
```bash
# Install Homebrew if missing
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ensure Xcode command line tools
xcode-select --install
```

### 4. Tool-Specific Issues

#### Node.js Installation Problems
```bash
# Check if Node.js is installed
node --version
npm --version

# If installation failed, try manual installation
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Fix npm permissions
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
```

#### PHP Installation Problems
```bash
# Check PHP installation
php --version
composer --version

# Manual PHP installation for Ubuntu
sudo apt install -y php php-cli php-mbstring php-xml php-zip php-curl

# Install Composer manually if needed
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

#### Neovim Installation Problems
```bash
# Check Neovim installation
nvim --version

# If missing, install from alternative source
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

### 5. Configuration Issues

#### Zsh Not Default Shell
```bash
# Check current shell
echo $SHELL

# Change to zsh
chsh -s $(which zsh)

# If chsh fails, add to /etc/shells
echo $(which zsh) | sudo tee -a /etc/shells

# Manual workaround
echo 'exec zsh' >> ~/.bashrc
```

#### Missing Oh My Zsh
```bash
# Install Oh My Zsh manually
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# Install plugins manually
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

#### Starship Prompt Not Working
```bash
# Check Starship installation
starship --version

# Test configuration
starship print-config

# Fix common issues
mkdir -p ~/.config
cp dot_config/starship.toml ~/.config/starship.toml
```

### 6. Docker Issues

#### Docker Not Running
```bash
# Check Docker service
sudo systemctl status docker  # Linux
brew services list | grep docker  # macOS

# Start Docker service
sudo systemctl start docker  # Linux
brew services start docker  # macOS

# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in for changes to take effect
```

#### Docker Compose Issues
```bash
# Check Docker Compose installation
docker-compose --version

# If missing, install manually
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 7. Performance Issues

#### Slow Shell Startup
```bash
# Profile shell startup time
time zsh -c "exit"

# Check for slow plugins
# Comment out plugins in .zshrc one by one to identify bottlenecks

# Optimize plugin loading
# Move heavy plugins to lazy loading
```

#### High Memory Usage
```bash
# Check what's using memory
ps aux --sort=-%mem | head -10

# Common memory hogs to watch:
# - Node.js processes
# - PHP processes
# - Docker containers
```

### 8. Security Issues

#### Bitwarden CLI Not Working
```bash
# Check Bitwarden installation
bw --version

# Login to Bitwarden
bw login

# Set session environment variable
export BW_SESSION=$(bw unlock --raw)

# Test secret retrieval
bw get password git_user_email
```

#### GPG Issues
```bash
# Check GPG installation
gpg --version

# List keys
gpg --list-keys

# Generate new key if needed
gpg --full-generate-key

# Set trust level
echo "your-key-id:6:" | gpg --import-ownertrust
```

##   Advanced Troubleshooting

### Debug Mode Installation
```bash
# Enable verbose output
set -x

# Run installation with debug output
chezmoi apply --verbose

# Check chezmoi status
chezmoi status
chezmoi diff
```

### Manual Component Installation
```bash
# Install components individually
./run_once_01b-install-core-tools.sh.tmpl
./run_once_01c-install-dev-tools.sh.tmpl
./run_once_01d-install-downloaded-tools.sh.tmpl
```

### Reset and Retry
```bash
# Clean chezmoi cache
rm -rf ~/.local/share/chezmoi
rm -rf ~/.cache/chezmoi

# Reinitialize
chezmoi init --apply https://github.com/SEbGib/dotfiles.git

# Or force reapply
chezmoi apply --force
```

##   System Requirements Check

### Minimum Requirements
- **RAM**: 2GB minimum, 4GB recommended
- **Disk**: 5GB free space
- **Network**: Stable internet connection
- **OS**: Ubuntu 20.04+, macOS 11+, Arch Linux

### Check System Resources
```bash
# Memory usage
free -h

# Disk space
df -h

# Network connectivity
ping -c 3 1.1.1.1

# System information
uname -a
lsb_release -a  # Ubuntu/Debian
```

##   Emergency Recovery

### If Installation Completely Fails
```bash
# 1. Backup existing configurations
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
cp ~/.config/starship.toml ~/.config/starship.toml.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true

# 2. Reset to minimal working state
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# 3. Install essential tools manually
curl -fsSL https://starship.rs/install.sh | bash
curl -fsSL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# 4. Retry installation later
```

### Contact Support
If issues persist:
1. Run the full test suite: `./test-installation.sh`
2. Check the security log: `./bin/executable_enhanced-security-check --log`
3. Review the installation logs in `~/.local/share/chezmoi/`
4. Open an issue on the dotfiles repository with diagnostic information

## 📈 Performance Optimization

### Speed Up Installations
```bash
# Use parallel downloads (modify scripts)
export MAX_PARALLEL_DOWNLOADS=5

# Use pre-built binaries where possible
export USE_PREBUILT=true

# Skip optional components
export SKIP_OPTIONAL=true
```

### Optimize After Installation
```bash
# Clean package manager caches
sudo apt autoremove -y && sudo apt autoclean  # Ubuntu/Debian
sudo pacman -Sc  # Arch

# Clean npm cache
npm cache clean --force

# Optimize git repositories
find ~ -name ".git" -type d -exec git --git-dir={} gc --aggressive \;
```

---

**Last Updated**: 2025-01-12
**Version**: 1.0.0

For additional help, run `./test-installation.sh --help` or `./bin/executable_enhanced-security-check --help`