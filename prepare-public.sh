#!/usr/bin/env bash
set -euo pipefail

# Script to prepare public minimal-dotfiles from private dotfiles
# Creates a clean, anonymized version suitable for public release

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$HOME/Projets/dotfiles"

echo "🚀 Preparing minimal-dotfiles for public release"
echo "================================================="
echo

# Check source exists
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "❌ Source directory not found: $SOURCE_DIR"
    exit 1
fi

echo "📂 Copying files from dotfiles..."
# Copy all files except git directory
rsync -av --exclude='.git' --exclude='node_modules' "$SOURCE_DIR/" "$SCRIPT_DIR/"

echo
echo "🗑️  Removing Claude Code/OpenCode directories..."
rm -rf .claude .opencode dot_claude dot_opencode dot_claude_agents

echo
echo "🗑️  Removing internal documentation..."
# Session summaries
rm -f SESSION_*.md FINAL_*.md EXECUTIVE_*.md

# Agent-specific docs
rm -f AGENTS*.md PARALLELIZATION*.md ROUTING*.md OPENCODE_*.md OPUS45_*.md KILOCODE_*.md

# Implementation docs
rm -f *_IMPLEMENTATION*.md *_COMPLETE*.md *_SUMMARY*.md

# Internal guides
rm -f DUAL_MACHINE*.md BARRIER*.md CUSTOM_PLUGINS*.md PLUGINS*.md

# Memory/KB specifics
rm -f MEMORY_SERVICE*.md MEMORY_BANK*.md KB_*.md MCP_BROWSER*.md

# n8n specifics
rm -f N8N_*.md .n8n-*.md

# Chrome/browser debugging
rm -f CHROME_*.md BROWSERMCP*.md

# Migration guides
rm -f opencode-migration-guide.md TOAST_*.md

# Test/validation reports
rm -f VALIDATION_*.md

echo
echo "🗑️  Removing internal scripts..."
rm -f convert-agents-to-opencode.py
rm -f deploy-opencode-config.sh
rm -f sanitize-for-public.sh
rm -f validate-and-fix-all.sh
rm -rf scripts/migrate-*.sh scripts/upgrade-*.sh scripts/validate-*.sh scripts/backport-*.sh scripts/cleanup-*.sh

echo
echo "📝 Renaming private templates to .example..."
if [[ -f private_dot_env.tmpl ]]; then
    mv private_dot_env.tmpl private_dot_env.tmpl.example
fi
if [[ -f private_dot_ssh/config.tmpl ]]; then
    mv private_dot_ssh/config.tmpl private_dot_ssh/config.tmpl.example
fi

echo
echo "🔄 Performing automatic replacements..."
# Weather location
find . -name "*.tmpl" -type f -exec sed -i '' 's/wttr\.in\/sebastien/wttr.in\/Paris/g' {} \;

# Company references
find . -name "*.tmpl" -type f -exec sed -i '' 's/@microdon\.org/@company.com/g' {} \;
find . -name "*.tmpl" -type f -exec sed -i '' 's/gitlab\.microdon/gitlab.yourcompany.example.com/g' {} \;

# Personal hostname
find . -name "*.tmpl" -type f -exec sed -i '' 's/sebastien-ThinkPad-T14-Gen-1/{{ .chezmoi.hostname }}/g' {} \;

echo
echo "✅ Automated cleanup complete!"
echo
echo "⚠️  Manual steps remaining:"
echo "  1. Edit dot_aliases.tmpl - Remove lines 353-386 (dual-machine section)"
echo "  2. Edit dot_gitconfig.tmpl - Update comments on lines 207-212"
echo "  3. Update README.md - Add exclusions note, mark optional components"
echo "  4. Create INSTALLATION.md and TOOLS.md"
echo "  5. Review all changes with 'git status'"
echo
