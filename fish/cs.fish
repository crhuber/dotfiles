function cs
    argparse 'ui' -- $argv
    or return

    if set -q _flag_ui
        gh search code --limit=200 --owner=goflink $argv
    else
        rg $argv ~/Documents/Development/
    end
end
