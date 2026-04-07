#!/bin/bash
# Define your repo URL here
REPO_URL="https://github.com/nebiyuelias1/dotfiles.git"
DOTFILES_DIR="$HOME/git/dotfiles"
echo "🚀 Starting Omarchy dotfiles installation..."
# 1. Ensure the git directory exists and clone the bare repo
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📦 Cloning bare repository..."
    mkdir -p "$DOTFILES_DIR"
    git clone --bare "$REPO_URL" "$DOTFILES_DIR"
else
    echo "✅ Git repository already exists at $DOTFILES_DIR"
fi
# 2. Define the alias temporarily for this script
function dotfiles {
   /usr/bin/git --git-dir="$DOTFILES_DIR/" --work-tree="$HOME" "$@"
}
# 3. Configure the repo to ignore untracked files
dotfiles config --local status.showUntrackedFiles no
# 4. Checkout the files
echo "🔄 Checking out files..."
if dotfiles checkout; then
    echo "✅ Checked out dotfiles successfully."
else
    echo "⚠️  Conflict detected. Backing up pre-existing dotfiles..."
    # If Omarchy created default configs that conflict, back them up
    mkdir -p "$HOME/.dotfiles-backup"
    dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | while read -r file; do
        if [ -f "$HOME/$file" ] || [ -d "$HOME/$file" ]; then
            echo "Backing up $file to .dotfiles-backup/$file"
            mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
            mv "$HOME/$file" "$HOME/.dotfiles-backup/$file"
        fi
    done
    
    # Try checkout again
    dotfiles checkout
    echo "✅ Checked out dotfiles after backing up conflicts."
fi
# 5. Add the alias to your shell profile so it's always available
if ! grep -q "alias dotfiles=" "$HOME/.bashrc"; then
    echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/git/dotfiles/ --work-tree=$HOME'" >> "$HOME/.bashrc"
    echo "✅ Added 'dotfiles' alias to ~/.bashrc"
fi

# 6. Install Oh My Zsh unattended if it doesn't already exist
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 7. Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# 6. Install Plugins
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

echo "Zsh setup complete! Now symlink your .zshrc and .p10k.zsh from your dotfiles."
