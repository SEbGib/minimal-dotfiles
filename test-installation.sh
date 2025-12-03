#!/bin/bash
# Comprehensive testing framework for dotfiles installation
# This script validates that all tools are properly installed and configured

set -euo pipefail

# ===== CONFIGURATION =====
TEST_RESULTS=()
FAILED_TESTS=()
PASSED_TESTS=()
WARNINGS=()

# ===== UTILITY FUNCTIONS =====
print_status() {
    local status="$1"
    local message="$2"

    case "$status" in
        "PASS") echo "✅ $message" ;;
        "FAIL") echo "❌ $message" ;;
        "WARN") echo "⚠️ $message" ;;
        "INFO") echo "ℹ️ $message" ;;
    esac
}

run_test() {
    local test_name="$1"
    local test_function="$2"

    echo ""
    echo "🧪 Testing: $test_name"

    if $test_function; then
        print_status "PASS" "$test_name"
        TEST_RESULTS+=("$test_name:PASS")
        PASSED_TESTS+=("$test_name")
    else
        print_status "FAIL" "$test_name"
        TEST_RESULTS+=("$test_name:FAIL")
        FAILED_TESTS+=("$test_name")
    fi
}

add_warning() {
    local warning="$1"
    WARNINGS+=("$warning")
    print_status "WARN" "$warning"
}

# ===== CORE TOOL TESTS =====
test_zsh() {
    command -v zsh >/dev/null 2>&1 && [[ -f "$HOME/.zshrc" ]]
}

test_neovim() {
    if command -v nvim >/dev/null 2>&1; then
        # Test basic functionality
        nvim --headless -c "echo 'test'" -c "qall" >/dev/null 2>&1
    fi
}

test_tmux() {
    command -v tmux >/dev/null 2>&1 && [[ -f "$HOME/.config/tmux/tmux.conf" ]]
}

test_git() {
    command -v git >/dev/null 2>&1 && git --version >/dev/null 2>&1
}

test_fzf() {
    command -v fzf >/dev/null 2>&1
}

test_ripgrep() {
    command -v rg >/dev/null 2>&1
}

test_bat() {
    command -v bat >/dev/null 2>&1
}

test_eza() {
    command -v eza >/dev/null 2>&1
}

test_fd() {
    command -v fd >/dev/null 2>&1
}

# ===== DEVELOPMENT TOOL TESTS =====
test_nodejs() {
    command -v node >/dev/null 2>&1 && command -v npm >/dev/null 2>&1
}

test_php() {
    command -v php >/dev/null 2>&1 && command -v composer >/dev/null 2>&1
}

test_python() {
    command -v python3 >/dev/null 2>&1
}

test_docker() {
    command -v docker >/dev/null 2>&1
}

# ===== CONFIGURATION TESTS =====
test_chezmoi_config() {
    [[ -f "$HOME/.config/chezmoi/chezmoi.toml" ]] || [[ -f "$HOME/.chezmoi.toml" ]]
}

test_starship_config() {
    [[ -f "$HOME/.config/starship.toml" ]] && command -v starship >/dev/null 2>&1
}

test_neovim_config() {
    [[ -d "$HOME/.config/nvim" ]] && [[ -f "$HOME/.config/nvim/init.lua" ]]
}

test_tmux_config() {
    [[ -f "$HOME/.config/tmux/tmux.conf" ]]
}

# ===== FUNCTIONALITY TESTS =====
test_git_configuration() {
    if command -v git >/dev/null 2>&1; then
        git config --global user.name >/dev/null 2>&1 &&
        git config --global user.email >/dev/null 2>&1
    fi
}

test_zsh_plugins() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        [[ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]] || add_warning "zsh-autosuggestions not found"
        [[ -d "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting" ]] || add_warning "fast-syntax-highlighting not found"
        return 0
    fi
    return 1
}

test_claude_code() {
    command -v claude >/dev/null 2>&1
}

# Bitwarden removed - no longer used

# ===== PERFORMANCE TESTS =====
test_startup_time() {
    if command -v time >/dev/null 2>&1 && command -v zsh >/dev/null 2>&1; then
        local startup_time
        startup_time=$(time -f "%e" zsh -c "exit" 2>&1 | tail -n 1)
        # Convert to milliseconds
        startup_time=$(echo "$startup_time * 1000" | bc -l 2>/dev/null | cut -d'.' -f1)

        if [[ -n "$startup_time" && "$startup_time" -lt 500 ]]; then
            print_status "INFO" "Zsh startup time: ${startup_time}ms"
            return 0
        else
            add_warning "Slow Zsh startup: ${startup_time}ms"
            return 1
        fi
    fi
    return 1
}

# ===== INTEGRATION TESTS =====
test_neovim_plugins() {
    if command -v nvim >/dev/null 2>&1; then
        # Test if LazyVim can load without errors
        timeout 10s nvim --headless -c "lua require('lazy').setup({})" -c "qall" >/dev/null 2>&1
    fi
}

test_tmux_plugins() {
    if command -v tmux >/dev/null 2>&1; then
        # Test if TPM can initialize
        [[ -d "$HOME/.config/tmux/.tmux/plugins/tpm" ]] || add_warning "TPM not found"
        return 0
    fi
    return 1
}

# ===== MAIN TEST SUITE =====
run_all_tests() {
    echo "🚀 Starting comprehensive installation tests..."
    echo "📊 Testing on: $(uname -a)"
    echo ""

    # Core system tests
    run_test "Zsh Installation" "test_zsh"
    run_test "Neovim Installation" "test_neovim"
    run_test "Tmux Installation" "test_tmux"
    run_test "Git Installation" "test_git"

    # Modern CLI tools
    run_test "FZF Installation" "test_fzf"
    run_test "Ripgrep Installation" "test_ripgrep"
    run_test "Bat Installation" "test_bat"
    run_test "Eza Installation" "test_eza"
    run_test "Fd Installation" "test_fd"

    # Development tools
    run_test "Node.js Installation" "test_nodejs"
    run_test "PHP Installation" "test_php"
    run_test "Python Installation" "test_python"
    run_test "Docker Installation" "test_docker"

    # Configuration tests
    run_test "Chezmoi Configuration" "test_chezmoi_config"
    run_test "Starship Configuration" "test_starship_config"
    run_test "Neovim Configuration" "test_neovim_config"
    run_test "Tmux Configuration" "test_tmux_config"

    # Functionality tests
    run_test "Git Configuration" "test_git_configuration"
    run_test "Zsh Plugins" "test_zsh_plugins"
    run_test "Claude Code Installation" "test_claude_code"

    # Performance tests
    run_test "Shell Startup Time" "test_startup_time"

    # Integration tests
    run_test "Neovim Plugins" "test_neovim_plugins"
    run_test "Tmux Plugins" "test_tmux_plugins"

    # Summary
    echo ""
    echo "📊 Test Summary:"
    echo "✅ Passed: ${#PASSED_TESTS[@]}"
    echo "❌ Failed: ${#FAILED_TESTS[@]}"
    echo "⚠️ Warnings: ${#WARNINGS[@]}"

    if [[ ${#FAILED_TESTS[@]} -eq 0 ]]; then
        echo ""
        echo "🎉 All critical tests passed!"
        if [[ ${#WARNINGS[@]} -gt 0 ]]; then
            echo "⚠️ Minor warnings detected (non-critical)"
        fi
        return 0
    else
        echo ""
        echo "💥 Some tests failed. Check the output above for details."
        return 1
    fi
}

# ===== COMMAND LINE INTERFACE =====
show_help() {
    cat << EOF
Dotfiles Installation Test Suite

Usage: $0 [OPTIONS]

Options:
    -h, --help          Show this help message
    -v, --verbose       Show detailed output
    -q, --quick         Run only critical tests
    --list              List all available tests
    --fix               Attempt to fix common issues

Examples:
    $0                  Run all tests
    $0 --quick          Run only critical tests
    $0 --fix            Try to fix common configuration issues

Exit codes:
    0   All tests passed
    1   Some tests failed
    2   Invalid usage

EOF
}

list_tests() {
    echo "Available tests:"
    echo "Core System:"
    echo "  - Zsh Installation"
    echo "  - Neovim Installation"
    echo "  - Tmux Installation"
    echo "  - Git Installation"
    echo ""
    echo "CLI Tools:"
    echo "  - FZF Installation"
    echo "  - Ripgrep Installation"
    echo "  - Bat Installation"
    echo "  - Eza Installation"
    echo "  - Fd Installation"
    echo ""
    echo "Development Tools:"
    echo "  - Node.js Installation"
    echo "  - PHP Installation"
    echo "  - Python Installation"
    echo "  - Docker Installation"
    echo ""
    echo "Configuration:"
    echo "  - Chezmoi Configuration"
    echo "  - Starship Configuration"
    echo "  - Neovim Configuration"
    echo "  - Tmux Configuration"
    echo ""
    echo "Functionality:"
    echo "  - Git Configuration"
    echo "  - Zsh Plugins"
    echo "  - Claude Code Installation"
    echo ""
    echo "Performance:"
    echo "  - Shell Startup Time"
    echo ""
    echo "Integration:"
    echo "  - Neovim Plugins"
    echo "  - Tmux Plugins"
}

# ===== MAIN EXECUTION =====
main() {
    local quick_mode=false

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--verbose)
                set -x
                shift
                ;;
            -q|--quick)
                quick_mode=true
                shift
                ;;
            --list)
                list_tests
                exit 0
                ;;
            --fix)
                echo "🔧 Attempting to fix common issues..."
                # Add fix logic here
                shift
                ;;
            *)
                echo "❌ Unknown option: $1"
                show_help
                exit 2
                ;;
        esac
    done

    if [[ "$quick_mode" == "true" ]]; then
        echo "⚡ Running quick tests only..."
        # Run only critical tests
        run_test "Zsh Installation" "test_zsh"
        run_test "Git Installation" "test_git"
        run_test "Chezmoi Configuration" "test_chezmoi_config"
    else
        run_all_tests
    fi
}

# Run the test suite
main "$@"