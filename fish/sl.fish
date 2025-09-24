function sl --description 'slack prs'
   argparse 'ui' -- $argv
   or return

   if set -q _flag_ui
      gh search prs --author=@me --state open --json url,title --jq '.[] | "\(.title) - \(.url)"' | choose | pbcopy
    else
      gh search prs --author=@me --state open --json url,title --jq '.[] | "\(.title) - \(.url)"' | fzf | pbcopy
      echo "Copied to clipboard"
   end
end
