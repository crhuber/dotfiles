# add aliases and functions
source $HOME/.config/fish/alias.fish

# editors
set -gx EDITOR hx
set -gx KUBE_EDITOR 'code --wait'
# fzf - tokyonight theme
set -gx FZF_DEFAULT_OPTS "--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7 --color=fg+:#c0caf5,bg+:#1f2335,hl+:#7dcfff --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
set -gx FZF_CTRL_T_OPTS "--walker-skip .git,node_modules,target --preview 'bat -n --color=always {}'"
# my tools
set -gx GOLINKS_DB $HOME/.golinks/golinks.db
set -gx KELP_CONFIG $HOME/.dotfiles/kelp/kelp-work.json
set -gx K9S_CONFIG_DIR $HOME/.config/k9s
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN true
# homebrew
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
# go
set -gx GOPATH "$HOME/go"

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    # direnv
    direnv hook fish | source
    # starship
    starship init fish | source
    # mise
    mise activate fish | source
    # fzf
    fzf --fish | source
    # crumb
    crumb hook --shell fish | source
    # greeting
    function fish_greeting
        fastfetch
    end
end
