# Default task: install and link
sync: link (update "all")

# Install/Update all tools from Brewfile
install-tools:
    brew bundle install --file=Brewfile
    proto install --config-mode global
    just update-nvim

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
    elif [ "{{name}}" = "neovim" ]; then \
        just update-nvim; \
    else \
        echo "Updating {{name}} via brew..."; \
        brew upgrade {{name}} || brew install {{name}}; \
    fi

# Help
help:
    @just --list
