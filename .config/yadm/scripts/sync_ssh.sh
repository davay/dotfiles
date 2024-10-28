#!/bin/bash

# Script for syncing development environment to AlmaLinux servers
# Configures Zsh, Oh My Zsh, and Neovim

# Configuration
REMOTE_USER="your_username"
REMOTE_HOST="your_remote_host"
REMOTE_CONNECTION="${REMOTE_USER}@${REMOTE_HOST}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper function for logging
log() {
    echo -e "${GREEN}[*]${NC} $1"
}

error() {
    echo -e "${RED}[!]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Check if remote host is reachable
check_connection() {
    log "Checking connection to ${REMOTE_CONNECTION}..."
    if ! ssh -q "${REMOTE_CONNECTION}" exit; then
        error "Cannot connect to ${REMOTE_CONNECTION}"
        exit 1
    fi
}

# Install Zsh and Oh My Zsh on remote
install_zsh() {
    log "Installing Zsh and Oh My Zsh..."
    
    # Install zsh
    ssh "${REMOTE_CONNECTION}" '
        if ! command -v zsh &> /dev/null; then
            sudo dnf install -y zsh
        fi
    '
    
    # Install Oh My Zsh
    ssh "${REMOTE_CONNECTION}" '
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        fi
    '
    
    # Set Zsh as default shell using usermod
    ssh "${REMOTE_CONNECTION}" 'sudo usermod -s $(which zsh) $USER'
}

# Sync Zsh configuration
sync_zsh() {
    log "Syncing Zsh configuration..."
    
    # Create backup of existing config
    # ssh ${REMOTE_CONNECTION} 'cp ~/.zshrc ~/.zshrc.backup 2>/dev/null || true'
    
    # Sync .zshrc
    rsync -av ~/.zshrc_portable "${REMOTE_CONNECTION}:~/.zshrc"
    
    # Sync custom Oh My Zsh files if they exist
    if [ -d ~/.oh-my-zsh/custom ]; then
        rsync -av ~/.oh-my-zsh/custom/ "${REMOTE_CONNECTION}:~/.oh-my-zsh/custom/"
    fi
}

# Install Neovim on remote
install_neovim() {
    log "Installing Neovim..."
    
    ssh "${REMOTE_CONNECTION}" '
        if ! command -v nvim &> /dev/null; then
            sudo dnf install -y neovim
        fi
    '
}

# Sync Neovim configuration
sync_neovim() {
    log "Syncing Neovim configuration..."
    
    # Create necessary directories
    ssh "${REMOTE_CONNECTION}" 'mkdir -p ~/.config/nvim'
    
    # Sync Neovim config
    rsync -av ~/.config/nvim/ "${REMOTE_CONNECTION}:~/.config/nvim/"
    #
    # # Sync Neovim data directory (plugins, etc.)
    # rsync -av ~/.local/share/nvim/ ${REMOTE_CONNECTION}:~/.local/share/nvim/
}

# Install Rust and development tools on remote
install_rust() {
    log "Installing Rust..."
    
    ssh "${REMOTE_CONNECTION}" '
        if ! command -v cargo &> /dev/null; then
            curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source "$HOME/.cargo/env"
        fi
    '
}

install_rust_tools() {
    log "Installing Rust packages..."
    
    ssh "${REMOTE_CONNECTION}" '
        source "$HOME/.cargo/env"
        
        RUST_PACKAGES=("bat" "lsd")
        
        for package in "${RUST_PACKAGES[@]}"; do
            if ! command -v "$package" &> /dev/null; then
                cargo install "$package"
            fi
        done
    '
}
# Main execution
main() {
    # Check arguments
    if [ "$#" -eq 0 ]; then
        error "Please provide remote host details"
        echo "Usage: $0 username@hostname"
        exit 1
    fi
    
    # Set remote connection from argument
    REMOTE_CONNECTION="$1"
    
    # Run all steps
    check_connection
    install_zsh
    sync_zsh
    install_neovim
    sync_neovim
    install_rust
    install_rust_tools
    
    log "Configuration sync completed!"
    warning "Please log out and back in for changes to take effect"
}

# Run the script
main "$@"
