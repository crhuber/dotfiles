function cs
    argparse 'gh' -- $argv
    or return

    if set -q _flag_gh
        gh search code --limit=200 --owner=goflink $argv
    else
        rg $argv ~/Documents/Development/
    end
end
