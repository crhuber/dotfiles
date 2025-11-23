function gl --description 'golinks'
   argparse 'ui' -- $argv
   or return

   if set -q _flag_ui
    curl -s localhost:8998/api/v1/links | jq -r '.[] | "\(.keyword)"' | choose -s 20 -w 20 -c 7287fd | xargs -I % open http://localhost:8998/%
    else
    curl -s localhost:8998/api/v1/links | jq -r '.[] | "\(.keyword)"' | fzf | xargs -I % open http://localhost:8998/%
    end
end
