#!/bin/bash
# Chezmoi Three-Location Sync Helper Functions
# Addresses the critical pattern where edits in ~/projects/dotfiles/ are lost
# because chezmoi reads from ~/.local/share/chezmoi/

# Complete three-location sync for dotfiles
dotfiles_sync() {
    echo "  Starting three-location dotfiles sync..."
    echo "   1. Git repo: ~/projects/dotfiles/"
    echo "   2. Chezmoi source: ~/.local/share/chezmoi/"
    echo "   3. Local configs: ~/.config/, ~/.*"
    echo ""

    # Step 1: Commit in git repo if there are changes
    cd ~/projects/dotfiles
    if [[ -n $(git status -s) ]]; then
        echo "📝 Committing changes in git repo..."
        git add -A
        git commit -m "sync: dotfiles update $(date +%Y-%m-%d_%H-%M-%S)"
        git push
    else
        echo "  Git repo is clean"
    fi

    # Step 2: Pull in chezmoi source
    echo "📥 Pulling changes to chezmoi source..."
    cd ~/.local/share/chezmoi
    git pull --ff-only || {
        echo "   Git pull failed. Attempting reset to origin/main..."
        git reset --hard origin/main
    }

    # Step 3: Apply changes
    echo "  Applying chezmoi changes..."
    chezmoi apply --force

    # Step 4: Verify synchronization
    echo ""
    echo "  Verifying synchronization..."
    if diff -rq ~/projects/dotfiles ~/.local/share/chezmoi > /dev/null 2>&1; then
        echo "  All three locations synchronized successfully!"
    else
        echo "   Warning: Some files may differ between git repo and chezmoi source"
        echo "   Files that differ:"
        diff -rq ~/projects/dotfiles ~/.local/share/chezmoi 2>/dev/null | grep differ | head -5
    fi
}

# Sync Neovim configuration specifically
nvim_sync() {
    echo "  Syncing Neovim configuration across all locations..."

    # Check for changes in git repo
    cd ~/projects/dotfiles
    if [[ -n $(git status -s dot_config/nvim/) ]]; then
        echo "📝 Committing Neovim config changes..."
        git add dot_config/nvim/
        git commit -m "sync: neovim configuration update"
        git push
    fi

    # Pull in chezmoi source
    cd ~/.local/share/chezmoi
    git pull --ff-only

    # Apply
    chezmoi apply --force

    # Verify Neovim configs specifically
    echo "  Verifying Neovim sync..."
    if diff -rq ~/projects/dotfiles/dot_config/nvim ~/.local/share/chezmoi/dot_config/nvim > /dev/null 2>&1; then
        echo "  Neovim configs synchronized!"
    else
        echo "  Neovim configs differ! Files:"
        diff -rq ~/projects/dotfiles/dot_config/nvim ~/.local/share/chezmoi/dot_config/nvim | grep differ
    fi

    # Test Neovim startup
    nvim --headless "+q" 2>&1
    if [ $? -eq 0 ]; then
        echo "  Neovim starts without errors"
    else
        echo "  Neovim has startup errors - check config"
    fi
}

# Check dotfiles sync status
check_dotfiles_sync() {
    echo "=== Dotfiles Three-Location Sync Status ==="
    echo ""

    # Check git repo status
    cd ~/projects/dotfiles
    local git_repo_commit=$(git log -1 --oneline)
    echo "📂 Git Repo (~/projects/dotfiles/):"
    echo "   $git_repo_commit"

    # Check chezmoi source
    cd ~/.local/share/chezmoi
    local chezmoi_source_commit=$(git log -1 --oneline)
    echo "📂 Chezmoi Source (~/.local/share/chezmoi/):"
    echo "   $chezmoi_source_commit"

    # Compare commits
    echo ""
    if [[ "$(cd ~/projects/dotfiles && git rev-parse HEAD)" == \
          "$(cd ~/.local/share/chezmoi && git rev-parse HEAD)" ]]; then
        echo "  Git repo and chezmoi source: IN SYNC"
    else
        echo "  Git repo and chezmoi source: OUT OF SYNC"
        echo "      Chezmoi will use the OUTDATED version from ~/.local/share/chezmoi/"
        echo "   Fix: cd ~/.local/share/chezmoi && git pull"
    fi

    # Check for uncommitted changes
    cd ~/projects/dotfiles
    if [[ -n $(git status -s) ]]; then
        echo ""
        echo "   Uncommitted changes in git repo:"
        git status -s | head -5
        echo "   These changes won't be applied until committed and synced!"
    fi
}

# Find files that differ between locations
find_divergent_files() {
    echo "=== Finding Divergent Files ==="
    echo ""
    echo "Files that differ between git repo and chezmoi source:"
    diff -rq ~/projects/dotfiles ~/.local/share/chezmoi 2>/dev/null | \
        grep -v ".git" | grep differ | while read line; do
        echo "  📄 $line"
    done

    echo ""
    echo "Files only in git repo (not in chezmoi source):"
    diff -rq ~/projects/dotfiles ~/.local/share/chezmoi 2>/dev/null | \
        grep "Only in.*dotfiles" | while read line; do
        echo "  ➕ $line"
    done

    echo ""
    echo "Files only in chezmoi source (not in git repo):"
    diff -rq ~/projects/dotfiles ~/.local/share/chezmoi 2>/dev/null | \
        grep "Only in.*chezmoi" | while read line; do
        echo "  ➖ $line"
    done
}

# Emergency fix for configuration loss
fix_config_loss() {
    echo "  Emergency Configuration Recovery"
    echo ""
    echo "This will force-sync from the git repository to all locations."
    echo "Press Ctrl+C to cancel, or Enter to continue..."
    read

    # Step 1: Ensure git repo is up to date
    cd ~/projects/dotfiles
    git pull

    # Step 2: Force reset chezmoi source
    cd ~/.local/share/chezmoi
    echo "  Resetting chezmoi source to match remote..."
    git fetch origin
    git reset --hard origin/main

    # Step 3: Force apply all changes
    echo "  Force-applying all configurations..."
    chezmoi apply --force

    # Step 4: Verify
    echo ""
    check_dotfiles_sync

    echo ""
    echo "  Emergency recovery complete!"
    echo "   All locations should now be synchronized."
}

# Quick status check (for prompt/alias)
dotfiles_status() {
    if [[ "$(cd ~/projects/dotfiles 2>/dev/null && git rev-parse HEAD 2>/dev/null)" == \
          "$(cd ~/.local/share/chezmoi 2>/dev/null && git rev-parse HEAD 2>/dev/null)" ]]; then
        echo " "
    else
        echo "  SYNC"
    fi
}

# Help function
chezmoi_help() {
    cat << EOF
=== Chezmoi Three-Location Sync Commands ===

The THREE locations that must stay in sync:
  1. Git repo: ~/projects/dotfiles/ (where you edit)
  2. Chezmoi source: ~/.local/share/chezmoi/ (where chezmoi reads)
  3. Local configs: ~/.config/, ~/.* (what applications use)

Commands:
  dotfiles_sync          - Complete three-location synchronization
  nvim_sync             - Sync Neovim configuration specifically
  check_dotfiles_sync   - Check sync status between locations
  find_divergent_files  - Find files that differ between locations
  fix_config_loss       - Emergency recovery when config is lost
  dotfiles_status       - Quick status (for prompts/scripts)

Common workflow:
  1. Edit files in ~/projects/dotfiles/
  2. Run: dotfiles_sync
  3. Test your application

If changes are lost after 'chezmoi apply':
  Your edits were only in ~/projects/dotfiles/ but chezmoi
  reads from ~/.local/share/chezmoi/ which was outdated.
  Run: dotfiles_sync to fix this.

EOF
}

# Functions are automatically available when sourced
# No need to export in zsh/bash when sourced directly