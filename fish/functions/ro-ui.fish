function rc --description 'repo open in vscode'
   argparse 'ui' -- $argv
   or return

   if set -q _flag_ui
      ls -t ~/Documents/Development/ | choose | xargs -I {} code ~/Documents/Development/{}
   else
      ls -t ~/Documents/Development/ | fzf | xargs -I {} code ~/Documents/Development/{}
   end
end
