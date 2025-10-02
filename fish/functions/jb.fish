function jb --description 'make a new jira branch from current ticket'
    set TASK_ID (jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled', 'Won\'t Do')"  -a $(jira me) |string split0 | fzf | awk '{print $2}')
    read --prompt "echo 'Branch suffix: $TASK_ID/' " -l branch_suffix
    set BRANCH_NAME "$TASK_ID/$branch_suffix"
    git checkout -b $BRANCH_NAME
end
