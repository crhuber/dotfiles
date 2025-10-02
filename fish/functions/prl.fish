function prl
    gh search prs --author=@me --state open --json url --jq '.[].url'
end
