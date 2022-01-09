## brew's bash-completion@2 for bash5
#[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# bash completion for github cli
which gh > /dev/null 2>&1 && eval "$(gh completion -s $(basename $SHELL))"

# kubectl / k autocomplete
if which kubectl >/dev/null; then
  source <(kubectl completion $(basename $SHELL))
  alias k=kubectl
  complete -F __start_kubectl k
fi

#which kubens >/dev/null && alias kns=kubens

# eksctl autocomplete
which eksctl > /dev/null && source <(eksctl completion $(basename $SHELL))

alias watch="watch "

which vault >/dev/null && complete -C $(which vault) vault
which terraform >/dev/null && complete -C $(which terraform) terraform

alias tcurl="curl -w \"@$HOME/.curl_timing_format.txt\""

# some more ls aliases
#alias ls='ls --color'
alias ls="lsd"
alias ll='ls -alFh'

function cat {
  if [[ "$1" == *.md ]]; then
    glow $*
  else
    bat $*
  fi
}

yolo() {
    currbranch=$(git branch --show-current)
    if [[ ("$currbranch" = "master") || ("$currbranch" = "main") ]] ; then
        echo "on master. failing on purpose"
        return 1
    fi
    git add .
    git commit -m "$*"
    git push
}
