function jb --description 'make a new jira branch from current ticket'
   set TASK_ID (jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled', 'Won\'t Do')"  -a $(jira me) |string split0 | fzf | cut -f2)	
   set BRANCH_NAME "$TASK_ID/$argv"
   echo $BRANCH_NAME
end
