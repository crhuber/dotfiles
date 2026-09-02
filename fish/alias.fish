# aliases
alias tailscale /Applications/Tailscale.app/Contents/MacOS/Tailscale

# abbreviations
# abbr -a k kubectl

# functions

function ci --description 'Watch GitHub Actions CI for the current (or given) branch/PR, with fzf run selection'
    if not command -q gh
        echo "ci: gh (GitHub CLI) is required" >&2
        return 1
    end

    set -l branch $argv[1]
    if test -z "$branch"
        set branch (git branch --show-current 2>/dev/null)
    end
    if test -z "$branch"
        echo "ci: not on a branch (detached HEAD?) or not in a git repo" >&2
        return 1
    end

    set -l pr_info (gh pr view $branch --json number,url -q '"#\(.number) \(.url)"' 2>/dev/null)
    if test -n "$pr_info"
        echo "PR $pr_info for branch '$branch'"
    else
        echo "No open PR for branch '$branch' — checking CI runs directly"
    end

    set -l tries 0
    set -l runs
    while test $tries -lt 10
        set runs (gh run list --branch $branch --limit 15 \
            --json databaseId,status,conclusion,workflowName,displayTitle,createdAt \
            --jq '.[] | [(.databaseId|tostring), .status, (.conclusion // "-"), .workflowName, .displayTitle, .createdAt] | @tsv' 2>/dev/null)
        if test -n "$runs"
            break
        end
        set tries (math $tries + 1)
        if test $tries -eq 1
            echo "No CI runs found yet for '$branch', waiting for one to start..."
        end
        sleep 3
    end

    if test -z "$runs"
        echo "ci: no CI runs found for branch '$branch'" >&2
        return 1
    end

    set -l run_id
    set -l run_count (count $runs)
    if test $run_count -eq 1
        set run_id (echo $runs[1] | cut -f1)
    else
        if not command -q fzf
            echo "ci: multiple runs found but fzf is not installed; picking the most recent" >&2
            set run_id (echo $runs[1] | cut -f1)
        else
            set -l picked (printf '%s\n' $runs | fzf --delimiter='\t' --with-nth=2,3,4,5,6 \
                --header='status  conclusion  workflow  title  created' \
                --header-first --prompt="Select CI run for '$branch'> ")
            if test -z "$picked"
                echo "ci: no run selected" >&2
                return 1
            end
            set run_id (echo $picked | cut -f1)
        end
    end

    echo "Watching run $run_id..."
    gh run watch $run_id --exit-status
    set -l watch_status $status

    if test $watch_status -ne 0
        echo "Run failed — showing failed logs:"
        gh run view $run_id --log-failed
    else
        echo "Run succeeded."
    end

    return $watch_status
end


function ccat
    bat $argv
end

function ccurl
    curlie $argv
end

function cs
    argparse gh -- $argv
    or return

    if set -q _flag_gh
        gh search code --limit=200 --owner=goflink $argv
    else
        rg -F $argv ~/Documents/Development/
    end
end


function cs-ui
    set query (osascript -e 'text returned of (display dialog "query:" default answer "")')
    if test -z "$query"
        return 1
    end
    open https://github.com/search?q=org%3Agoflink+$query&type=code
end

function ddig
    doggo $argv
end


function ddu
    dust $argv
end

function ffind
    fd $argv
end

function g --description 'golinks'
    set keyword (curl -s localhost:8998/api/v1/links | jq -r '.[] | "\(.keyword)"' | fzf )
    open http://localhost:8998/$keyword
end

function g-ui --description 'golinks from ui'
    set keyword (curl -s localhost:8998/api/v1/links | jq -r '.[] | "\(.keyword)"' | choose -s 20 -w 20 -c 7287fd)
    open http://localhost:8998/$keyword
end

function jb --description 'make a new jira branch from current ticket'
    set task_id (jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled', 'Won\'t Do')"  -a $(jira me) |string split0 | fzf | awk '{print $2}')
    read --prompt "echo 'Branch suffix: $task_id/' " -l branch_suffix
    set BRANCH_NAME "$task_id/$branch_suffix"
    git checkout -b $BRANCH_NAME
end

function ji
    jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled', 'Won\'t Do')" -a $(jira me)
end

function k --wraps kubectl
    command kubecolor $argv
end

function kgd --wraps kubectl
    command kubecolor get deployment $argv --output=yaml
end

function kgp --wraps kubectl
    command kubecolor get pod $argv --output=yaml
end

function kgsvc --wraps kubectl
    command kubecolor get service $argv --output=yaml
end

function kgsec --wraps kubectl
    command kubecolor get secret $argv --output=yaml
end

function god
    set -x -g KUBECONFIG "/Users/craig/.kube/config-$argv"
end

function launcher
    set menuItems code-search\ngolinks\npr-list\npr-select\nrepo-browse\nrepo-code\nrepo-search\nws
    set reply (echo $menuItems | choose -s 20 -w 20 -c 7287fd)
    switch $reply
        case "code-search"
            cs-ui
        case "golinks"
            g-ui
        case "pr-list"
            prl-ui
        case "pr-select"
            prs-ui
        case "repo-browse"
            rb-ui
        case "repo-code"
            rc-ui
        case "repo-search"
            rs-ui
        case "ws"
            bash ws --ui
        case "*"
            echo "Invalid selection"
    end
end

function lg
    lazygit
end

function lls
    eza --header -la --git $argv
end

function md --description 'alias for using glow'
    mdterm $argv
end

function nano
    vi $argv
end

function prl
    gh search prs --author=@me --state open --json url --jq '.[].url'
end

function prl-ui
    open https://github.com/pulls/authored
end

function push
    git add .
    git commit -m "$argv"
    git push
end

function rb-ui --description 'repo open in browser'
    set repo (osascript -e 'text returned of (display dialog "repo:" default answer "")')
    open https://github.com/goflink/$repo
end

function rc --description 'repo open in vscode'
    set folder (ls -t ~/Documents/Development/ | fzf )
    set action (echo -e "edit\nchange-dir" | fzf)
    if test "$action" = edit
        set editor (echo -e "vi\ncode" | fzf)
        if test "$editor" = vi
            vi ~/Documents/Development/$folder
        else if test "$editor" = code
            code ~/Documents/Development/$folder
        else
            echo "unsupported editor"
        end
    else if test "$action" = change-dir
        cd ~/Documents/Development/$folder
    else
        echo "unsupported action"
    end
end

function rc-ui --description 'repo open in vscode with choose'
  set folder (ls -t ~/Documents/Development/ | choose -s 20 -w 20 -c 7287fd)
  if test -n "$folder"
      code ~/Documents/Development/$folder
  end
end


function repo
    open https://github.com/goflink/$argv
end


function rs --description 'repo search'
    argparse w/web -- $argv
    or return

    if set -q _flag_web
        open https://github.com/search?q=org%3Agoflink+$argv&type=repositories
    else
        gh search repos "$argv" --owner=goflink --archived=false --json name --jq '.[].name' | fzf | pbcopy
        echo "Copied to clipboard"
    end
end

function rs-ui --description 'repo search from ui'
    set query (osascript -e 'text returned of (display dialog "repo:" default answer "")')
    open https://github.com/search?q=org%3Agoflink+$query&type=repositories
end


function prs --description 'pr select and copy'
    gh search prs --author=@me --state open --json url,title --jq '.[] | "\(.title) - \(.url)"' | fzf | pbcopy
    echo "Copied to clipboard"
end

function prs-ui --description 'pr select and copy from ui'
    gh search prs --author=@me --state open --json url,title --jq '.[] | "\(.title) - \(.url)"' | choose -s 20 -w 20 -c 7287fd | pbcopy
end

function ttop
    btop
end

function tree
    eza --tree $argv
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function weather
    # if no args, use berlin
    if test (count $argv) -eq 0
        set argv berlin
    end
    curl wttr.in/$argv
end

function yaml
    bat -l yaml $argv
end
