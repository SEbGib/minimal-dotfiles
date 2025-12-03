#!/bin/bash

# ===== Chezmoi Dotfiles Installation Verification =====
# Comprehensive verification script for all installed tools and configurations

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
VERIFIED=0
MISSING=0
WARNINGS=0

# Verification result function
verify_tool() {
    local tool_name="$1"
    local command_name="${2:-$tool_name}"
    local is_critical="${3:-false}"
    
    if command -v "$command_name" &> /dev/null; then
        local version=""
        case "$tool_name" in
            "Node.js") version=$($command_name --version 2>/dev/null || echo "unknown") ;;
            "Zsh") version=$($command_name --version 2>/dev/null | head -1 || echo "unknown") ;;
            "Git") version=$($command_name --version 2>/dev/null || echo "unknown") ;;
            "Starship") version=$($command_name --version 2>/dev/null || echo "unknown") ;;
            "Neovim") version=$($command_name --version 2>/dev/null | head -1 || echo "unknown") ;;
            "tmux") version=$($command_name -V 2>/dev/null || echo "unknown") ;;
            "Docker") version=$($command_name --version 2>/dev/null | head -1 || echo "unknown") ;;
            "Claude Code") version=$($command_name --version 2>/dev/null || echo "unknown") ;;
            "Lazygit") version=$($command_name --version 2>/dev/null | head -1 || echo "unknown") ;;
            *) version=$($command_name --version 2>/dev/null | head -1 2>/dev/null || echo "installed") ;;
        esac
        
        echo -e "${GREEN}  $tool_name${NC} - $version"
        ((VERIFIED++))
        return 0
    else
        if [[ "$is_critical" == "true" ]]; then
            echo -e "${RED}  $tool_name${NC} - MISSING (CRITICAL)"
            ((MISSING++))
        else
            echo -e "${YELLOW}   $tool_name${NC} - missing (optional)"
            ((WARNINGS++))
        fi
        return 1
    fi
}

# Verify file existence
verify_file() {
    local file_path="$1"
    local description="$2"
    local is_critical="${3:-false}"
    
    if [[ -f "$file_path" ]]; then
        local size=$(du -h "$file_path" | cut -f1)
        echo -e "${GREEN}  $description${NC} - $file_path ($size)"
        ((VERIFIED++))
        return 0
    else
        if [[ "$is_critical" == "true" ]]; then
            echo -e "${RED}  $description${NC} - $file_path (CRITICAL)"
            ((MISSING++))
        else
            echo -e "${YELLOW}   $description${NC} - $file_path (optional)"
            ((WARNINGS++))
        fi
        return 1
    fi
}

# Verify directory existence
verify_directory() {
    local dir_path="$1"
    local description="$2"
    local is_critical="${3:-false}"
    
    if [[ -d "$dir_path" ]]; then
        local count=$(ls -1 "$dir_path" 2>/dev/null | wc -l)
        echo -e "${GREEN}  $description${NC} - $dir_path ($count files)"
        ((VERIFIED++))
        return 0
    else
        if [[ "$is_critical" == "true" ]]; then
            echo -e "${RED}  $description${NC} - $dir_path (CRITICAL)"
            ((MISSING++))
        else
            echo -e "${YELLOW}   $description${NC} - $dir_path (optional)"
            ((WARNINGS++))
        fi
        return 1
    fi
}

echo -e "${BLUE}  COMPREHENSIVE INSTALLATION VERIFICATION${NC}"
echo "========================================"
echo ""

# ===== SYSTEM TOOLS =====
echo -e "${BLUE}  System Tools${NC}"
echo "----------------"
verify_tool "Zsh" "zsh" true
verify_tool "Git" "git" true
verify_tool "Curl" "curl" true
verify_tool "Wget" "wget"
verify_tool "Unzip" "unzip"
echo ""

# ===== MODERN CLI TOOLS =====
echo -e "${BLUE}  Modern CLI Tools${NC}"
echo "--------------------"
verify_tool "fzf" "fzf" true
verify_tool "ripgrep" "rg" true
verify_tool "fd" "fd"
verify_tool "bat" "bat"
verify_tool "eza" "eza"
verify_tool "zoxide" "zoxide"
verify_tool "dust" "dust"
verify_tool "duf" "duf"
verify_tool "procs" "procs"
verify_tool "jq" "jq"
verify_tool "btop" "btop"
verify_tool "htop" "htop"
verify_tool "gitui" "gitui"
verify_tool "scc" "scc"
verify_tool "httpie" "http"
echo ""

# ===== DEVELOPMENT TOOLS =====
echo -e "${BLUE}  Development Tools${NC}"
echo "---------------------"
verify_tool "Neovim" "nvim" true
verify_tool "tmux" "tmux" true
verify_tool "Starship" "starship" true
verify_tool "Lazygit" "lazygit"
verify_tool "Lazydocker" "lazydocker"
verify_tool "Node.js" "node"
verify_tool "npm" "npm"
verify_tool "PHP" "php"
verify_tool "Composer" "composer"
verify_tool "Symfony CLI" "symfony"
verify_tool "Docker" "docker"
verify_tool "GitHub CLI" "gh"
echo ""

# ===== AI AND PRODUCTIVITY TOOLS =====
echo -e "${BLUE}  AI & Productivity Tools${NC}"
echo "----------------------------"
verify_tool "Claude Code" "claude"
verify_tool "chezmoi" "chezmoi" true
echo ""

# ===== PYTHON TOOLS =====
echo -e "${BLUE}🐍 Python Tools${NC}"
echo "-----------------"
verify_tool "Python3" "python3"
verify_tool "pip" "pip" false
verify_tool "pipx" "pipx"
verify_tool "black" "black"
verify_tool "flake8" "flake8"
verify_tool "mypy" "mypy"
verify_tool "pytest" "pytest"
echo ""

# ===== CONFIGURATION FILES =====
echo -e "${BLUE}  Configuration Files${NC}"
echo "------------------------"
verify_file "$HOME/.zshrc" "Zsh configuration" true
verify_file "$HOME/.config/starship.toml" "Starship configuration" true
verify_file "$HOME/.config/tmux/tmux.conf" "tmux configuration"
verify_file "$HOME/.config/nvim/init.lua" "Neovim configuration"
verify_file "$HOME/.gitconfig" "Git configuration"
verify_file "$HOME/.env" "Environment variables"
echo ""

# ===== DIRECTORIES =====
echo -e "${BLUE}📂 Important Directories${NC}"
echo "--------------------------"
verify_directory "$HOME/.config" "Config directory" true
verify_directory "$HOME/.local/share/chezmoi" "Chezmoi source directory" true
verify_directory "$HOME/.config/nvim" "Neovim configuration directory"
verify_directory "$HOME/.config/tmux" "tmux configuration directory"
verify_directory "$HOME/.oh-my-zsh" "Oh My Zsh directory"
if [[ -d "$HOME/.oh-my-zsh/custom/plugins" ]]; then
    verify_directory "$HOME/.oh-my-zsh/custom/plugins" "Zsh custom plugins"
fi
echo ""

# ===== ZSH PLUGINS VERIFICATION =====
echo -e "${BLUE}🔌 Zsh Plugins${NC}"
echo "----------------"
zsh_plugins=(
    "zsh-autosuggestions"
    "fast-syntax-highlighting" 
    "zsh-completions"
    "zsh-history-substring-search"
    "zsh-z"
)

for plugin in "${zsh_plugins[@]}"; do
    if [[ -d "$HOME/.oh-my-zsh/custom/plugins/$plugin" ]]; then
        echo -e "${GREEN}  $plugin${NC}"
        ((VERIFIED++))
    else
        echo -e "${YELLOW}   $plugin${NC} - missing"
        ((WARNINGS++))
    fi
done
echo ""

# ===== SPECIAL CHECKS =====
echo -e "${BLUE}  Special Checks${NC}"
echo "------------------"

# Check if Starship config has valid syntax
if command -v starship &> /dev/null; then
    if starship print-config &> /dev/null; then
        echo -e "${GREEN}  Starship configuration syntax${NC}"
        ((VERIFIED++))
    else
        echo -e "${RED}  Starship configuration syntax${NC} - invalid"
        ((MISSING++))
    fi
fi

# Check if zsh is the default shell
if [[ "$SHELL" == *"zsh" ]]; then
    echo -e "${GREEN}  Zsh as default shell${NC}"
    ((VERIFIED++))
else
    echo -e "${YELLOW}   Zsh as default shell${NC} - current: $SHELL"
    ((WARNINGS++))
fi

# Check npm global directory configuration
if command -v npm &> /dev/null; then
    if npm config get prefix | grep -q "$HOME/.npm-global"; then
        echo -e "${GREEN}  npm global directory configuration${NC}"
        ((VERIFIED++))
    else
        echo -e "${YELLOW}   npm global directory configuration${NC} - not set to user directory"
        ((WARNINGS++))
    fi
fi

# Check Docker group membership (if Docker is installed)
if command -v docker &> /dev/null; then
    if groups | grep -q docker; then
        echo -e "${GREEN}  Docker group membership${NC}"
        ((VERIFIED++))
    else
        echo -e "${YELLOW}   Docker group membership${NC} - user not in docker group"
        ((WARNINGS++))
    fi
fi

# Check PATH includes important directories
important_paths=("$HOME/.npm-global/bin" "$HOME/.local/bin")
for path_dir in "${important_paths[@]}"; do
    if [[ ":$PATH:" == *":$path_dir:"* ]]; then
        echo -e "${GREEN}  PATH includes $path_dir${NC}"
        ((VERIFIED++))
    else
        echo -e "${YELLOW}   PATH includes $path_dir${NC} - missing from PATH"
        ((WARNINGS++))
    fi
done

echo ""

# ===== FUNCTIONALITY TESTS =====
echo -e "${BLUE}🧪 Functionality Tests${NC}"
echo "-----------------------"

# Test fzf functionality
if command -v fzf &> /dev/null; then
    if echo "test" | fzf --filter="test" >/dev/null 2>&1; then
        echo -e "${GREEN}  fzf functionality${NC}"
        ((VERIFIED++))
    else
        echo -e "${RED}  fzf functionality${NC}"
        ((MISSING++))
    fi
fi

# Test ripgrep functionality
if command -v rg &> /dev/null; then
    if echo "test content" | rg "test" >/dev/null 2>&1; then
        echo -e "${GREEN}  ripgrep functionality${NC}"
        ((VERIFIED++))
    else
        echo -e "${RED}  ripgrep functionality${NC}"
        ((MISSING++))
    fi
fi

# Test chezmoi status
if command -v chezmoi &> /dev/null; then
    if chezmoi status >/dev/null 2>&1; then
        echo -e "${GREEN}  chezmoi status check${NC}"
        ((VERIFIED++))
    else
        echo -e "${RED}  chezmoi status check${NC}"
        ((MISSING++))
    fi
fi

echo ""

# ===== FINAL SUMMARY =====
echo "========================================"
echo -e "${BLUE}  VERIFICATION SUMMARY${NC}"
echo "========================================"
echo -e "${GREEN}  Verified: $VERIFIED${NC}"
echo -e "${YELLOW}   Warnings: $WARNINGS${NC}"
echo -e "${RED}  Missing: $MISSING${NC}"
echo ""

# Calculate percentage
total=$((VERIFIED + WARNINGS + MISSING))
if [[ $total -gt 0 ]]; then
    percentage=$((VERIFIED * 100 / total))
    echo -e "${BLUE}📈 Success rate: $percentage%${NC}"
fi

echo ""

# Final status
if [[ $MISSING -eq 0 ]]; then
    echo -e "${GREEN}🎉 INSTALLATION VERIFICATION PASSED${NC}"
    echo "All critical components are properly installed and configured!"
    exit 0
else
    echo -e "${RED}   INSTALLATION VERIFICATION FAILED${NC}"
    echo "Some critical components are missing. Please review the output above."
    exit 1
fi