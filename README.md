## dotfiles
🚀 Installation on a new system
```bash
curl -Lks https://raw.githubusercontent.com/nebiyuelias1/dotfiles/main/install.sh | bash
```
🛠️ Usage
Add a new configuration file
Because we ignore untracked files by default (status.showUntrackedFiles no), you must explicitly add new files:
```bash
dotfiles add .config/omarchy/hooks/theme-set
```
Update an existing configuration
Just use standard git commands!
```bash
dotfiles status
dotfiles add .config/hypr/hyprland.conf
dotfiles commit -m "Update window rules"
dotfiles push
```
