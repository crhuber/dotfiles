function code-ui --description 'open directory in vscode'
   ls -t ~/Documents/Development/ | choose | xargs -I {} code ~/Documents/Development/{}
end
