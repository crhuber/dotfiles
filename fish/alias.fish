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
    set menuItems golinks\npr-select\nrepo-browse\nrepo-code\nrepo-search\nwebsearch
    set reply (echo $menuItems | choose -s 20 -w 20 -c 7287fd)
    switch $reply
        case "golinks"
            g-ui
        case "pr-select"
            prs-ui
        case "repo-browse"
            rb-ui
        case "repo-code"
            rc-ui
        case "repo-search"
            rs-ui
        case "websearch"
            bash websearch --ui
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
    bat -l md $argv
end

function nano
    vi $argv
end

function prl
    gh search prs --author=@me --state open --json url --jq '.[].url'
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
        open http://github.com/goflink/?q=$argv
    else
        gh search repos "$argv" --owner=goflink --archived=false --json name --jq '.[].name' | fzf | pbcopy
        echo "Copied to clipboard"
    end
end

function rs-ui --description 'repo search from ui'
    set query (osascript -e 'text returned of (display dialog "query:" default answer "")')
    open http://github.com/goflink/?q=$query
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

function ttree
    yazi $argv
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function yesterday
    set THINGS_DB ~/Library/Group\ Containers/JLMPQHK86H.com.culturedcode.ThingsMac/ThingsData-WKJC6/Things\ Database.thingsdatabase/main.sqlite
    sqlite3 $THINGS_DB \
        "SELECT title FROM TMTask WHERE status=3 AND stopDate IS NOT NULL AND type=0 AND date(stopDate, 'unixepoch', 'localtime') = date('now', 'localtime', '-1 day') ORDER BY stopDate;"
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
