#https://opensource.com/article/18/3/creating-bash-completion-script
# add the following options to login script
#complete -W "now tomorrow never" identity

completions()
{
  if [ "$COMP_CWORD" == "1" ]; then
    # completion reply list
    COMPREPLY=($(compgen -W "lipa skadush" "${COMP_WORDS[COMP_CWORD]}"))
  elif [ "$COMP_CWORD" == "2" ]; then
    if [ "${COMP_WORDS[1]}" == "lipa" ]; then
      COMPREPLY=($(compgen -W "eks-dev-env-developer eks-dev-env-operator eks-dev-env-cluster-operator" "${COMP_WORDS[COMP_CWORD]}"))
    elif [  "${COMP_WORDS[1]}" == "skadush"  ]; then
      COMPREPLY=($(compgen -W "minenhle" "${COMP_WORDS[COMP_CWORD]}"))
    fi
  fi
}

complete -F completions identity