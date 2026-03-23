# Ask for the administrator password upfront
sudo -v

# Save screenshots into ~/Screenshots/ instead of desktop
mkdir -p ~/Pictures/Screenshots/
sudo defaults write com.apple.screencapture location ~/Pictures/Screenshots/
defaults write com.apple.screencapture location ~/Pictures/Screenshots/

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 9

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Menu bar: hide icons in menus
defaults write -g NSMenuEnableActionImages -bool NO
