# adds alias for "k" to "kubecolor" with completions
function k --wraps kubectl
    command kubecolor $argv
end
