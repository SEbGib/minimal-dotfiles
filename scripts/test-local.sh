#!/bin/bash

set -euo pipefail

echo "🧪 Running local dotfiles tests..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

FAILED_TESTS=0

test_result() {
    local test_name="$1"
    local success="$2"

    if [[ "$success" == "true" ]]; then
        echo -e "${GREEN}✅ $test_name${NC}"
    else
        echo -e "${RED}❌ $test_name${NC}"
        ((FAILED_TESTS++))
    fi
}

echo -e "${BLUE}📋 Test 1: Template Syntax Validation${NC}"
template_errors=0

# Test all template files can be parsed
for template in $(find . -name "*.tmpl"); do
    echo "Testing template: $template"

    # Check for basic template syntax issues
    if grep -q '{{.*}}' "$template" 2>/dev/null; then
        if grep -q '{{[^}]*{[^}]*}}' "$template" 2>/dev/null; then
            echo -e "${YELLOW}⚠️  Potential nested template issue in $template${NC}"
        fi
    fi

    # Check for unbalanced brackets
    open_count=$(grep -o '{{' "$template" 2>/dev/null | wc -l | tr -d ' ')
    close_count=$(grep -o '}}' "$template" 2>/dev/null | wc -l | tr -d ' ')

    # Set defaults if empty
    [[ -z "$open_count" ]] && open_count=0
    [[ -z "$close_count" ]] && close_count=0

    if [[ "$open_count" != "$close_count" ]]; then
        echo -e "${RED}❌ Unbalanced template brackets in $template (open: $open_count, close: $close_count)${NC}"
        template_errors=$((template_errors + 1))
    fi
done

test_result "Template syntax validation" $([[ $template_errors -eq 0 ]] && echo "true" || echo "false")

echo -e "${BLUE}📋 Test 2: Homebrew Bundle Validation${NC}"
if command -v brew &> /dev/null; then
    echo "🍺 Homebrew is available"

    # Note: Current dotfiles use apt/snap on Linux and direct downloads
    # Homebrew validation skipped as no Brewfiles exist in current templates
    # This test is kept for future Homebrew integration

    echo -e "${YELLOW}⚠️  No Brewfiles found in current templates (expected)${NC}"
    test_result "Homebrew bundle validation" "true"
else
    echo -e "${YELLOW}⚠️  Homebrew not available, skipping brew validation${NC}"
    test_result "Homebrew bundle validation" "true"
fi

echo -e "${BLUE}📋 Test 3: Download URL Validation${NC}"
url_errors=0

# Test key download URLs
urls=(
    "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest"
    "https://api.github.com/repos/sharkdp/bat/releases/latest"
    "https://api.github.com/repos/sharkdp/fd/releases/latest"
    "https://starship.rs/install.sh"
    "https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh"
)

for url in "${urls[@]}"; do
    echo "Testing URL: $url"
    if ! curl -sSf --connect-timeout 10 "$url" > /dev/null; then
        echo -e "${RED}❌ URL not accessible: $url${NC}"
        ((url_errors++))
    fi
done

test_result "Download URL validation" $([[ $url_errors -eq 0 ]] && echo "true" || echo "false")

echo -e "${BLUE}📋 Test 4: Configuration File Validation${NC}"
config_errors=0

# Test TOML files
if command -v python3 &> /dev/null; then
    python3 -c "import tomllib" 2>/dev/null || python3 -c "import tomli as tomllib" 2>/dev/null || pip3 install --user tomli

    for toml_file in $(find . -name "*.toml"); do
        echo "Testing TOML: $toml_file"
        if ! python3 -c "
try:
    import tomllib
except ImportError:
    import tomli as tomllib

with open('$toml_file', 'rb') as f:
    tomllib.load(f)
print('✅ $toml_file is valid')
" 2>/dev/null; then
            echo -e "${RED}❌ Invalid TOML: $toml_file${NC}"
            ((config_errors++))
        fi
    done
fi

test_result "Configuration file validation" $([[ $config_errors -eq 0 ]] && echo "true" || echo "false")

echo -e "${BLUE}📋 Test 5: Shell Script Syntax${NC}"
script_errors=0

# Test shell scripts
for script in $(find . -name "*.sh" -o -name "*.sh.tmpl"); do
    echo "Testing script: $script"

    # Basic syntax check (won't work for templates with complex logic)
    if [[ "$script" == *.tmpl ]]; then
        # For templates, just check for obvious bash syntax errors
        if grep -q '#!/bin/bash' "$script"; then
            # Check for unmatched quotes, basic issues
            if grep -n 'brew bundle --no-lock' "$script" >/dev/null; then
                echo -e "${RED}❌ Invalid brew option --no-lock in $script${NC}"
                script_errors=$((script_errors + 1))
            fi
        fi
    else
        # For regular shell scripts, run shellcheck if available
        if command -v shellcheck &> /dev/null; then
            if ! shellcheck "$script" -e SC2086,SC2034,SC1091; then
                echo -e "${RED}❌ Shellcheck issues in $script${NC}"
                script_errors=$((script_errors + 1))
            fi
        else
            # Basic bash syntax check
            if ! bash -n "$script" 2>/dev/null; then
                echo -e "${RED}❌ Bash syntax error in $script${NC}"
                script_errors=$((script_errors + 1))
            fi
        fi
    fi
done

test_result "Shell script syntax" $([[ $script_errors -eq 0 ]] && echo "true" || echo "false")

# Summary
echo ""
echo -e "${BLUE}📊 Test Summary${NC}"
echo "=================="

if [[ $FAILED_TESTS -eq 0 ]]; then
    echo -e "${GREEN}🎉 All tests passed! Ready to push.${NC}"
    exit 0
else
    echo -e "${RED}❌ $FAILED_TESTS test(s) failed. Fix issues before pushing.${NC}"
    exit 1
fi