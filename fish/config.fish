if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    # direnv
    direnv hook fish | source
    # starship
    starship init fish | source
    # mise
    mise activate fish | source
    # fish
    fzf --fish | source
    # greeting
    function fish_greeting
        fastfetch
    end
end
