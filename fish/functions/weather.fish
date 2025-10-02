function weather
    # if no args, use berlin
    if test (count $argv) -eq 0
        set argv berlin
    end
    curl wttr.in/$argv
end
