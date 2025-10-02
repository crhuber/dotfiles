function ji
	jira issue list --plain --no-headers -q"status not in ('Done', 'Canceled', 'Won\'t Do')"  -a $(jira me)
end
