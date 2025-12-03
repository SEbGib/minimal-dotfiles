#!/bin/bash

set -euo pipefail

echo "🧪 Quick validation test..."

# Test 1: Check for invalid brew options
echo "📋 Checking for invalid brew options..."
if grep -r "brew bundle --no-lock" . --include="*.tmpl"; then
    echo "❌ Found invalid --no-lock option"
    exit 1
fi

# Test 2: Check for invalid cask names (only if brew available)
echo "📋 Checking cask names..."
if command -v brew &> /dev/null; then
    for cask in $(grep -r '^cask ' . --include="*.tmpl" | grep -o '"[^"]*"' | tr -d '"'); do
        echo "Checking cask: $cask"
        if ! brew search --cask "$cask" &>/dev/null; then
            echo "❌ Invalid cask: $cask"
            exit 1
        fi
    done
else
    echo "⚠️ Homebrew not available, skipping cask validation"
fi

# Test 3: Validate TOML syntax
echo "📋 Checking TOML files..."
for toml in $(find . -name "*.toml"); do
    echo "Testing: $toml"
    if ! python3 -c "
try:
    import tomllib
    with open('$toml', 'rb') as f:
        tomllib.load(f)
except ImportError:
    try:
        import tomli as tomllib
        with open('$toml', 'rb') as f:
            tomllib.load(f)
    except ImportError:
        import toml
        toml.load('$toml')
" 2>/dev/null; then
        echo "❌ Invalid TOML: $toml"
        exit 1
    fi
done

# Test 4: Check key URLs (with fallback for network issues)
echo "📋 Testing key URLs..."
for url in "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" "https://starship.rs/install.sh"; do
    if ! curl -sSf --connect-timeout 10 "$url" > /dev/null 2>&1; then
        echo "⚠️ URL failed: $url (may be network issue)"
        # Don't exit immediately - this could be temporary network issue
    fi
done

echo "✅ All quick tests passed!"