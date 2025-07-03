#!/bin/bash

# dotfiles installation script

DOTFILES_DIR=~/dotfiles

# Function to create symlink
create_link() {
    local src=$1
    local dest=$2
    
    # すでに正しいシンボリックリンクが張られていれば何もしない
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "skip: $dest (already linked)"
        return
    fi
    
    # Check if destination exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up existing $dest to $dest.backup"
        mv "$dest" "$dest.backup"
    fi
    
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"
    
    # Create symlink
    ln -sf "$src" "$dest"
    echo "Created symlink: $dest -> $src"
}

# Claude Code settings
create_link "$DOTFILES_DIR/CLAUDE.md" ~/.claude/CLAUDE.md

echo "Dotfiles installation complete!"