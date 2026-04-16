# Default task: setup and link
setup: install-tools link

# Install/Update all tools from Brewfile
install-tools:
    brew bundle install --file=Brewfile

# Link configuration files (idempotent and dynamic)
link:
    ./scripts/link_configs.sh

# Update Neovim nightly (macOS)
update-nvim:
    ./scripts/install_nvim_nightly_macos.sh

# Update all or specific tool
# Usage: 
#   just update         # Update everything (bundle + nvim + link)
#   just update deno    # Update only deno via brew
update name="all":
    @if [ "{{name}}" = "all" ]; then \
        just install-tools; \
        just update-nvim; \
        just link; \
    else \
        echo "Updating {{name}} via brew..."; \
        brew upgrade {{name}} || brew install {{name}}; \
    fi

# Sync configurations only (shorthand for link)
sync: link

# Help
help:
    @just --list
