
function ccat
	bat $argv;
end

# --
function ccurl
	curlie $argv
end

# --
function cs
    argparse 'gh' -- $argv
    or return

    if set -q _flag_gh
        gh search code --limit=200 --owner=goflink $argv
    else
        rg $argv ~/Documents/Development/
    end
end

# --
function ddig
	doggo $argv
end

# --
function ddu
	dust $argv
end

# --
function ffind
	fd $argv;
end

# --
function gl --description 'golinks'
   argparse 'ui' -- $argv
   or return

   if set -q _flag_ui
    curl -s localhost:8998/api/v1/links | jq -r '.[] | "\(.keyword)"' | choose -s 20 -w 20 -c 7287fd | xargs -I % open http://localhost:8998/%
    else
    curl -s localhost:8998/api/v1/links | jq -r '.[] | "\(.keyword)"' | fzf | xargs -I % open http://localhost:8998/%
    end
end

# --
function jb --description 'make a new jira branch from current ticket'
    set TASK_ID (jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled', 'Won\'t Do')"  -a $(jira me) |string split0 | fzf | awk '{print $2}')
    read --prompt "echo 'Branch suffix: $TASK_ID/' " -l branch_suffix
    set BRANCH_NAME "$TASK_ID/$branch_suffix"
    git checkout -b $BRANCH_NAME
end

# --
function ji
	jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled', 'Won\'t Do')"  -a $(jira me)
end

# --
function k --wraps kubectl
    command kubecolor $argv
end

# --
function god
    set -x -g KUBECONFIG "/Users/craig/.kube/config-$argv"
end

# --
function lg
    lazygit
end

# --
function lls
    eza --header -la --git $argv
end

# --
function md --description 'alias for using glow'
    bat -l md $argv
end

# --
function nnano
	hx $argv
end

# --
function prl
    gh search prs --author=@me --state open --json url --jq '.[].url'
end

# --
function rc --description 'repo open in vscode'
   argparse 'ui' -- $argv
   or return

   if set -q _flag_ui
      ls -t ~/Documents/Development/ | choose -s 20 -w 20 -c 7287fd | xargs -I {} code ~/Documents/Development/{}
   else
      ls -t ~/Documents/Development/ | fzf | xargs -I {} code ~/Documents/Development/{}
   end
end

# --
function repo
	open https://github.com/goflink/$argv;
end

# --
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

# --
function sl --description 'slack prs'
   argparse 'ui' -- $argv
   or return

   if set -q _flag_ui
      gh search prs --author=@me --state open --json url,title --jq '.[] | "\(.title) - \(.url)"' | choose -s 20 -w 20 -c 7287fd | pbcopy
    else
      gh search prs --author=@me --state open --json url,title --jq '.[] | "\(.title) - \(.url)"' | fzf | pbcopy
      echo "Copied to clipboard"
   end
end


function ttop
	btop
end

function ttree
    yazi $argv
end

function weather
    # if no args, use berlin
    if test (count $argv) -eq 0
        set argv berlin
    end
    curl wttr.in/$argv
end


function yaml
	bat -l yaml $argv;
end
