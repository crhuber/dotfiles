function rs --description 'repo search'
   argparse 'w/web' 'ui' -- $argv
   or return
   if set -q _flag_ui
      cat ~/Documents/Scripts/flink-repos.txt | choose -s 20 -w 20 -c 7287fd | xargs -I {} open "https://github.com/goflink/{}"
   else
      if set -q _flag_web
         open http://github.com/goflink/?q=$argv
      else
         gh search repos "$argv" --owner=goflink --archived=false  --json name --jq '.[].name' | fzf | pbcopy
         echo "Copied to clipboard"
      end
   end
end
